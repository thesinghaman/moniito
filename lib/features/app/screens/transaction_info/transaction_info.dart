import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '/features/app/controllers/transaction_controller.dart';
import '/features/app/screens/transaction_edit/edit_transaction.dart';
import '/features/app/models/transaction_model.dart';
import '/common/widgets/dialogs/show_receipt_dialog.dart';
import '/common/widgets/appbar/appbar.dart';
import '/common/widgets/container/primary_header_container.dart';
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
    final controller = TransactionController.instance;

    return Scaffold(
      backgroundColor: AColors.light,
      body: Obx(() {
        // Get the transaction details.
        final TransactionModel transaction = controller.transactions.firstWhere(
          (trans) => trans.id == Get.arguments.id,
        );

        return SingleChildScrollView(
          child: Column(
            children: [
              APrimaryHeaderContainer(
                height: 160,
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
                            () => controller.clearFormFields();
                            Get.to(() => AEditTransactionScreen(
                                transaction: transaction));

                            break;
                          case 'Delete':
                            controller.deleteWarningPopup(
                              'Delete Transaction',
                              'Are you sure you want to delete this transaction ? This action is not reversible.',
                              () =>
                                  controller.deleteTransaction(transaction.id!),
                            );
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
                      ],
                    ),
                  ],
                ),
              ),

              // Transation Logo
              ATransactionLogo(
                color: categoryColors[transaction.category]!,
                icon: categoryIcons[transaction.category]!,
              ),
              const SizedBox(height: ASizes.spaceBtwItems),

              // Transaction Type
              ATransactionTypeText(isExpense: transaction.isExpense),
              const SizedBox(height: ASizes.spaceBtwItems),

              // Transaction Amount
              Text(
                '${ATexts.indianRupee} ${AHelperFunctions.formatAmount(double.parse(transaction.amount))}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: AColors.darkerGrey),
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Other Transaction Details
              ATransactionMenu(
                title: transaction.transactionTitle,
                category: categories[transaction.category]!,
                date: transaction.date,
                notes: transaction.description.isEmpty
                    ? 'No notes added.'
                    : transaction.description,
              ),
              const SizedBox(height: ASizes.spaceBtwSections * 1.5),

              // If receipt image is stored, display "Show Receipt" button.
              if (transaction.receiptImage.isNotEmpty)
                OutlinedButton(
                  onPressed: () {
                    Get.dialog(ReceiptDialog(
                        receiptImageUrl: transaction.receiptImage));
                  },
                  child: const Text('Show Receipt'),
                ),
            ],
          ),
        );
      }),
    );
  }
}
