import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:moniito_v2/data/repositories/user/user_repository.dart';
import 'package:moniito_v2/features/personalization/models/user_model.dart';
import 'package:moniito_v2/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  /// Save user Record from any Registration Provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        // Convert Name to First and Last Name
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? ' ');
        final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? ' ');

        // Map Data
        final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : ' ',
            username: username,
            email: userCredentials.user!.email ?? ' ',
            phoneNumber: userCredentials.user!.phoneNumber ?? ' ',
            profilePicture: userCredentials.user!.photoURL ?? '');

        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      ALoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your infromation. You can re-save your data in you Profile.');
    }
  }
}
