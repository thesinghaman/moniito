import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '/home_menu.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/text_strings.dart';
import '/utils/helpers/network_manager.dart';
import '/utils/popups/full_screen_loader.dart';
import '/utils/popups/loaders.dart';
import '/utils/constants/enums.dart';
import '/utils/constants/sizes.dart';
import '/data/repositories/transaction/transaction_repository.dart';
import '/data/repositories/user/user_repository.dart';
import '/features/app/models/transaction_model.dart';

// Controller for managing transactions
class TransactionController extends GetxController {
  // Singleton instance of TransactionController
  static TransactionController get instance => Get.find();

  // Repositories
  final userRepository = Get.put(UserRepository());
  final transactionRepository = Get.put(TransactionRepository());

  // Text editing controllers
  final TextEditingController amount = TextEditingController();
  final TextEditingController transactionTitle = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  // Observables
  Rx<String> selectedCategory = ''.obs;
  RxList<MapEntry<String, String>> filteredCategories =
      <MapEntry<String, String>>[].obs;
  Rx<XFile> image = XFile('').obs;
  Rx<bool> isExpense = true.obs;
  Rx<bool> isIncome = false.obs;
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxList<TransactionModel> transactionsByDate = <TransactionModel>[].obs;
  RxList<TransactionModel> transactionsByMonth = <TransactionModel>[].obs;
  RxList<TransactionModel> transactionsByYear = <TransactionModel>[].obs;

  // Form Keys
  final addTransactionFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Initialize filtered categories on controller initialization
    filteredCategories.value = categories.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    // Fetch user transactions on controller initialization
    fetchUserTransactions();
  }

  // Set image file
  void setImage(XFile imageFile) {
    image.value = imageFile;
  }

  // Clear selected image
  void clearImage() {
    image.value = XFile('');
  }

  // Save user transactions
  Future<void> saveUserTransactions() async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
          'Saving Transaction...', AImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addTransactionFormKey.currentState!.validate()) {
        // Remove Loader
        AFullScreenLoader.stopLoading();
        return;
      }

      String imageUrl = '';
      // Check if there's an image to upload
      if (image.value.path.isNotEmpty) {
        imageUrl = await uploadReceiptImage();
      }

      if (imageUrl == '') {
        // Remove Loader
        AFullScreenLoader.stopLoading();
        return;
      }

      // Remove thousands separator and convert to plain number string
      final amountValue =
          amount.text.toString().replaceAll(RegExp(r'[^\d.]'), '');

      // Create TransactionModel
      TransactionModel newTransaction = TransactionModel(
        amount: amountValue,
        transactionTitle: transactionTitle.text.toString(),
        isExpense: isExpense.value,
        category: selectedCategory.value,
        receiptImage: imageUrl,
        description: description.value.text.toString(),
        date: date.text.toString(),
      );

      // Fetch user details
      final user = await userRepository.fetchUserDetails();

      // Save transaction
      final transactionId =
          await transactionRepository.saveTransaction(user, newTransaction);

      // Update Transaction ID
      newTransaction.id = transactionId;

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Redirect to HomeScreen if Transaction is Saved Successfully.
      Get.offAll(() => const HomeMenu());
    } catch (e) {
      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      ALoaders.errorSnackBar(title: ATexts.errorText, message: e.toString());
    }
  }

  // Pick image from source
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          ),
        ],
      );

      // If cropping successful, set image
      if (croppedFile != null) {
        final croppedFilePath = croppedFile.path;
        final xFile = XFile(croppedFilePath);
        setImage(xFile);
      }
    }
  }

  // Upload receipt image
  Future<String> uploadReceiptImage() async {
    try {
      // Upload Image
      final imageUrl = await transactionRepository.uploadReceiptImage(
          'Users/Images/ReceiptImages/', image.value);

      return imageUrl;
    } catch (e) {
      // Show error snack bar if upload fails
      ALoaders.errorSnackBar(
          title: 'Oh Snap', message: 'Something went wrong : $e');
    }
    return '';
  }

  void filterCategories(String text) {
    filteredCategories.value = categories.entries
        .where(
            (entry) => entry.value.toLowerCase().contains(text.toLowerCase()))
        .toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    if (filteredCategories.isEmpty) {
      filteredCategories.value = [
        const MapEntry("miscellaneous", 'Miscellaneous')
      ];
    }
  }

  void fetchUserTransactions() async {
    try {
      // Fetch user details
      final user = await userRepository.fetchUserDetails();

      // Listen to transactions stream
      transactionRepository.getTransactions(user.id).listen((transactionList) {
        transactions.value = transactionList;

        // Update sorted transactions
        sortTransactionsByDate();
        sortTransactionsByMonth();
        sortTransactionsByYear();
      });
    } catch (e) {
      // Log the error or show a snackbar/message to the user
      ALoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to fetch transactions: ${e.toString()}',
      );
    }
  }

  // Sort transactions by date
  void sortTransactionsByDate() {
    final dateFormat = DateFormat('dd MMM, yyyy');
    transactionsByDate.value = transactions.toList()
      ..sort((b, a) {
        var dateA = dateFormat.parse(a.date);
        var dateB = dateFormat.parse(b.date);
        return dateA.compareTo(dateB);
      });
  }

  // Sort transactions by month
  void sortTransactionsByMonth() {
    final dateFormat = DateFormat('dd MMM, yyyy');
    transactionsByMonth.value = transactions.toList()
      ..sort((b, a) {
        var monthA = dateFormat.parse(a.date).month;
        var monthB = dateFormat.parse(b.date).month;
        return monthA.compareTo(monthB);
      });
  }

  // Sort transactions by year
  void sortTransactionsByYear() {
    final dateFormat = DateFormat('dd MMM, yyyy');
    transactionsByYear.value = transactions.toList()
      ..sort((b, a) {
        var yearA = dateFormat.parse(a.date).year;
        var yearB = dateFormat.parse(b.date).year;
        return yearA.compareTo(yearB);
      });
  }

  /// Delete Account Warning Pop-Up
  void deleteTransactionWarningPopup(String transactionId) {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(ASizes.md),
        title: 'Delete Transaction',
        middleText:
            'Are you sure you want to delete this transaction ? This action is not reversible.',
        confirm: ElevatedButton(
          onPressed: () async => deleteTransaction(transactionId),
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: ASizes.lg),
              child: Text('Delete')),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  void deleteTransaction(String transactionId) async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
          'Deleteing Transaction...', AImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        AFullScreenLoader.stopLoading();
        return;
      }
      transactionRepository.removeTransaction(transactionId);
      AFullScreenLoader.stopLoading();
      Get.offAll(() => const HomeMenu());
    } catch (e) {
      // Log the error or show a snackbar/message to the user
      ALoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to fetch transactions: ${e.toString()}',
      );
    }
  }
}
