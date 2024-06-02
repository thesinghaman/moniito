import 'package:flutter/material.dart';

import '/utils/constants/text_strings.dart';
import '/utils/helpers/helper_functions.dart';

class ATransactionAmount extends StatelessWidget {
  const ATransactionAmount(
      {super.key, this.credit = false, required this.amount});

  final bool? credit;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${credit == true ? '+' : '-'} ${ATexts.indianRupee} ${AHelperFunctions.formatAmount(amount)}',
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: credit == true
              ? AHelperFunctions.getColor('Green')
              : AHelperFunctions.getColor('Red'),
          fontSize: 15),
    );
  }
}
