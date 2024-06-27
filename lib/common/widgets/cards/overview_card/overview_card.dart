// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moniito_v2/features/app/controllers/transaction_controller.dart';
import 'package:moniito_v2/features/personalization/controllers/user_controller.dart';

// Importing custom widgets and constants
import 'widgets/card.dart';
import 'widgets/linear_progress_indicator.dart';
import 'widgets/card_header.dart';
import 'widgets/card_footer/card_footer.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/icons/iconsax_icons.dart';
import '/utils/helpers/helper_functions.dart';

// Defining a custom overview card widget
class AOverviewCard extends StatelessWidget {
  const AOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final transactionController = TransactionController.instance;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM, yyyy').format(now);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ASizes.md),
      child: Obx(() {
        double totalBalance = controller.user.value.totalBalance == ''
            ? 0
            : double.parse(controller.user.value.totalBalance);
        double totalExpense = transactionController.totalExpense.value == ''
            ? 0
            : double.parse(transactionController.totalExpense.value);
        final availableBalance = totalBalance - totalExpense;
        return ACard(
          startColor: AColors.secondary.withOpacity(0.5),
          endColor: AColors.greyGradient.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Availabe Balance
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ACardHeader(availableBalance: availableBalance),
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Linear Progress Bar
              ALinearProgressIndicator(
                  totalExpense: totalExpense, totalBalance: totalBalance),
              const SizedBox(height: ASizes.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Total Expense
                  CardFooter(
                    text: ATexts.totalExpense,
                    amount: totalExpense,
                    icon: Iconsax.arrow_circle_up3,
                    iconColor: AHelperFunctions.getColor('Red')!,
                  ),

                  // Total Balance
                  CardFooter(
                    text: ATexts.totalBalance,
                    amount: totalBalance,
                    icon: Iconsax.arrow_circle_down4,
                    iconColor: AHelperFunctions.getColor('Green')!,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
