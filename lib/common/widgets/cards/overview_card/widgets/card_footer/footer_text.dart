// Import necessary packages and files
import 'package:flutter/material.dart';

// Import utility functions
import '/utils/helpers/helper_functions.dart';
import '/utils/constants/text_strings.dart';

class AFooterText extends StatelessWidget {
  const AFooterText({
    super.key,
    required this.text,
    required this.amount,
  });

  final String text;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the text with bodyMedium style
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // Display the formatted amount with headlineSmall style
          Text(
            '${ATexts.indianRupee} ${AHelperFunctions.formatAmount(amount)}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
