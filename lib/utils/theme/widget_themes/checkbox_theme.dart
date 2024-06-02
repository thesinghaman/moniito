// Import necessary packages and files
import 'package:flutter/material.dart';

// Importing custom widgets and constants
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class ACheckboxTheme {
  ACheckboxTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(ASizes.xs)),
    checkColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AColors.white;
      } else {
        return AColors.primary;
      }
    }),
    fillColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
