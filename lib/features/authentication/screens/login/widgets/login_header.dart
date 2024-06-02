import 'package:flutter/material.dart';

import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';

class ALoginHeader extends StatelessWidget {
  const ALoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ATexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: ASizes.sm),
        Text(ATexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
