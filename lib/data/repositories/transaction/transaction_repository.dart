import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moniito_v2/features/personalization/models/user_model.dart';
import 'package:moniito_v2/features/transactions/models/transaction_model.dart';
import 'package:moniito_v2/utils/popups/loaders.dart';

class TransactionRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save transaction data to Firestore
  Future<String> saveTransaction(
      UserModel user, TransactionModel transaction) async {
    try {
      // Add a new document to the "Transaction" subcollection and get the reference
      DocumentReference newTransactionRef = await _db
          .collection('Users')
          .doc(user.id)
          .collection('Transaction')
          .add(transaction.toJson());

      // Update the transaction data with the generated ID
      await newTransactionRef.update({'id': newTransactionRef.id});

      // Return the generated Transaction ID
      return newTransactionRef.id;
    } catch (e) {
      ALoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving the transaction. Please try later.');
      return '';
    }
  }

  // Function to fetch list of transactions from Firestore
  Stream<List<TransactionModel>> getTransactions(String userId) {
    try {
      // Reference to the user's document
      DocumentReference userRef = _db.collection('user').doc(userId);

      // Reference to the "Transaction" subcollection
      CollectionReference transactionRef = userRef.collection('Transaction');

      // Fetch and listen to changes in the "Transaction" subcollection
      return transactionRef.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => TransactionModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList());
    } catch (e) {
      // Handle error
      print('Error fetching transactions: $e');
      return const Stream.empty();
    }
  }
}
