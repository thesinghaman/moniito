import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/features/app/models/transaction_model.dart';
import '/features/app/controllers/transaction_controller.dart';
import '/common/widgets/transaction/text_fields/date_field.dart';
import '/common/widgets/container/primary_header_container.dart';
import '/common/widgets/transaction/text_fields/add_amount_textfield.dart';
import '/common/widgets/transaction/text_fields/category_field.dart';
import '/common/widgets/transaction/text_fields/text_field.dart';
import '/common/widgets/transaction/buttons/invoice_button.dart';
import '/common/widgets/transaction/checkbox/trans_type_checkbox.dart';
import '/utils/validators/validation.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/text_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';
import '/utils/constants/enums.dart';
import '/utils/formatters/formatter.dart';
import 'widgets/edit_transaction_app_bar.dart';
import 'widgets/edit_receipt_image.dart';

class AEditTransactionScreen extends StatelessWidget {
  AEditTransactionScreen({super.key, required this.transaction}) {
    controller.transactionTitle =
        TextEditingController(text: transaction.transactionTitle);
    controller.amount = TextEditingController(
        text: AFormatter.formatAmount(double.parse(transaction.amount)));
    controller.description =
        TextEditingController(text: transaction.description);
    controller.date = TextEditingController(text: transaction.date);
    controller.categoryController =
        TextEditingController(text: categories[transaction.category]);
    controller.selectedCategory.value = transaction.category;
    controller.isExpense.value = transaction.isExpense;
    controller.isIncome.value = !transaction.isExpense;
    controller.receiptImageUrl.value = transaction.receiptImage;
  }

  final TransactionModel transaction;
  final controller = TransactionController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AColors.light,
      body: SingleChildScrollView(
        child: Form(
          key: controller.editTransactionFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- Primary Header
              APrimaryHeaderContainer(
                height: 290,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Bar
                    const AEditTransactionAppBar(),

                    // Add Amount Text Field
                    AAddAmountTextField(amount: controller.amount),
                  ],
                ),
              ),

              // Transaction Type CheckBox
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ATransTypeCheckbox(color: Colors.red, title: ATexts.expense),
                  ATransTypeCheckbox(color: Colors.green, title: ATexts.income),
                ],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Transaction Name Field
              ATextFormField(
                validator: (value) =>
                    AValidator.validateEmptyText('Transaction Title', value),
                icon: Iconsax.document_text_1,
                hintText: ATexts.transactionTitle,
                textFieldController: controller.transactionTitle,
              ),
              const SizedBox(height: ASizes.spaceBtwItems),

              // Category Field
              ACategoryField(
                controller: controller.categoryController,
              ),
              const SizedBox(height: ASizes.spaceBtwItems),

              // Date Field
              ADateField(controller: controller.date),
              const SizedBox(height: ASizes.spaceBtwItems),

              // Description Field
              ATextFormField(
                  validator: (value) => AValidator.validateDescription(value),
                  icon: Iconsax.note_2,
                  hintText: ATexts.notes,
                  textFieldController: controller.description),
              const SizedBox(height: ASizes.spaceBtwItems),

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ASizes.md + 5, vertical: ASizes.xs - 1),
                child: Column(
                  children: [
                    Obx(() {
                      return controller.receiptImageUrl.value == ''
                          ? // Add Invoice Button
                          AAddInvoiceButton(title: ATexts.addInvoice)
                          : EditReceiptImage(
                              imageUrl: controller.receiptImageUrl.value,
                              onClearImage: () => controller.deleteWarningPopup(
                                    'Remove Receipt',
                                    'Are you sure you want to remove the receipt image ? This action is not reversible once you save the transaction',
                                    () {
                                      controller.receiptImageUrl.value = '';
                                      Navigator.of(Get.overlayContext!).pop();
                                    },
                                  ));
                    }),

                    const SizedBox(height: ASizes.spaceBtwSections * 2),
                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            await controller.editTransaction(transaction);
                            Get.back();
                          },
                          child: const Text(ATexts.save)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
