import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

class ACategoryIcon extends StatelessWidget {
  const ACategoryIcon({
    super.key,
    required this.backgroundColor,
    required this.icon,
  });

  final Color backgroundColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(ASizes.borderRadiusLg)),
      child: Padding(
        padding: const EdgeInsets.all(ASizes.sm + 5),
        child: Icon(
          icon,
          size: ASizes.iconMd,
          color: AColors.black,
        ),
      ),
    );
  }
}
