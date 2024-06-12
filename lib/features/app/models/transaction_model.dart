import 'package:cloud_firestore/cloud_firestore.dart';

enum Category {
  foodAndDining,
  transportation,
  housing,
  entertainment,
  utilities,
  healthcare,
  education,
  personalCare,
  travel,
  giftsAndDonations,
  savingsInvestments,
  insurance,
  taxes,
  debtPayments,
  businessExpense,
  miscellaneous,
  shopping,
  clothing,
  electronics,
  homeImprovement,
  subscriptions,
  childcare,
  petCare,
  automotive,
  fitness,
  beauty,
  hobbies,
  booksAndMagazines,
  sportingGoods,
  homeDecor,
  gardening,
  music,
  artAndCrafts,
  groceries
}

const categoryType = {
  Category.foodAndDining: "Food and Dining",
  Category.transportation: "Transportation",
  Category.housing: "Housing",
  Category.entertainment: "Entertainment",
  Category.utilities: "Utilities",
  Category.healthcare: "Healthcare",
  Category.education: "Education",
  Category.personalCare: "Personal Care",
  Category.travel: "Travel",
  Category.giftsAndDonations: "Gifts and Donations",
  Category.savingsInvestments: "Savings and Investments",
  Category.insurance: "Insurance",
  Category.taxes: "Taxes",
  Category.debtPayments: "Debt Payments",
  Category.businessExpense: "Business Expense",
  Category.miscellaneous: "Miscellaneous",
  Category.shopping: "Shopping",
  Category.clothing: "Clothing",
  Category.electronics: "Electronics",
  Category.homeImprovement: "Home Improvement",
  Category.subscriptions: "Subscriptions",
  Category.childcare: "Childcare",
  Category.petCare: "Pet Care",
  Category.automotive: "Automotive",
  Category.fitness: "Fitness",
  Category.beauty: "Beauty",
  Category.hobbies: "Hobbies",
  Category.booksAndMagazines: "Books and Magazines",
  Category.sportingGoods: "Sporting Goods",
  Category.homeDecor: "Home Decor",
  Category.gardening: "Gardening",
  Category.music: "Music",
  Category.artAndCrafts: "Art and Crafts",
  Category.groceries: "Groceries",
};

/// Model class representing Transaction data.
class TransactionModel {
  String id;
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
        id: document.id,
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
