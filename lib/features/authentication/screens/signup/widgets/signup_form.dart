import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/icons/iconsax_icons.dart';
import '/utils/validators/validation.dart';
import '/features/authentication/controllers/signup/signup_controller.dart';
import 'terms_conditions_checkbox.dart';

class ASignupForm extends StatelessWidget {
  const ASignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          const SizedBox(height: ASizes.spaceBtwSections),

          /// First & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      AValidator.validateEmptyText(ATexts.firstName, value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: ATexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: ASizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      AValidator.validateEmptyText(ATexts.lastName, value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: ATexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Username
          TextFormField(
            controller: controller.userName,
            validator: AValidator.validateUsername,
            expands: false,
            decoration: const InputDecoration(
                labelText: ATexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: AValidator.validateEmail,
            decoration: const InputDecoration(
                labelText: ATexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: AValidator.validatePhoneNumber,
            decoration: const InputDecoration(
                labelText: ATexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: AValidator.validatePassword,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: ATexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            ),
          ),

          const SizedBox(height: ASizes.spaceBtwSections),

          /// Terms&Conditions Checkbox
          const ATermsAndConditionCheckbox(),
          const SizedBox(height: ASizes.spaceBtwSections),

          /// Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(ATexts.createAccount)),
          ),
        ],
      ),
    );
  }
}
