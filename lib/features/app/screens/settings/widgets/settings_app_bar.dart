import 'package:flutter/material.dart';

import '/common/widgets/appbar/appbar.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/text_strings.dart';

class ASettingsAppBar extends StatelessWidget {
  const ASettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AAppBar(
      title: Text(
        ATexts.account,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontWeight: FontWeight.w500, color: AColors.white),
      ),
    );
  }
}
