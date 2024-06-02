// Import necessary packages and files
import 'package:flutter/material.dart';

// Importing custom widgets and constants
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class AElevatedButtonTheme {
  AElevatedButtonTheme._(); // To avoid creating instances

  /// -- Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AColors.light,
      backgroundColor: AColors.primary,
      disabledForegroundColor: AColors.darkGrey,
      disabledBackgroundColor: AColors.buttonDisabled,
      side: const BorderSide(color: AColors.primary),
      padding: const EdgeInsets.symmetric(vertical: ASizes.buttonHeight),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ASizes.buttonRadius)),
      textStyle: const TextStyle(
          fontSize: 16,
          color: AColors.textWhite,
          fontWeight: FontWeight.w600,
          fontFamily: 'Uber Move'),
    ),
  );
}
