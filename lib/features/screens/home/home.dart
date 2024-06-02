// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:unicons/unicons.dart';

// Importing custom widgets and constants
import '/common/widgets/cards/overview_card/overview_card.dart';
import '/common/widgets/texts/section_heading.dart';
import '/common/widgets/cards/transaction_card/transaction_card.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/constants/colors.dart';
import '/utils/icons/iconsax_icons.dart';
import 'widgets/home_appbar.dart';
import '/features/screens/transaction_info/transaction_info.dart';
import '/home_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var list = [
      const ATransactionCard(
        transactionTitle: 'Tasty Pizza from Pizza King',
        categoryType: 'Food / Dining',
        color: AColors.warning,
        icon: UniconsLine.utensils,
        amount: 6500000,
        date: 'Sat, 30 Mar 2023',
      ),
      const ATransactionCard(
        transactionTitle: 'Shirt',
        categoryType: 'Shopping',
        color: AColors.success,
        icon: UniconsLine.shopping_cart,
        amount: 1500,
        date: 'Sat, 30 Mar 2023',
      ),
      const ATransactionCard(
        transactionTitle: 'Petrol',
        categoryType: 'Fuel',
        color: Colors.blue,
        icon: UniconsLine.pump,
        amount: 275,
        date: 'Sat, 30 Mar 2023',
      ),
      const ATransactionCard(
        transactionTitle: 'EMI',
        categoryType: 'Loan / Dues',
        color: Colors.purpleAccent,
        icon: UniconsLine.bill,
        amount: 10755,
        date: 'Sat, 30 Mar 2023',
      ),
      const ATransactionCard(
        transactionTitle: 'Netflix',
        categoryType: 'Subscriptions',
        color: Colors.blueGrey,
        icon: UniconsLine.globe,
        amount: 499,
        date: 'Sat, 30 Mar 2023',
      ),
      const ATransactionCard(
        transactionTitle: 'Uber',
        categoryType: 'Travel',
        color: Colors.orangeAccent,
        icon: UniconsLine.metro,
        amount: 250,
        date: 'Sat, 30 Mar 2023',
      ),
      const ATransactionCard(
        transactionTitle: 'iPhone',
        categoryType: 'Gadgets / Electronics',
        color: Colors.greenAccent,
        icon: Iconsax.mobile,
        amount: 6500000,
        date: 'Sat, 30 Mar 2023',
      ),
      const ATransactionCard(
        transactionTitle: 'Macbook Battery',
        categoryType: 'Repair',
        color: Colors.redAccent,
        icon: UniconsLine.wrench,
        amount: 15000,
        date: 'Sat, 30 Mar 2023',
      ),
      const ATransactionCard(
        transactionTitle: 'Mom\'s Gift',
        categoryType: 'Gift',
        color: Colors.lightBlueAccent,
        icon: UniconsLine.gift,
        amount: 2475,
        date: 'Sat, 30 Mar 2023',
      )
    ];
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
            GestureDetector(
              onTap: () => Get.to(const TransactionInfoScreen()),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      list[index],
                      const SizedBox(height: ASizes.md),
                    ],
                  );
                },
                itemCount: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
