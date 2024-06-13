import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '/data/repositories/transaction/transaction_repository.dart';
import '/data/repositories/user/user_repository.dart';
import '/features/app/models/transaction_model.dart';
import '/utils/popups/loaders.dart';
import '/utils/constants/enums.dart';

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

  // Observables
  Rx<Category> selectedCategory = Category.artAndCrafts.obs;
  RxList<MapEntry<Category, String>> filteredCategories =
      <MapEntry<Category, String>>[].obs;
  Rx<String> category = ''.obs;
  Rx<XFile> image = XFile('').obs;
  Rx<bool> isExpense = true.obs;
  Rx<bool> isIncome = false.obs;

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
    String imageUrl = '';
    // Check if there's an image to upload
    if (image.value.path.isNotEmpty) {
      imageUrl = await uploadReceiptImage();

      // If there's an image but failed to upload, return
      if (imageUrl.isEmpty) return;
    }

    // Create TransactionModel
    TransactionModel newTransaction = TransactionModel(
        amount: amount.text.toString(),
        transactionTitle: transactionTitle.text.toString(),
        isExpense: isExpense.value,
        category: category.value,
        receiptImage: imageUrl,
        description: description.value.text.toString(),
        date: '12-06-2024');

    // Fetch user details
    final user = await userRepository.fetchUserDetails();

    // Save transaction
    final transactionId =
        await transactionRepository.saveTransaction(user, newTransaction);

    // If transaction saved successfully, set transaction id
    if (transactionId != '') {
      newTransaction.id = transactionId;
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
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          ),
          IOSUiSettings(
            title: 'Crop Image',
            minimumAspectRatio: 1.0,
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
