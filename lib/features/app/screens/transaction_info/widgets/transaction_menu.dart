import 'package:flutter/material.dart';

import '/common/widgets/texts/section_heading.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import 'transaction_menu_text.dart';

class ATransactionMenu extends StatelessWidget {
  const ATransactionMenu({
    super.key,
    required this.title,
    required this.category,
    required this.time,
    required this.date,
    required this.notes,
  });

  final String title, category, time, date, notes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ASizes.md),
      child: Column(
        children: [
          // Heading
          const ASectionHeading(
              title: ATexts.transactionDetails, showActionButton: false),
          const SizedBox(height: ASizes.spaceBtwItems),

          // Title
          ATransactionMenuText(title: ATexts.title, value: title),
          const SizedBox(height: ASizes.sm),

          // Category
          ATransactionMenuText(title: ATexts.category, value: category),
          const SizedBox(height: ASizes.sm),

          // Time
          ATransactionMenuText(title: ATexts.time, value: time),
          const SizedBox(height: ASizes.sm),

          // Date
          ATransactionMenuText(title: ATexts.date, value: date),
          const SizedBox(height: ASizes.spaceBtwItems),
          const Divider(),
          const SizedBox(height: ASizes.spaceBtwItems),

          // 'Notes' Heading
          const ASectionHeading(title: ATexts.notes, showActionButton: false),
          const SizedBox(height: ASizes.spaceBtwItems),

          // Notes
          Container(
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(color: AColors.grey),
                borderRadius: BorderRadius.circular(ASizes.borderRadiusLg)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ASizes.md, vertical: ASizes.sm),
                child:
                    Text(notes, style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
