import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

/// VALIDATION CLASS
class AValidator {
  /// Empty Text Validation
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }

    return null;
  }

  /// Username Validation
  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required.';
    }

    // Define a regular expression pattern for the username.
    const pattern = r"^[a-zA-Z0-9_-]{3,20}$";

    // Create a RegExp instance from the pattern.
    final regex = RegExp(pattern);

    // Use the hasMatch method to check if the username matches the pattern.
    bool isValid = regex.hasMatch(username);

    // Check if the username doesn't start or end with an underscore or hyphen.
    if (isValid) {
      isValid = !username.startsWith('_') &&
          !username.startsWith('-') &&
          !username.endsWith('_') &&
          !username.endsWith('-');
    }

    if (!isValid) {
      return 'Username is not valid.';
    }

    return null;
  }

  /// Email Validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  /// Password Validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  /// Phone Number Validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }

  /// Transaction Title Validation
  static String? validateTransactionTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Transaction Title is required.';
    }

    return null;
  }

  /// Transaction Category Validation
  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select category.';
    }

    return null;
  }

  /// Transaction Date Validation
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select the date of transaction';
    }

    return null;
  }

  /// Transaction Description Validation
  static String? validateDescription(String? value) {
    return null;
  }

  /// Transaction Amount Validation with Formatter
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is Required';
    }

    // Remove thousands separator and convert to plain number string
    final cleanValue = value.replaceAll(',', '');

    // Validate if the input is a valid number
    final isValidAmount = RegExp(r'^\d*$').hasMatch(cleanValue);
    if (!isValidAmount) {
      return 'Enter amount correctly.';
    }

    return null;
  }
}

class IntegerDecimalThousandsSeparatorInputFormatter
    extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-digit and non-decimal point characters from the new text.
    final cleanText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // Split the cleaned text into integer and decimal parts.
    final parts = cleanText.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    // Validate if the input is a valid integer or decimal value.
    if (RegExp(r'^\d*\.?\d*$').hasMatch(cleanText)) {
      // Format the integer part with thousands separators.
      final formattedValue =
          NumberFormat.decimalPattern().format(int.parse(integerPart));

      // Combine the formatted integer part with the decimal part (if any).
      String formattedText = formattedValue + decimalPart;

      // Return the formatted text with the cursor at the end.
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    } else {
      // If the input is not valid, return the old value.
      return oldValue;
    }
  }
}
