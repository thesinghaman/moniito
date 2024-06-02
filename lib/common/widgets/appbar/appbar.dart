// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// Import custom constants and utilities
import '/utils/constants/colors.dart';
import '/utils/device/device_utility.dart';
import '/utils/icons/iconsax_icons.dart';
import '/utils/constants/sizes.dart';
import '/common/widgets/icons/icon_button.dart';

class AAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.centerTitle = false,
    this.iconColor = AColors.primary,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool? centerTitle;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: ASizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: centerTitle,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Brightness.dark, // -- For Android (dark icons)
          statusBarBrightness: Brightness.light, // -- For iOS (dark icons)
        ),
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: AIconButton(
                  icon: Iconsax.arrow_left,
                  iconColor: iconColor,
                ))
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: AIconButton(
                      icon: leadingIcon!,
                      iconColor: iconColor,
                    ))
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ADeviceUtils.getAppBarHeight());
}
