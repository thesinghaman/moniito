import 'dart:io';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/data/repositories/authentication/authentication_repositories.dart';
import '/features/personalization/models/user_model.dart';
import '/features/app/models/transaction_model.dart';
import '/utils/constants/text_strings.dart';
import '/utils/exceptions/firebase_auth_exceptions.dart';
import '/utils/exceptions/format_exceptions.dart';
import '/utils/exceptions/platform_exceptions.dart';

class TransactionRepository {
  static TransactionRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save transaction data to Firestore
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

  /// Update any fields in specific Transactions collection
  Future<void> updateTransactions(
      TransactionModel transaction, String transactionId) async {
    try {
      // Attempt to update the transaction document in Firestore.
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Transactions")
          .doc(transactionId)
          .update(transaction.toJson());
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

  /// Function to delete a specified transaction from Firestore
  Future<void> deleteTransaction(String transactionId) async {
    try {
      // Reference to the user's document
      final userId = AuthenticationRepository.instance.authUser?.uid;
      final transactionDoc = await _db
          .collection('Users')
          .doc(userId)
          .collection('Transactions')
          .doc(transactionId)
          .get();

      // Get the receipt image URL
      final receiptImageUrl = transactionDoc.data()?['ReceiptImage'] ?? '';

      // Delete the receipt image from Firebase Storage if it exists
      if (receiptImageUrl.isNotEmpty) {
        await deleteReceiptImage(receiptImageUrl);
      }

      // Delete the transaction document from Firestore
      await _db
          .collection('Users')
          .doc(userId)
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

  /// Function to fetch list of transactions from Firestore
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
      throw Exception("Transaction not found");
    }
  }

  /// Function to get the transaction with specified ID
  Future<TransactionModel> getSpecifiedTransaction(String transactionId) async {
    try {
      // Get the user ID.
      final userId = AuthenticationRepository.instance.authUser?.uid;

      // Get the transaction with the specified ID.
      final transactionDoc = await _db
          .collection('Users')
          .doc(userId)
          .collection('Transactions')
          .doc(transactionId)
          .get();

      // Convert the document snapshot to a TransactionModel
      return TransactionModel.fromSnapshot(transactionDoc);
    } on FirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw Exception("Transaction not found");
    }
  }

  /// Function to upload Receipt Image
  Future<String> uploadReceiptImage(String path, XFile image) async {
    try {
      // Get a reference to the location where the image will be stored
      final ref = FirebaseStorage.instance.ref(path).child(image.name);

      // Upload the image file to Firebase Storage
      await ref.putFile(File(image.path));

      // Get the download URL of the uploaded image
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      // Handle format-specific errors
      throw const AFormatException();
    } on PlatformException catch (e) {
      // Handle platform-specific errors
      throw APlatformException(e.code).message;
    } catch (e) {
      // Handle any other errors
      throw ATexts.wentWrong;
    }
  }

  /// Delete Receipt Image
  Future<void> deleteReceiptImage(String imageUrl) async {
    try {
      // Get a reference to the image using its URL
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);

      // Delete the image from Firebase Storage
      await ref.delete();
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
