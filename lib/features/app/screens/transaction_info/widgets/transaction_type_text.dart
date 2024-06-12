import 'package:flutter/material.dart';

import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/helpers/helper_functions.dart';

class ATransactionTypeText extends StatelessWidget {
  const ATransactionTypeText({
    super.key,
    required this.isExpense,
  });

  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ASizes.sm, vertical: ASizes.xs - 2),
      decoration: BoxDecoration(
        color: isExpense
            ? AHelperFunctions.getColor('Red')!.withOpacity(0.15)
            : AHelperFunctions.getColor('Green')!.withOpacity(0.15),
        borderRadius: BorderRadius.circular(ASizes.borderRadiusLg),
      ),
      child: Text(
        isExpense ? ATexts.expense : ATexts.income,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: isExpense
                ? AHelperFunctions.getColor('Red')
                : AHelperFunctions.getColor('Green')),
      ),
    );
  }
}
