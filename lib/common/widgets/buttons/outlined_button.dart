import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

class AOutlinedButton extends StatelessWidget {
  const AOutlinedButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ASizes.md),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AColors.primary),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ASizes.borderRadiusLg)),
              textStyle: const TextStyle(
                  fontSize: 18,
                  color: AColors.primary,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Uber Move'),
            ),
            onPressed: () {},
            child: Text(text)),
      ),
    );
  }
}
