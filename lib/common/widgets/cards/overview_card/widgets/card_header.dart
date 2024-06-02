// Import necessary packages and files
import 'package:flutter/material.dart';

// Import custom constants and utility functions
import '/utils/constants/text_strings.dart';
import '/utils/helpers/helper_functions.dart';

class ACardHeader extends StatelessWidget {
  const ACardHeader({
    super.key,
    required this.availableBalance,
  });

  final double availableBalance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the available balance text with titleSmall style
        Text(
          ATexts.availableBalance,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        // Display the formatted available balance with headlineMedium style
        Text(
          '${ATexts.indianRupee} ${AHelperFunctions.formatAmount(availableBalance)}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
