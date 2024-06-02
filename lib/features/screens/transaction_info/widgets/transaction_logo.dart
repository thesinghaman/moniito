import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

class ATransactionLogo extends StatelessWidget {
  const ATransactionLogo({
    super.key,
    required this.color,
    required this.icon,
  });

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          border: Border.all(color: color),
          boxShadow: const [
            BoxShadow(
                color: AColors.greyGradient,
                spreadRadius: 4,
                blurRadius: 7,
                offset: Offset(0, 4) // changes position of shadow
                ),
          ],
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon, size: ASizes.iconLg),
      ),
    );
  }
}
