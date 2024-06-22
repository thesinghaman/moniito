import 'dart:io';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/data/repositories/authentication/authentication_repositories.dart';
import '/utils/exceptions/firebase_auth_exceptions.dart';
import '/utils/exceptions/format_exceptions.dart';
import '/utils/exceptions/platform_exceptions.dart';
import '/utils/constants/text_strings.dart';
import '/features/personalization/models/user_model.dart';

/// Repository class for user-related operations
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

  /// Function to fetch user details based on User ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
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

  /// Function to Update user data in Firestore.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
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

  /// Update any field in specific user collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
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

  /// Function to remove user data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      // Reference to the user's document
      DocumentReference userRef = _db.collection("Users").doc(userId);

      // Get a reference to the "Transaction" subcollection
      CollectionReference transactionRef = userRef.collection("Transaction");

      // Get all documents in the "Transaction" subcollection
      QuerySnapshot transactionSnapshot = await transactionRef.get();

      // Delete each document in the "Transaction" subcollection
      for (DocumentSnapshot doc in transactionSnapshot.docs) {
        await doc.reference.delete();
      }

      // Finally, delete the user's document
      await userRef.delete();
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
