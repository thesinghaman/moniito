import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

class ATextFormField extends StatelessWidget {
  const ATextFormField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.textFieldController,
    required this.validator,
  });

  final IconData icon;
  final String hintText;
  final TextEditingController textFieldController;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: ASizes.md, vertical: ASizes.xs - 1),
      child: TextFormField(
        controller: textFieldController,
        maxLines: 1,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: AColors.darkerGrey, fontWeight: FontWeight.w500),
        cursorColor: AColors.textPrimary,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          focusedBorder: const OutlineInputBorder().copyWith(
            borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
            borderSide: const BorderSide(width: 1, color: AColors.grey),
          ),
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle().copyWith(
              fontSize: ASizes.fontSizeLg,
              color: AColors.darkGrey,
              fontWeight: FontWeight.w500,
              fontFamily: 'Uber Move'),
        ),
        validator: validator,
      ),
    );
  }
}
