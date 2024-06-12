import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moniito_v2/data/repositories/transaction/transaction_repository.dart';
import 'package:moniito_v2/data/repositories/user/user_repository.dart';
import 'package:moniito_v2/features/transactions/models/transaction_model.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final transactionRepository = Get.put(TransactionRepository());

  final amount = TextEditingController();
  final transactionTitle = TextEditingController();
  final category = TextEditingController();
  final image = ''.obs; // Observable string for the image path
  final description = TextEditingController();

  Future<void> saveUserTransactions(TransactionModel transaction) async {
    print(amount.text.toString());
    print(transactionTitle.text.toString());
    print(category.text.toString());
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
}
