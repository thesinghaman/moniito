// Import necessary packages and files
import 'package:flutter/material.dart';

// Import custom widgets and constants
import '/utils/constants/sizes.dart';
import 'footer_text.dart';

class CardFooter extends StatelessWidget {
  const CardFooter({
    super.key,
    required this.text,
    required this.amount,
    required this.icon,
    required this.iconColor,
  });

  final String text;
  final double amount;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Display the icon with the specified color
          Icon(icon, color: iconColor),
          // Add spacing between icon and footer text
          const SizedBox(width: ASizes.spaceBtwItems / 2),
          // Display footer text widget
          AFooterText(text: text, amount: amount),
        ],
      ),
    );
  }
}
