import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moniito_v2/features/transactions/add_transaction/widgets/trans_category.dart';
import 'package:moniito_v2/features/transactions/models/transaction_model.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/icons/iconsax_icons.dart';

class ACategoryField extends StatelessWidget {
  const ACategoryField({super.key, required this.categoryController});

  final TextEditingController categoryController;

  @override
  Widget build(BuildContext context) {
    Rx<String> selectedCategory0 = Rx('');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: ASizes.defaultSpace),
      decoration: BoxDecoration(
        border: Border.all(color: AColors.borderPrimary),
        borderRadius: BorderRadius.circular(
          ASizes.borderRadiusLg,
        ),
      ),
      child: ListTile(
        onTap: () async {
          Category? selectedCategory =
              await Get.to(() => const TransactionsCategory());
          if (selectedCategory == null) {
            return;
          }
          categoryController.text =
              categoryType.values.elementAt(selectedCategory.index).toString();
          selectedCategory0.value = categoryController.text;
        },
        leading: const Icon(Iconsax.category, color: AColors.darkGrey),
        title: Obx(
          () => Text(
            selectedCategory0.value == ''
                ? ATexts.category
                : selectedCategory0.value,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AColors.darkGrey, fontWeight: FontWeight.w500),
          ),
        ),
        trailing: const Icon(Iconsax.arrow_down_1, color: AColors.darkGrey),
      ),
    );
  }
}
