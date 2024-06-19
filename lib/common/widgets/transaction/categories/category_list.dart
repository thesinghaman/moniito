import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/features/app/controllers/transaction_controller.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

class ACategoryList extends StatelessWidget {
  const ACategoryList({
    super.key,
    required this.controller,
  });

  final TransactionController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ASizes.defaultSpace),
      child: Obx(() {
        final firstLetters = controller.filteredCategories
            .map((entry) => entry.value[0].toUpperCase())
            .toSet()
            .toList()
          ..sort();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: ASizes.spaceBtwItems),
            ...firstLetters.map((letter) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: ASizes.spaceBtwItems),
                  Padding(
                    padding: const EdgeInsets.only(bottom: ASizes.sm),
                    child: Text(letter),
                  ),
                  ...controller.filteredCategories
                      .where((entry) => entry.value[0].toUpperCase() == letter)
                      .map((entry) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedCategory.value = entry.key;
                        Navigator.pop(
                            context, controller.selectedCategory.value);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: ASizes.md, vertical: ASizes.md),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AColors.primary,
                              ),
                              borderRadius:
                                  BorderRadius.circular(ASizes.borderRadiusLg),
                            ),
                            child: Text(
                              entry.value,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(height: ASizes.spaceBtwItems),
                        ],
                      ),
                    );
                  }),
                ],
              );
            }),
          ],
        );
      }),
    );
  }
}
