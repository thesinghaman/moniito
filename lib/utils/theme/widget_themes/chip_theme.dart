// Import necessary packages and files
import 'package:flutter/material.dart';

// Importing custom widgets and constants
import '/utils/constants/colors.dart';

class AChipTheme {
  AChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: AColors.white,
    selectedColor: AColors.primary,
    disabledColor: AColors.grey.withOpacity(0.4),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle:
        const TextStyle(color: AColors.primary, fontFamily: 'Uber Move'),
  );
}
