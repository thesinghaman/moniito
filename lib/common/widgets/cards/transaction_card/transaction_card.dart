import 'package:flutter/material.dart';

import '/common/widgets/container/transaction_card_container.dart';
import '/common/widgets/icons/category_icon.dart';
import '/common/widgets/cards/transaction_card/widgets/amount_text.dart';
import '/common/widgets/cards/transaction_card/widgets/subtitle_text.dart';
import '/common/widgets/cards/transaction_card/widgets/title_text.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

class ATransactionCard extends StatelessWidget {
  const ATransactionCard(
      {super.key,
      required this.transactionTitle,
      required this.categoryType,
      required this.color,
      required this.icon,
      required this.amount,
      this.isExpense = true,
      this.date = ""});

  final String transactionTitle;
  final String categoryType;
  final Color color;
  final String? date;
  final IconData icon;
  final double amount;
  final bool? isExpense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ASizes.md),

      /// -- Card Background for the Transaction Card.
      child: ATransactionCardContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// -- Category Icon
                  ACategoryIcon(backgroundColor: color, icon: icon),
                  const SizedBox(width: ASizes.md),

                  /// -- Transaction Title and Category
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// -- Transaction Title
                        ATransactionTitle(title: transactionTitle),
                        const SizedBox(height: ASizes.xs),

                        /// -- Category Type
                        ASubtitleText(
                            subtitle: categoryType,
                            fontColor: AColors.darkerGrey.withOpacity(0.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// -- Transaction Amount and Date
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// -- Transaction Amount
                  ATransactionAmount(amount: amount, isExpense: isExpense),
                  const SizedBox(height: ASizes.xs),

                  /// -- Date
                  ASubtitleText(
                      subtitle: date!,
                      fontColor: AColors.darkerGrey.withOpacity(0.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
