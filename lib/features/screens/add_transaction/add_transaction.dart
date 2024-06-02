import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: AColors.light,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- Primary Header
            const APrimaryHeaderContainer(
              height: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar
                  AAddTransactionAppBar(),

                  // Add Amount Text Field
                  AAddAmountTextField(),
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
            const ATextField(
                icon: Iconsax.document_text_1,
                hintText: ATexts.transactionTitle),
            const SizedBox(height: ASizes.spaceBtwItems),

            // Category Field
            ACategoryField(
              onTap: () {},
            ),
            const SizedBox(height: ASizes.spaceBtwItems),

            // Description Field
            const ATextField(icon: Iconsax.note_2, hintText: ATexts.notes),
            const SizedBox(height: ASizes.spaceBtwItems),

            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ASizes.md + 5, vertical: ASizes.xs - 1),
              child: Column(
                children: [
                  // Add Invoice Button
                  AAddInvoiceButton(title: ATexts.addInvoice, onPressed: () {}),
                  const SizedBox(height: ASizes.spaceBtwSections * 3),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text(ATexts.save)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
