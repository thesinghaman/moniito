import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/features/authentication/controllers/forget_password/forget_password_controller.dart';
import '/common/widgets/appbar/appbar.dart';
import '/utils/validators/validation.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/icons/iconsax_icons.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      /// Custom Appbar
      appBar: AAppBar(actions: [
        IconButton(
            onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(ATexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(ATexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: ASizes.spaceBtwSections * 2),

            /// Text field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: AValidator.validateEmail,
                decoration: const InputDecoration(
                    labelText: ATexts.email,
                    prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwSections),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.sendPasswordResetEmail(),
                  child: const Text(ATexts.submit)),
            ),
          ],
        ),
      ),
    );
  }
}
