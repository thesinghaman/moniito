import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/icons/iconsax_icons.dart';

class ASettingsMenuTile extends StatelessWidget {
  const ASettingsMenuTile({
    super.key,
    required this.icon,
    required this.text,
    this.textColor = AColors.black,
    this.iconColor = AColors.primary,
    this.trailing = const Icon(Iconsax.arrow_right_34),
    this.onTap,
  });

  final IconData icon;
  final String text;
  final Color? textColor, iconColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: iconColor),
      title: Text(text,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 17, color: textColor)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
