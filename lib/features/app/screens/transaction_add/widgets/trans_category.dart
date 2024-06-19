import 'package:flutter/material.dart';

import '/common/widgets/appbar/appbar.dart';
import '/common/widgets/transaction/categories/category_list.dart';
import '/common/widgets/transaction/categories/search_categories.dart';
import '/utils/constants/sizes.dart';
import '/features/app/controllers/transaction_controller.dart';

class ATransactionsCategory extends StatelessWidget {
  const ATransactionsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TransactionController.instance;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -- App Bar
              const AAppBar(
                title: Text('Select Category'),
                showBackArrow: true,
                centerTitle: true,
              ),
              const SizedBox(height: ASizes.spaceBtwItems),

              /// -- Search Bar
              ASearchCategories(controller: controller),

              /// -- Category List
              ACategoryList(controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}
