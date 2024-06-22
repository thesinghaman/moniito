// Import necessary packages and files
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// Importing custom widgets and constants
import '/common/widgets/cards/overview_card/overview_card.dart';
import '/common/widgets/texts/section_heading.dart';
import '/common/widgets/cards/transaction_card/transaction_card.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/enums.dart';
import '/utils/constants/image_strings.dart';
import '/features/app/controllers/transaction_controller.dart';
import '/features/app/screens/transaction_info/transaction_info.dart';
import '/home_menu.dart';
import 'widgets/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());

    return Scaffold(
      backgroundColor: AColors.light,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Appbar
            const AHomeAppBar(),

            /// -- Overview Card
            const Padding(
              padding: EdgeInsets.only(top: ASizes.md),
              child: AOverviewCard(),
            ),

            const SizedBox(height: ASizes.md),

            /// -- Section Heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: ASizes.md),
              child: ASectionHeading(
                title: ATexts.recentTransactions,
                onPressed: () {
                  final controller = Get.put(AppScreenController());
                  controller.selectedMenu.value = 1;
                },
              ),
            ),

            const SizedBox(height: ASizes.md),

            /// -- List of Recent Transactions
            Obx(
              () => controller.transactionsByDate.isEmpty
                  ? Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: ASizes.md),
                      child: Column(
                        children: [
                          Lottie.asset(AImages.noTransactionIllustration,
                              width: MediaQuery.of(context).size.width * 0.8),
                          Text('No transactions to show. Try adding some.',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        final transaction =
                            controller.transactionsByDate[index];
                        return GestureDetector(
                          onTap: () => Get.to(
                            () => const TransactionInfoScreen(),
                            arguments: transaction,
                          ),
                          child: Column(
                            children: [
                              ATransactionCard(
                                transactionTitle: transaction.transactionTitle,
                                categoryType: categories[transaction.category]!,
                                color: categoryColors[transaction.category]!,
                                icon: categoryIcons[transaction.category]!,
                                amount: double.parse(transaction.amount),
                                date: transaction.date,
                                isExpense: transaction.isExpense,
                              ),
                              const SizedBox(height: ASizes.md),
                            ],
                          ),
                        );
                      },
                      itemCount: controller.transactions.length > 10
                          ? 10
                          : controller.transactions.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
