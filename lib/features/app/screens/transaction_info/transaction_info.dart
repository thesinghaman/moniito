import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moniito_v2/features/app/controllers/transaction_controller.dart';
import 'package:unicons/unicons.dart';

import '/common/widgets/dialogs/show_receipt_dialog.dart';
import '/common/widgets/appbar/appbar.dart';
import '/common/widgets/container/primary_header_container.dart';
import '/features/app/models/transaction_model.dart';
import '/utils/constants/enums.dart';
import '/utils/helpers/helper_functions.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import 'widgets/transaction_logo.dart';
import 'widgets/transaction_menu.dart';
import 'widgets/transaction_type_text.dart';

class TransactionInfoScreen extends StatelessWidget {
  const TransactionInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the transaction data passed as arguments
    final TransactionModel transaction = Get.arguments;
    final controller = TransactionController.instance;
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
                  PopupMenuButton<String>(
                      icon: const Icon(UniconsLine.ellipsis_v,
                          color: AColors.white),
                      onSelected: (String result) {
                        switch (result) {
                          case 'Edit':
                            // Handle edit action
                            print('Edit selected');
                            break;
                          case 'Delete':
                            controller
                                .deleteTransactionWarningPopup(transaction.id);
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'Edit',
                              child: Text('Edit',
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                            PopupMenuItem<String>(
                              value: 'Delete',
                              child: Text('Delete',
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                          ])
                ],
              ),
            ),

            // -- Transaction Logo
            ATransactionLogo(
                color: categoryColors[transaction.category]!,
                icon: categoryIcons[transaction.category]!),
            const SizedBox(height: ASizes.spaceBtwItems),

            // -- Transaction Type Text
            ATransactionTypeText(isExpense: transaction.isExpense),
            const SizedBox(height: ASizes.spaceBtwItems),

            // -- Transaction Amount Text
            Text(
              '${ATexts.indianRupee} ${AHelperFunctions.formatAmount(double.parse(transaction.amount))}',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AColors.darkerGrey),
            ),
            const SizedBox(height: ASizes.spaceBtwSections),

            // -- Transaction Menu
            ATransactionMenu(
              title: transaction.transactionTitle,
              category: categories[transaction.category]!,
              date: transaction.date,
              notes: transaction.description.isEmpty
                  ? 'No notes added.'
                  : transaction.description,
            ),
            const SizedBox(height: ASizes.spaceBtwSections * 1.5),

            // Receipt section
            if (transaction.receiptImage.isNotEmpty)
              OutlinedButton(
                onPressed: () {
                  // Show receipt image with loading indicator and blurred background
                  Get.dialog(
                      ReceiptDialog(receiptImageUrl: transaction.receiptImage));
                },
                child: const Text('Show Receipt'),
              )

            // 'Download Receipt' Button
            //const AOutlinedButton(text: ATexts.downloadReceipt),
          ],
        ),
      ),
    );
  }
}
