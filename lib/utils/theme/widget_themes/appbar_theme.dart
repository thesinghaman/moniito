// Import necessary packages and files
import 'package:flutter/material.dart';

// Importing custom widgets and constants
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class AAppBarTheme {
  AAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AColors.primary, size: ASizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: AColors.primary, size: ASizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: AColors.primary,
        fontFamily: 'Uber Move'),
  );
}
