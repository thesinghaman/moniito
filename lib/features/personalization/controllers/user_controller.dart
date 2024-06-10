import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/common/widgets/loaders/circular_loader.dart';
import '/data/repositories/authentication/authentication_repositories.dart';
import '/data/repositories/user/user_repository.dart';
import '/features/authentication/screens/login/login.dart';
import '/features/personalization/models/user_model.dart';
import '/features/personalization/profile/widgets/re_authenticate_user_login_form.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/helpers/network_manager.dart';
import '/utils/popups/full_screen_loader.dart';
import '/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // This will monitor any change in the user data and if there is any change, it'll update it accordingly.
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;

  final userRepository = Get.put(UserRepository());
  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch User Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration Provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First update Rx User and then check if user data is already stored. If not store new data.
      await fetchUserRecord();

      // If no user record already stored
      if (user.value.id.isEmpty) {
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

          // Save User Data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      ALoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your infromation. You can re-save your data in you Profile.');
    }
  }

  /// Delete Account Warning Pop-Up
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(ASizes.md),
        title: 'Delete Account',
        middleText:
            'Are you sure you want to delete your account premanently ? This action is not reversible and all of your data will be removed permanently.',
        confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: ASizes.lg),
              child: Text('Delete')),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      AFullScreenLoader.openLoadingDialog('Processing', AImages.docerAnimation);

      /// Re-Authenticate User
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          AFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          AFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.warningSnackBar(title: ATexts.errorText, message: e.toString());
    }
  }

  /// -- RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      AFullScreenLoader.openLoadingDialog('Processing', AImages.docerAnimation);

      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      AFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Logout Loader Function
  logout() {
    try {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(ASizes.md),
        title: 'Logout',
        middleText: 'Are you sure you want to Logout?',
        confirm: ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: ASizes.lg),
            child: Text('Confirm'),
          ),
          onPressed: () async {
            onClose();

            /// On Confirmation show any loader until user Logged Out.
            Get.defaultDialog(
              title: '',
              barrierDismissible: false,
              backgroundColor: Colors.transparent,
              content: const ACircularLoader(),
            );
            await AuthenticationRepository.instance.logout();
          },
        ),
        cancel: OutlinedButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        ),
      );
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
          maxHeight: 512,
          maxWidth: 512);

      if (image != null) {
        imageUploading.value = true;
        // Upload Image
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        // Re-Draw the widgets where user is used.
        user.refresh();

        ALoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your Profile Image has been updated!');
      }
    } catch (e) {
      ALoaders.errorSnackBar(
          title: 'Oh Sanp', message: 'Something went wrong : $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
