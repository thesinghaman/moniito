// Import necessary packages and files
import 'package:flutter/material.dart';

// Importing custom widgets and constants
import '../../constants/colors.dart';

class ABottomSheetTheme {
  ABottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: AColors.white,
    modalBackgroundColor: AColors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
