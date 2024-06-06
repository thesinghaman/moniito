import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moniito_v2/data/repositories/authentication/authentication_repositories.dart';
import 'package:moniito_v2/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:moniito_v2/utils/constants/image_strings.dart';
import 'package:moniito_v2/utils/constants/text_strings.dart';
import 'package:moniito_v2/utils/helpers/network_manager.dart';
import 'package:moniito_v2/utils/popups/full_screen_loader.dart';
import 'package:moniito_v2/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start Loader
      AFullScreenLoader.openLoadingDialog(
          ATexts.processingInformation, AImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Show success Screen
      ALoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password'.tr);

      // Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      // Remove Loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: ATexts.errorText, message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // Start Loader
      AFullScreenLoader.openLoadingDialog(
          ATexts.processingInformation, AImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Show success Screen
      ALoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password'.tr);
    } catch (e) {
      // Remove Loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: ATexts.errorText, message: e.toString());
    }
  }
}
