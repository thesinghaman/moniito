import 'package:flutter/material.dart';

import '/common/widgets/appbar/appbar.dart';
import '/utils/constants/colors.dart';

class AEditTransactionAppBar extends StatelessWidget {
  const AEditTransactionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AAppBar(
      title: Text(
        'Edit Transaction',
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontWeight: FontWeight.w500, color: AColors.white),
      ),
      centerTitle: true,
      showBackArrow: true,
      iconColor: AColors.white,
    );
  }
}
