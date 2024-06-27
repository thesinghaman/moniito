import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/data/repositories/authentication/authentication_repositories.dart';
import '/data/repositories/user/user_repository.dart';
import '/features/authentication/screens/signup/verify_email.dart';
import '/features/personalization/models/user_model.dart';
import '/utils/constants/image_strings.dart';
import '/utils/helpers/network_manager.dart';
import '/utils/popups/full_screen_loader.dart';
import '/utils/constants/text_strings.dart';
import '/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    try {
      AFullScreenLoader.openLoadingDialog(
          ATexts.processingInformation, AImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        // Remove Loader
        AFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        ALoaders.warningSnackBar(
            title: ATexts.acceptPrivacyPolicyTitle,
            message: ATexts.acceptPrivacyPolicyValueSubtitle);
        return;
      }
      // Register user in the Firebase Authentication & Save user data in Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '',
          totalBalance: '');

      // Intialize the 'UserRepostiory'
      final userRepository = Get.put(UserRepository());
      // Save the user data in firebase.
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Show Success Message
      ALoaders.successSnackBar(
          title: ATexts.accountCreatedTitle,
          message: ATexts.accountCreatedSubtitle);

      // Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      ALoaders.errorSnackBar(title: ATexts.errorText, message: e.toString());
    }
  }
}
