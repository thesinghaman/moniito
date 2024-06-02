// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Importing custom widgets and constants
import '/utils/constants/colors.dart';
import '/utils/constants/text_strings.dart';
import '/utils/helpers/helper_functions.dart';
import '/utils/icons/iconsax_icons.dart';
import '/common/widgets/icons/icon_button.dart';
import '/common/widgets/appbar/appbar.dart';
import '/features/screens/add_transaction/add_transaction.dart';

// Custom AppBar for the home screen
class AHomeAppBar extends StatelessWidget {
  // Constructor for the AHomeAppBar widget
  const AHomeAppBar({super.key});

  // Build method to create the AHomeAppBar widget
  @override
  Widget build(BuildContext context) {
    // Return a custom AAppBar widget for the home screen
    return AAppBar(
      // Set the title of the AppBar as a Column with greeting and user's first name
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // Display a personalized greeting using helper function
            '${AHelperFunctions.getGreeting()},',
            // Apply styling to the greeting text
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .apply(color: AColors.textSecondary, fontWeightDelta: 1),
          ),
          Text(
            // Display the user's first name
            ATexts.userFirstName,
            // Apply styling to the user's first name text
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
      // Set the actions of the AppBar, including an add icon
      actions: [
        IconButton(
            onPressed: () => Get.to(const AddTransactionScreen()),
            icon: const AIconButton(
              iconColor: AColors.primary,
              icon: Iconsax.add,
            ))
      ],
    );
  }
}
