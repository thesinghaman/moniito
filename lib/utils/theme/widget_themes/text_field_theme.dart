import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

class ATextFormFieldTheme {
  ATextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AColors.darkGrey,
    suffixIconColor: AColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: ASizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
        fontSize: ASizes.fontSizeMd,
        color: AColors.black,
        fontFamily: 'Uber Move'),
    hintStyle: const TextStyle().copyWith(
        fontSize: ASizes.fonASizesm,
        color: AColors.black,
        fontFamily: 'Uber Move'),
    errorStyle: const TextStyle()
        .copyWith(fontStyle: FontStyle.normal, fontFamily: 'Uber Move'),
    floatingLabelStyle: const TextStyle().copyWith(
        color: AColors.black.withOpacity(0.8), fontFamily: 'Uber Move'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: AColors.darkGrey,
    suffixIconColor: AColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: ASizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
        fontSize: ASizes.fontSizeMd,
        color: AColors.white,
        fontFamily: 'Uber Move'),
    hintStyle: const TextStyle().copyWith(
        fontSize: ASizes.fonASizesm,
        color: AColors.white,
        fontFamily: 'Uber Move'),
    floatingLabelStyle: const TextStyle().copyWith(
        color: AColors.white.withOpacity(0.8), fontFamily: 'Uber Move'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AColors.warning),
    ),
  );
}
