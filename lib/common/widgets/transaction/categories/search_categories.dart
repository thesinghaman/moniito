import 'package:flutter/material.dart';

import '/features/app/controllers/transaction_controller.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';

class ASearchCategories extends StatelessWidget {
  const ASearchCategories({
    super.key,
    required this.controller,
  });

  final TransactionController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ASizes.defaultSpace),
      child: TextField(
        controller: controller.searchController,
        onChanged: controller.filterCategories,
        decoration: const InputDecoration(
          hintText: 'Search Categories',
          prefixIcon: Icon(Iconsax.search_normal4, color: AColors.darkGrey),
        ),
      ),
    );
  }
}
