import 'package:flutter/material.dart';

import '/common/widgets/appbar/appbar.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/text_strings.dart';

class AAddTransactionAppBar extends StatelessWidget {
  const AAddTransactionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AAppBar(
      title: Text(
        ATexts.addTransactionScreen,
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
