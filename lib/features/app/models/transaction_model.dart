import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing Transaction data.
class TransactionModel {
  String? id;
  final String amount;
  final String transactionTitle;
  final bool isExpense;
  final String category;
  final String description;
  String receiptImage;
  final String date;

  TransactionModel(
      {this.id = '',
      required this.amount,
      required this.transactionTitle,
      required this.isExpense,
      required this.category,
      this.description = '',
      this.receiptImage = '',
      required this.date});

  // Static function to generate empty TransactionModel
  static TransactionModel empty() => TransactionModel(
      id: '',
      amount: '',
      transactionTitle: '',
      isExpense: false,
      category: '',
      date: '',
      description: '',
      receiptImage: '');

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'IsExpense': isExpense,
      'TransactionTitle': transactionTitle,
      'Category': category,
      'Amount': amount,
      'Date': date,
      'Description': description,
      'ReceiptImage': receiptImage
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return TransactionModel(
        id: data['id'],
        isExpense: data['IsExpense'] ?? '',
        transactionTitle: data['TransactionTitle'] ?? '',
        category: data['Category'] ?? '',
        amount: data['Amount'] ?? '',
        date: data['Date'] ?? '',
        description: data['Description'] ?? '',
        receiptImage: data['ReceiptImage'] ?? '',
      );
    } else {
      return TransactionModel.empty();
    }
  }
}
