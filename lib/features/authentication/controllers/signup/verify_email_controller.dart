import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '/common/success_screen/success_screen.dart';
import '/data/repositories/authentication/authentication_repositories.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/text_strings.dart';
import '/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email Whenever Verify Scrren appears and Set Timer for auto redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification Link.
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      ALoaders.successSnackBar(
          title: ATexts.emailSentTitle, message: ATexts.emailSentSubtitle);
    } catch (e) {
      ALoaders.errorSnackBar(title: ATexts.errorText, message: e.toString());
    }
  }

  /// Timer to automatically redirect on Email Verification.
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: AImages.successfullyRegisterAnimation,
            title: ATexts.yourAccountCreatedTitle,
            subTitle: ATexts.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  /// Manually Check if the Email is Verfied.
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
            image: AImages.successfullyRegisterAnimation,
            title: ATexts.yourAccountCreatedTitle,
            subTitle: ATexts.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()),
      );
    }
  }
}
