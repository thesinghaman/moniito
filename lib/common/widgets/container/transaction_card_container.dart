import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

class ATransactionCardContainer extends StatelessWidget {
  const ATransactionCardContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AColors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(ASizes.borderRadiusLg)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ASizes.sm + 3, vertical: ASizes.sm + 3),
        child: child,
      ),
    );
  }
}
