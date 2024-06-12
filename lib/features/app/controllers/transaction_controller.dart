import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moniito_v2/data/repositories/transaction/transaction_repository.dart';
import 'package:moniito_v2/data/repositories/user/user_repository.dart';
import 'package:moniito_v2/features/app/models/transaction_model.dart';

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
  Rx<String> image = ''.obs;
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
    final user = await userRepository.fetchUserDetails();

    final transactionId =
        await transactionRepository.saveTransaction(user, transaction);

    if (transactionId != '') {
      transaction.id = transactionId;
    }
  }

  void setImage(String path) {
    image.value = path;
  }

  void clearImage() {
    image.value = '';
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
}
