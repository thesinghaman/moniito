import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moniito_v2/features/personalization/models/user_model.dart';
import 'package:moniito_v2/features/app/models/transaction_model.dart';
import 'package:moniito_v2/utils/constants/text_strings.dart';
import 'package:moniito_v2/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:moniito_v2/utils/exceptions/format_exceptions.dart';
import 'package:moniito_v2/utils/exceptions/platform_exceptions.dart';
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

  /// Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw ATexts.wentWrong;
    }
  }
}
