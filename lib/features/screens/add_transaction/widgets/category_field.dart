import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/icons/iconsax_icons.dart';

class ACategoryField extends StatelessWidget {
  const ACategoryField({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ASizes.defaultSpace),
      decoration: BoxDecoration(
        border: Border.all(color: AColors.borderPrimary),
        borderRadius: BorderRadius.circular(
          ASizes.borderRadiusLg,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Iconsax.category, color: AColors.darkGrey),
        title: Text(
          ATexts.category,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: AColors.darkGrey, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Iconsax.arrow_down_1, color: AColors.darkGrey),
      ),
    );
  }
}
