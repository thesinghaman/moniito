import 'package:flutter/material.dart';

import '/utils/constants/text_strings.dart';
import '/utils/helpers/helper_functions.dart';

class ATransactionAmount extends StatelessWidget {
  const ATransactionAmount(
      {super.key, this.isExpense = true, required this.amount});

  final bool? isExpense;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${isExpense == true ? '-' : '+'} ${ATexts.indianRupee} ${AHelperFunctions.formatAmount(amount)}',
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 15,
            color: isExpense == true
                ? AHelperFunctions.getColor('Red')
                : AHelperFunctions.getColor('Green'),
          ),
    );
  }
}
