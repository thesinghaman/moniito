import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

class ATextField extends StatelessWidget {
  const ATextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.textFieldController,
  });

  final IconData icon;
  final String hintText;
  final TextEditingController textFieldController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ASizes.defaultSpace),
      padding: const EdgeInsets.symmetric(
          horizontal: ASizes.md, vertical: ASizes.xs - 1),
      decoration: BoxDecoration(
        border: Border.all(color: AColors.borderPrimary),
        borderRadius: BorderRadius.circular(ASizes.borderRadiusLg),
      ),
      child: Row(
        children: [
          Icon(icon, color: AColors.darkGrey),
          const SizedBox(width: ASizes.md),
          Expanded(
            child: TextField(
              controller: textFieldController,
              maxLines: 1,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AColors.darkerGrey, fontWeight: FontWeight.w500),
              cursorColor: AColors.textPrimary,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle().copyWith(
                    fontSize: ASizes.fontSizeLg,
                    color: AColors.darkGrey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Uber Move'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
