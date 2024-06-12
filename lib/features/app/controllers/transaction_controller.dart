import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moniito_v2/data/repositories/transaction/transaction_repository.dart';
import 'package:moniito_v2/data/repositories/user/user_repository.dart';
import 'package:moniito_v2/features/app/models/transaction_model.dart';
import 'package:moniito_v2/utils/popups/loaders.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final transactionRepository = Get.put(TransactionRepository());

  final TextEditingController amount = TextEditingController();
  final TextEditingController transactionTitle = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController searchController = TextEditingController();

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
    filteredCategories.value = categoryType.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
  }

  Future<void> saveUserTransactions(TransactionModel transaction) async {
    print(amount.text.toString());
    print(isExpense.value);
    print(isIncome.value);
    print(transactionTitle.text.toString());
    print(category.value);
    print(description.text.toString());
    print(image.value);

    TransactionModel transaction = TransactionModel(
        amount: amount.text.toString(),
        transactionTitle: transactionTitle.text.toString(),
        isExpense: isExpense.value,
        category: category.value,
        description: description.value.toString(),
        date: '12-06-2024');

    final user = await userRepository.fetchUserDetails();

    final transactionId =
        await transactionRepository.saveTransaction(user, transaction);

    if (transactionId != '') {
      transaction.id = transactionId;
    }

    String imageUrl = await uploadReceiptImage();
    if (imageUrl != '') {
      transaction.receiptImage = imageUrl;
    }
  }

  void setImage(XFile imageFile) {
    image.value = imageFile;
  }

  void clearImage() {
    image.value = XFile('');
  }

  void filterCategories(String text) {
    filteredCategories.value = categoryType.entries
        .where(
            (entry) => entry.value.toLowerCase().contains(text.toLowerCase()))
        .toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    if (filteredCategories.isEmpty) {
      filteredCategories.value = [
        const MapEntry(Category.miscellaneous, 'Miscellaneous')
      ];
    }
  }

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
            title: 'Cropper',
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

      if (croppedFile != null) {
        final croppedFilePath = croppedFile.path;
        final xFile = XFile(croppedFilePath);
        setImage(xFile);
      }
    }
  }

  Future<String> uploadReceiptImage() async {
    try {
      print(image);
      if (image != null) {
        // Upload Image
        final imageUrl = await transactionRepository.uploadImage(
            'Users/Images/ReceiptImages/', image.value);

        print(imageUrl);

        return imageUrl;
      }
    } catch (e) {
      ALoaders.errorSnackBar(
          title: 'Oh Snap', message: 'Something went wrong : $e');
    }
    return '';
  }
}
