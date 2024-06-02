// Import necessary packages and files
import 'package:flutter/material.dart';

// Importing custom widgets and constants
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class AOutlinedButtonTheme {
  AOutlinedButtonTheme._(); // To avoid creating instances

  /// -- Light Theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AColors.black,
      side: const BorderSide(color: AColors.borderPrimary),
      padding: const EdgeInsets.symmetric(
          vertical: ASizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ASizes.buttonRadius)),
      textStyle: const TextStyle(
          fontSize: 16,
          color: AColors.primary,
          fontWeight: FontWeight.w600,
          fontFamily: 'Uber Move'),
    ),
  );
}
