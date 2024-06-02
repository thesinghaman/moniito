import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/common/widgets/login_signup/form_divider.dart';
import '/common/widgets/login_signup/social_buttons.dart';

import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';

import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center widget as the body of Scaffold
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: ASizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Header
                const ALoginHeader(),

                /// Form
                const ALoginForm(),

                /// Divider
                AFormDivider(dividerText: ATexts.orSignInWith.capitalize!),
                const SizedBox(height: ASizes.spaceBtwSections),

                /// Footer
                const ASocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
