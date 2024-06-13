import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';

// Widget for the outlined button to add an invoice
class AAddReceiptOutlinedButton extends StatelessWidget {
  const AAddReceiptOutlinedButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Iconsax.receipt, color: AColors.darkGrey),
          const SizedBox(width: ASizes.md),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AColors.darkGrey, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
