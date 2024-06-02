import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/data/repositories/authentication/authentication_repositories.dart';

import '/utils/constants/image_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/helpers/helper_functions.dart';

import '/features/authentication/controllers/signup/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    // 'Get.put' us used when we want to create the instance for the first time
    // 'Get.find is used to use the already created instance.'
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      /// Appbar close icon will first Logout the user & then redirect back to Login Screen()
      /// Reason: We will store the data when user enters the Register Button on Previous screen.
      /// Whenever the user opens the app, we will check if email is verified or not.
      /// If not verified we will always show this Verification screen.
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        // Padding to Give Default Equal Space on all sides in all screens.
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Image(
                image: const AssetImage(AImages.deliveredEmailIllustration),
                width: AHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// Title, Email & SubTitle
              Text(ATexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: ASizes.spaceBtwItems),
              Text(email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: ASizes.spaceBtwItems),
              Text(ATexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.checkEmailVerificationStatus(),
                    child: const Text(ATexts.aContinue)),
              ),
              const SizedBox(height: ASizes.spaceBtwItems),

              /// Resend Email, You can also add timer
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () => controller.sendEmailVerification(),
                    child: const Text(ATexts.resendEmail)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
