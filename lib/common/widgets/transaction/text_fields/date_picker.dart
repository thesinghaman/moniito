import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '/utils/constants/colors.dart';

class ADatePicker {
  static Future<void> selectDate(
      BuildContext context, TextEditingController date) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  surface: const Color.fromRGBO(255, 255, 255, 1),
                  primary: AColors.primary,
                  onSurface: AColors.primary,
                  onPrimary: AColors.white,
                ),
            dialogBackgroundColor: AColors.white,
            dialogTheme: const DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AColors.white,
                backgroundColor: AColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final DateFormat formatter = DateFormat('d MMM, yyyy');
      date.text = formatter.format(pickedDate);
    }
  }
}
