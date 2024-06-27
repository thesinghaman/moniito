import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

import '/features/personalization/controllers/user_controller.dart';
import '/common/widgets/appbar/appbar.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/validators/validation.dart';
import '/utils/formatters/formatter.dart';

class EditOverviewCard extends StatelessWidget {
  EditOverviewCard({super.key}) {
    controller.totalBalance = TextEditingController(
        text: controller.user.value.totalBalance == ""
            ? '0'
            : AFormatter.formatAmount(
                double.parse(controller.user.value.totalBalance)));
  }
  final controller = UserController.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        showBackArrow: true,
        title: Text('Edit Total Balance',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter the total income of the month.',
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: ASizes.spaceBtwSections),
            Form(
              key: controller.editTotalBalanceKey,
              child: Column(
                children: [
                  TextFormField(
                    inputFormatters: [
                      IntegerDecimalThousandsSeparatorInputFormatter()
                    ],
                    controller: controller.totalBalance,
                    validator: (value) => AValidator.validateAmount(value),
                    decoration: const InputDecoration(
                      labelText: ATexts.totalBalance,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateTotalBalance(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
