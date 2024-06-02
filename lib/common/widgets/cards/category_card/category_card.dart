import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

import '/common/widgets/icons/category_icon.dart';
import '/common/widgets/cards/category_card/widgets/percentage.dart';
import '/common/widgets/container/transaction_card_container.dart';

import './widgets/amount_text.dart';
import './widgets/subtitle_text.dart';
import './widgets/title_text.dart';

class ACategoryCard extends StatelessWidget {
  const ACategoryCard(
      {super.key,
      required this.transactionTitle,
      required this.numOfTransactions,
      required this.color,
      required this.icon,
      required this.amount,
      this.credit = false,
      required this.tempValue});

  final String transactionTitle;
  final String numOfTransactions;
  final Color color;
  final IconData icon;
  final double amount;
  final bool credit;
  final double tempValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ASizes.md),

      /// -- Card Background
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

                  /// -- Transaction Title, Number of Transactions and Percentage
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// -- Transaction Title
                        ATransactionTitle(title: transactionTitle),
                        const SizedBox(height: ASizes.xs),

                        /// -- Number of Transactions and Percentage
                        Row(
                          children: [
                            /// -- Percentage
                            APercentage(value: tempValue, color: color),
                            const SizedBox(width: ASizes.sm),

                            /// -- Number of Transactions
                            Flexible(
                              child: ASubtitleText(
                                  subtitle: numOfTransactions,
                                  fontColor:
                                      AColors.darkerGrey.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// -- Transaction Amount and Forward Arrow
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// -- Transaction Amount
                  Flexible(child: ATransactionAmount(amount: amount)),

                  /// -- Forward Arrow
                  const Icon(FontAwesomeIcons.angleRight)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
