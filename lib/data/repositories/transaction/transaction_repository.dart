import 'dart:io';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '/data/repositories/authentication/authentication_repositories.dart';
import '/features/personalization/models/user_model.dart';
import '/features/app/models/transaction_model.dart';
import '/utils/constants/text_strings.dart';
import '/utils/exceptions/firebase_auth_exceptions.dart';
import '/utils/exceptions/format_exceptions.dart';
import '/utils/exceptions/platform_exceptions.dart';
import '/utils/popups/loaders.dart';

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
          .collection('Transactions')
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

  /// Update any fields in specific Transactions collection
  Future<void> updateTransactions(
      Map<String, dynamic> fields, String transactionId) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Transactions")
          .doc(transactionId)
          .update(fields);
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

  /// Upload Receipt Image
  Future<String> uploadReceiptImage(String path, XFile image) async {
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

  // Function to fetch list of transactions from Firestore
  Stream<List<TransactionModel>> getTransactions(String userId) {
    try {
      // Reference to the user's document
      DocumentReference userRef = _db.collection('Users').doc(userId);

      // Reference to the "Transaction" subcollection
      CollectionReference transactionRef = userRef.collection('Transactions');

      // Fetch and listen to changes in the "Transaction" subcollection
      return transactionRef.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => TransactionModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList());
    } on FirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      // Handle error
      return const Stream.empty();
    }
  }

  Future<void> removeTransaction(String transactionId) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection('Transactions')
          .doc(transactionId)
          .delete();
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
