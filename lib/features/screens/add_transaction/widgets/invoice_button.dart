import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';

class AAddInvoiceButton extends StatelessWidget {
  const AAddInvoiceButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  final String title;
  final VoidCallback? onPressed;

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
          )
        ],
      ),
    );
  }
}
