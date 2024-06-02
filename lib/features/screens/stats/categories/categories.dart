import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/common/widgets/cards/category_card/category_card.dart';

class ACategories extends StatelessWidget {
  const ACategories({super.key});

  @override
  Widget build(BuildContext context) {
    var list = [
      const ACategoryCard(
          transactionTitle: 'Shopping',
          numOfTransactions: '4 Transactions',
          color: AColors.success,
          icon: UniconsLine.shopping_cart,
          tempValue: 100,
          amount: 1599),
      const ACategoryCard(
        transactionTitle: 'Fuel',
        numOfTransactions: '10 Transactions',
        color: Colors.blue,
        icon: UniconsLine.pump,
        tempValue: 15,
        amount: 275,
      ),
      const ACategoryCard(
        transactionTitle: 'Loan / Dues',
        numOfTransactions: '3 Transactions',
        color: Colors.purpleAccent,
        tempValue: 4,
        icon: UniconsLine.bill,
        amount: 10755,
      ),
      const ACategoryCard(
        transactionTitle: 'Subscriptions',
        numOfTransactions: '3 Transactions',
        color: Colors.blueGrey,
        icon: UniconsLine.globe,
        tempValue: 30,
        amount: 499,
      ),
      const ACategoryCard(
        transactionTitle: 'Travel',
        numOfTransactions: '10 Transactions',
        color: Colors.orangeAccent,
        icon: UniconsLine.metro,
        tempValue: 20,
        amount: 250,
      ),
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: ASizes.spaceBtwSections),

          /// -- List of Recent Transactions
          ListView.builder(
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
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
