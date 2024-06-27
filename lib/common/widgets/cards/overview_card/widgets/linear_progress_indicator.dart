// Import necessary packages and files
import 'package:flutter/material.dart';

// Importing color and size constants
import '/utils/constants/sizes.dart';
import '/utils/helpers/helper_functions.dart';

// Defining a custom linear progress indicator widget
class ALinearProgressIndicator extends StatelessWidget {
  // Constructor for the custom widget
  const ALinearProgressIndicator(
      {super.key, required this.totalExpense, required this.totalBalance});

  // Declaring properties for total expense and total balance
  final double totalExpense;
  final double totalBalance;

  @override
  Widget build(BuildContext context) {
    // Calculating the ratio of total expense to total balance
    double ratio = 0;
    if (totalBalance != 0) ratio = totalExpense / totalBalance;

    // Function to determine the color of the progress indicator based on the ratio
    Color getProgressColor() {
      if (ratio <= 0.50) {
        return AHelperFunctions.getColor('Green')!; // Green color for low ratio
      } else if (ratio > 0.50 && ratio <= 0.75) {
        return AHelperFunctions.getColor(
            'Orange')!; // Yellow color for moderate ratio
      } else {
        return AHelperFunctions.getColor('Red')!; // Red color for high ratio
      }
    }

    // Building the linear progress indicator
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: SizedBox(
        height: ASizes.sm, // Setting the height of the progress indicator
        child: LinearProgressIndicator(
          value: ratio, // Setting the progress value
          backgroundColor: Colors.grey, // Setting the background color
          valueColor: AlwaysStoppedAnimation<Color>(
            getProgressColor(), // Setting the progress indicator color
          ),
        ),
      ),
    );
  }
}
