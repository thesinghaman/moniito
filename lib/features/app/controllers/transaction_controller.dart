import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '/home_menu.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/text_strings.dart';
import '/utils/helpers/network_manager.dart';
import '/utils/popups/full_screen_loader.dart';
import '/utils/popups/loaders.dart';
import '/utils/constants/enums.dart';

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
  final TextEditingController searchController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Observables
  Rx<Category> selectedCategory = Category.artAndCrafts.obs;
  RxList<MapEntry<Category, String>> filteredCategories =
      <MapEntry<Category, String>>[].obs;
  Rx<XFile> image = XFile('').obs;
  Rx<bool> isExpense = true.obs;
  Rx<bool> isIncome = false.obs;

  // Form Keys
  final addTransactionFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Initialize filtered categories on controller initialization
    filteredCategories.value = categoryType.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
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

      // Remove thousands separator and convert to plain number string
      final amountValue =
          amount.text.toString().replaceAll(RegExp(r'[^\d.]'), '');

      // Create TransactionModel
      TransactionModel newTransaction = TransactionModel(
        amount: amountValue,
        transactionTitle: transactionTitle.text.toString(),
        isExpense: isExpense.value,
        category: categoryController.text.toString(),
        receiptImage: imageUrl,
        description: description.value.text.toString(),
        date: dateController.text.toString(),
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

  // Filter categories based on text input
  void filterCategories(String text) {
    // Filter categories based on search text
    filteredCategories.value = categoryType.entries
        .where(
            (entry) => entry.value.toLowerCase().contains(text.toLowerCase()))
        .toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    // If no categories found, show Miscellaneous
    if (filteredCategories.isEmpty) {
      filteredCategories.value = [
        const MapEntry(Category.miscellaneous, 'Miscellaneous')
      ];
    }
  }
}
