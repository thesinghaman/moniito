import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/features/app/controllers/transaction_controller.dart';
import '/common/widgets/transaction/text_fields/date_field.dart';
import '/common/widgets/container/primary_header_container.dart';
import '/common/widgets/transaction/text_fields/add_amount_textfield.dart';
import '/common/widgets/transaction/text_fields/category_field.dart';
import '/common/widgets/transaction/text_fields/text_field.dart';
import '/common/widgets/transaction/checkbox/trans_type_checkbox.dart';
import '/common/widgets/transaction/buttons/invoice_button.dart';
import '/utils/validators/validation.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/text_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';
import 'widgets/add_transaction_app_bar.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    return Scaffold(
      backgroundColor: AColors.light,
      body: SingleChildScrollView(
        child: Form(
          key: controller.addTransactionFormKey,
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
              ACategoryField(controller: controller.categoryController),
              const SizedBox(height: ASizes.spaceBtwItems),

              // Date Field
              ADateField(
                controller: controller.date,
              ),
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
                    // Add Invoice Button
                    AAddInvoiceButton(title: ATexts.addInvoice),
                    const SizedBox(height: ASizes.spaceBtwSections * 2),
                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => controller.saveUserTransactions(),
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
