import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/features/personalization/controllers/user_controller.dart';
import '/features/personalization/profile/widgets/change_name.dart';
import '/common/widgets/images/a_circular_image.dart';
import '/common/widgets/texts/section_heading.dart';
import '/common/widgets/appbar/appbar.dart';
import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/text_strings.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
        appBar: AAppBar(
            title: Text(
              ATexts.profileScreen,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            showBackArrow: true,
            centerTitle: true),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            // -- Profile Picture
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const ACircularImage(
                        image: AImages.profileImage, width: 80, height: 80),
                    TextButton(
                        onPressed: () {},
                        child: const Text(ATexts.changeProfileImage)),
                  ],
                ),
              ),

              // -- Divider
              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: ASizes.spaceBtwItems),

              // -- Heading Profile Info
              const ASectionHeading(
                  title: ATexts.profileInformation, showActionButton: false),
              const SizedBox(height: ASizes.spaceBtwItems),

              AProfileMenu(
                  title: ATexts.name,
                  value: controller.user.value.fullName,
                  onPressed: () => Get.to(() => const ChangeName())),
              AProfileMenu(
                  title: ATexts.username,
                  value: controller.user.value.username,
                  onPressed: () {}),

              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: ASizes.spaceBtwItems),

              // -- Heading Personal Info
              const ASectionHeading(
                  title: ATexts.personalInformation, showActionButton: false),
              const SizedBox(height: ASizes.spaceBtwItems),

              AProfileMenu(
                  title: ATexts.userId,
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                  onPressed: () {}),
              AProfileMenu(
                  title: ATexts.email,
                  value: controller.user.value.email,
                  onPressed: () {}),
              AProfileMenu(
                  title: ATexts.phoneNo,
                  value: controller.user.value.phoneNumber,
                  onPressed: () {}),
              AProfileMenu(
                  title: ATexts.gender,
                  value: ATexts.genderValue,
                  onPressed: () {}),
              AProfileMenu(
                  title: ATexts.dateOfBirth,
                  value: ATexts.dobValue,
                  onPressed: () {}),

              const SizedBox(height: ASizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: ASizes.spaceBtwItems),

              // Close Account Button
              Center(
                child: TextButton(
                  onPressed: controller.deleteAccountWarningPopup,
                  child: const Text(
                    ATexts.closeAccount,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
