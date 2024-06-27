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
import '/utils/constants/colors.dart';
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
  TextEditingController amount = TextEditingController();
  TextEditingController transactionTitle = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  // Observables
  Rx<String> selectedCategory = ''.obs;
  Rx<String> receiptImageUrl = ''.obs;
  RxList<MapEntry<String, String>> filteredCategories =
      <MapEntry<String, String>>[].obs;
  Rx<XFile> image = XFile('').obs;
  Rx<bool> isExpense = true.obs;
  Rx<bool> isIncome = false.obs;
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxList<TransactionModel> transactionsByDate = <TransactionModel>[].obs;
  RxList<TransactionModel> transactionsByMonth = <TransactionModel>[].obs;
  RxList<TransactionModel> transactionsByYear = <TransactionModel>[].obs;
  Rx<String> totalExpense = ''.obs;

  // Form Keys
  final addTransactionFormKey = GlobalKey<FormState>();
  final editTransactionFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Initialize filtered categories on controller initialization
    filteredCategories.value = categories.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    // Fetch user transactions on controller initialization
    fetchUserTransactions();
  }

  /// Clear all fields.
  void clearFormFields() {
    amount.clear();
    transactionTitle.clear();
    description.clear();
    date.clear();
    categoryController.clear();
    selectedCategory.value = '';
    receiptImageUrl.value = '';
    isExpense.value = true;
    isIncome.value = false;
    clearImage();
  }

  /// Set image file
  void setImage(XFile imageFile) {
    image.value = imageFile;
  }

  /// Clear selected image
  void clearImage() {
    image.value = XFile('');
  }

  /// Function to filter categories based on a search text
  void filterCategories(String text) {
    // Filter the categories based on the search text (case-insensitive)
    filteredCategories.value = categories.entries
        .where(
            (entry) => entry.value.toLowerCase().contains(text.toLowerCase()))
        .toList()
      // Sort the filtered categories alphabetically
      ..sort((a, b) => a.value.compareTo(b.value));

    // If no categories match the search text, add a default category
    if (filteredCategories.isEmpty) {
      filteredCategories.value = [
        const MapEntry("miscellaneous", 'Miscellaneous')
      ];
    }
  }

  /// Pick image from source
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AColors.primary,
            toolbarWidgetColor: AColors.white,
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

  /// Function to show a delete warning popup dialog
  void deleteWarningPopup(
      String title, String middleText, VoidCallback onConfirm) {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(ASizes.md),
        title: title,
        middleText: middleText,
        confirm: ElevatedButton(
          onPressed: onConfirm,
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: ASizes.lg),
              child: Text('Delete')),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  /// Save user transactions
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

      // Check if there's an image to upload
      if (image.value.path.isNotEmpty) {
        await uploadReceiptImage();
      }

      if (receiptImageUrl.value == '' && image.value.path.isNotEmpty) {
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
        receiptImage: receiptImageUrl.value,
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

  /// Function to edit the transaction of specified Id.
  Future<void> editTransaction(TransactionModel transaction) async {
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
      if (!editTransactionFormKey.currentState!.validate()) {
        // Remove Loader
        AFullScreenLoader.stopLoading();
        return;
      }

      // If new receipt image is selected, upload that one and if previous receipt image exist, delete it.
      if (image.value.path.isNotEmpty) {
        await uploadReceiptImage();

        if (transaction.receiptImage.isNotEmpty) {
          await deleteReceiptImage(transaction.receiptImage);
        }
      }

      // If new receipt image is not uploaded properly, show error and return
      if (receiptImageUrl.value == '' && image.value.path.isNotEmpty) {
        // Remove Loader
        AFullScreenLoader.stopLoading();
        return;
      }

      // Remove thousands separator and convert to plain number string
      final amountValue =
          amount.text.toString().replaceAll(RegExp(r'[^\d.]'), '');

      // Create Transaction Model
      final updatedTransaction = TransactionModel(
        id: transaction.id,
        transactionTitle: transactionTitle.text,
        amount: amountValue,
        isExpense: isExpense.value,
        category: selectedCategory.value,
        receiptImage: receiptImageUrl.value,
        description: description.text,
        date: date.text.toString(),
      );

      // Update transaction
      updateTransaction(updatedTransaction);

      // Remove Loader
      AFullScreenLoader.stopLoading();
    } catch (e) {
      // Remove Loader
      AFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      ALoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to update transaction: ${e.toString()}',
      );
    }
  }

  /// Function to delete the transaction
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

      // Delete the transaciton of the given ID
      transactionRepository.deleteTransaction(transactionId);

      // Stop Loading
      AFullScreenLoader.stopLoading();

      // Return to Home Page
      Get.offAll(() => const HomeMenu());
    } catch (e) {
      // Stop Loading
      AFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      ALoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to fetch transactions: ${e.toString()}',
      );
    }
  }

  /// Function to fetch all the transacitons of a user
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

        // Calculate total Expense
        calculateTotalExpense();
      });
    } catch (e) {
      // Show some Generic Error to the user
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

  /// Upload receipt image
  Future<void> uploadReceiptImage() async {
    try {
      // Upload Image
      receiptImageUrl.value = await transactionRepository.uploadReceiptImage(
          'Users/Images/ReceiptImages/', image.value);
    } catch (e) {
      // Show some Generic Error to the user
      ALoaders.errorSnackBar(title: ATexts.errorText, message: e.toString());
    }
  }

  /// Delete receipt image
  Future<void> deleteReceiptImage(String imageUrl) async {
    try {
      // Delete Image
      await transactionRepository.deleteReceiptImage(imageUrl);
    } catch (e) {
      // Show some Generic Error to the user
      ALoaders.errorSnackBar(title: ATexts.errorText, message: e.toString());
    }
  }

  // Function to update a transaction.
  Future<void> updateTransaction(TransactionModel updatedTransaction) async {
    try {
      // Update the transaction using the transaction ID
      await transactionRepository.updateTransactions(
          updatedTransaction, updatedTransaction.id!);
    } catch (e) {
      // Handle any errors that occur during the update process
      ALoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to update transaction: ${e.toString()}',
      );
    }
  }

  // Method to calculate the total expense
  void calculateTotalExpense() {
    double expenseSum = 0.0;
    DateTime now = DateTime.now();
    for (var transaction in transactions) {
      if (transaction.isExpense) {
        DateTime transactionDate =
            DateFormat('dd MMM, yyyy').parse(transaction.date);
        if (transactionDate.year == now.year &&
            transactionDate.month == now.month) {
          expenseSum += double.tryParse(transaction.amount) ?? 0.0;
        }
      }
    }
    totalExpense.value = expenseSum.toString();
  }
}
