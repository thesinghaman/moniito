import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moniito_v2/features/transactions/controller/transaction_controller.dart';
import 'package:moniito_v2/features/transactions/models/transaction_model.dart';

import '/common/widgets/container/primary_header_container.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/text_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';
import 'widgets/add_amount_textfield.dart';
import 'widgets/category_field.dart';
import 'widgets/invoice_button.dart';
import 'widgets/text_field.dart';
import 'widgets/trans_type_checkbox.dart';
import 'widgets/add_transaction_app_bar.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    return Scaffold(
      backgroundColor: AColors.light,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- Primary Header
            APrimaryHeaderContainer(
              height: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar
                  const AAddTransactionAppBar(),

                  // Add Amount Text Field
                  AAddAmountTextField(amount: controller.amount),
                ],
              ),
            ),

            // Transaction Type CheckBox
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ATransTypeCheckbox(
                    color: Colors.red, value: true, title: ATexts.expense),
                ATransTypeCheckbox(
                    color: Colors.green, value: false, title: ATexts.income),
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwSections),

            // Transaction Name Field
            ATextField(
              icon: Iconsax.document_text_1,
              hintText: ATexts.transactionTitle,
              textFieldController: controller.transactionTitle,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),

            // Category Field
            ACategoryField(
              categoryController: controller.category,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),

            // Description Field
            ATextField(
              icon: Iconsax.note_2,
              hintText: ATexts.notes,
              textFieldController: controller.description,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),

            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ASizes.md + 5, vertical: ASizes.xs - 1),
              child: Column(
                children: [
                  // Add Invoice Button
                  AAddInvoiceButton(
                    title: ATexts.addInvoice,
                  ),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: SafeArea(
                      child: ElevatedButton(
                          onPressed: () => t(), child: const Text(ATexts.save)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void t() {
    TransactionModel transaction = TransactionModel(
      id: '1',
      amount: '100',
      transactionTitle: 'Example Transaction',
      isExpense: true,
      category: 'Example Category',
      date: '2024-06-10',
    );
    final controller = TransactionController.instance;
    controller.saveUserTransactions(transaction);
  }
}
