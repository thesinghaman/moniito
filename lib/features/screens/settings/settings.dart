import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/data/repositories/authentication/authentication_repositories.dart';
import '/common/widgets/container/primary_header_container.dart';
import '/common/widgets/texts/section_heading.dart';
import '/features/screens/settings/widgets/settings_app_bar.dart';
import '/features/screens/settings/widgets/settings_menu_tile.dart';
import '/features/personalization/profile/profile.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/helpers/helper_functions.dart';
import '/utils/icons/iconsax_icons.dart';
import '/utils/constants/text_strings.dart';
import 'widgets/user_profile_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AColors.light,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- Header
            APrimaryHeaderContainer(
              child: Column(
                children: [
                  // AppBar
                  const ASettingsAppBar(),

                  // User Profile Card
                  AUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                ],
              ),
            ),

            // -- Body
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: ASizes.defaultSpace),
              child: ASectionHeading(
                  title: ATexts.appSettings, showActionButton: false),
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: ASizes.md),
              child: Column(
                children: [
                  // App Settings
                  ASettingsMenuTile(
                      icon: Iconsax.moneys4,
                      text: ATexts.currency,
                      onTap: () {}),
                  ASettingsMenuTile(
                      icon: Iconsax.security_safe,
                      text: ATexts.security,
                      onTap: () {}),
                  ASettingsMenuTile(
                      icon: Iconsax.notification,
                      text: ATexts.notifications,
                      onTap: () {}),

                  const SizedBox(height: ASizes.spaceBtwSections),

                  // Divider
                  const Divider(
                      indent: 20,
                      endIndent: 30,
                      thickness: 1,
                      color: AColors.grey),

                  const SizedBox(height: ASizes.spaceBtwSections),

                  ASettingsMenuTile(
                      icon: Iconsax.info_circle,
                      text: ATexts.about,
                      onTap: () {}),
                  ASettingsMenuTile(
                      icon: Iconsax.logout,
                      iconColor: AHelperFunctions.getColor("Red"),
                      text: ATexts.logOut,
                      textColor: AHelperFunctions.getColor("Red"),
                      trailing: null,
                      onTap: () => AuthenticationRepository.instance.logout()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
