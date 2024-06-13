import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moniito_v2/utils/constants/enums.dart';

import '../../../../features/app/controllers/transaction_controller.dart';
import '../../../../features/app/screens/transaction_add/widgets/trans_category.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/icons/iconsax_icons.dart';

class ACategoryField extends StatelessWidget {
  const ACategoryField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TransactionController.instance;

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
              await Get.to(() => const ATransactionsCategory());
          if (selectedCategory == null) {
            return;
          }
          controller.category.value =
              categoryType.values.elementAt(selectedCategory.index).toString();
        },
        leading: const Icon(Iconsax.category, color: AColors.darkGrey),
        title: Obx(
          () => Text(
            controller.category.value == ''
                ? ATexts.category
                : controller.category.value,
            style: controller.category.value == ''
                ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AColors.darkGrey, fontWeight: FontWeight.w500)
                : Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        trailing: const Icon(Iconsax.arrow_down_1, color: AColors.darkGrey),
      ),
    );
  }
}
