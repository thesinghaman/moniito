import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '/common/widgets/appbar/appbar.dart';
import '/common/widgets/container/primary_header_container.dart';
import '/common/widgets/buttons/outlined_button.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import 'widgets/transaction_logo.dart';
import 'widgets/transaction_menu.dart';
import 'widgets/transaction_type_text.dart';

class TransactionInfoScreen extends StatelessWidget {
  const TransactionInfoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AColors.light,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -- Primary Header Contaiener
            APrimaryHeaderContainer(
              height: 160,

              // App Bar
              child: AAppBar(
                title: Text(
                  ATexts.transactionDetails,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w500, color: AColors.textWhite),
                ),
                showBackArrow: true,
                centerTitle: true,
                iconColor: AColors.white,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(UniconsLine.ellipsis_v,
                          color: AColors.white)),
                ],
              ),
            ),

            // -- Transaction Logo
            const ATransactionLogo(
                color: AColors.warning, icon: UniconsLine.wrench),
            const SizedBox(height: ASizes.spaceBtwItems),

            // -- Transaction Type Text
            const ATransactionTypeText(isExpense: true),
            const SizedBox(height: ASizes.spaceBtwItems),

            // -- Transaction Amount Text
            Text(
              '${ATexts.indianRupee} 500.00',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AColors.darkerGrey),
            ),
            const SizedBox(height: ASizes.spaceBtwSections),

            // -- Transaction Menu
            const ATransactionMenu(
              title: ATexts.titleValue,
              category: ATexts.categoryValue,
              time: ATexts.timeValue,
              date: ATexts.dateValue,
              notes: ATexts.comment,
            ),
            const SizedBox(height: ASizes.spaceBtwSections * 2),

            // 'Download Receipt' Button
            const AOutlinedButton(text: ATexts.downloadReceipt),
          ],
        ),
      ),
    );
  }
}
