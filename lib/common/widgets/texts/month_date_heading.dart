import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/text_strings.dart';
import '/utils/constants/sizes.dart';

class AMonthHeading extends StatelessWidget {
  const AMonthHeading({super.key, required this.month, required this.year});

  final String month;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ASizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// -- Month
          Flexible(
            child: Text(
              month,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 20),
            ),
          ),
          const SizedBox(width: ASizes.sm),

          /// -- Dot
          const Text(
            ATexts.dot,
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(width: ASizes.sm),

          /// -- Year
          Flexible(
            child: Text(
              year,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(color: AColors.darkGrey),
            ),
          ),
        ],
      ),
    );
  }
}
