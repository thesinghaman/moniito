// Import necessary packages and files
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ASizes.md),
      child: ACard(
        // Custom card widget
        startColor: AColors.secondary.withOpacity(0.5),
        endColor: AColors.greyGradient.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -- Available Amount Text.
            const ACardHeader(availableBalance: ATexts.aAvailableBalance),

            const SizedBox(height: ASizes.spaceBtwSections),

            /// -- Progress Indicator.
            const ALinearProgressIndicator(
                totalExpense: ATexts.aTotalExpense,
                totalBalance: ATexts.aTotalBalance),

            const SizedBox(height: ASizes.spaceBtwSections),

            // -- Total Balance, Balance Left.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Card footer widget for total expense
                CardFooter(
                  text: ATexts.totalExpense,
                  amount: ATexts.aTotalExpense,
                  icon: Iconsax.arrow_circle_up3,
                  iconColor: AHelperFunctions.getColor('Red')!,
                ),

                // Card footer widget for total balance
                CardFooter(
                  text: ATexts.totalBalance,
                  amount: ATexts.aTotalBalance,
                  icon: Iconsax.arrow_circle_down4,
                  iconColor: AHelperFunctions.getColor('Green')!,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
