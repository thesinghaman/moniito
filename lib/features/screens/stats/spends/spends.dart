import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '/common/widgets/cards/transaction_card/transaction_card.dart';
import '/common/widgets/texts/month_date_heading.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';
import '/utils/constants/text_strings.dart';

class ASpends extends StatelessWidget {
  const ASpends({super.key});

  @override
  Widget build(BuildContext context) {
    var list = [
      const ATransactionCard(
        transactionTitle: 'Pizza',
        categoryType: 'Food / Dining',
        color: AColors.warning,
        icon: UniconsLine.utensils,
        amount: 500,
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
        amount: 65000,
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
    return Column(
      children: [
        /// -- Month, Year Heading
        const AMonthHeading(month: ATexts.monthDate, year: ATexts.year),
        const SizedBox(height: ASizes.spaceBtwItems),

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
          itemCount: 9,
        ),
      ],
    );
  }
}
