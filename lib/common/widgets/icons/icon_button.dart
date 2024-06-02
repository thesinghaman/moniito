// Import necessary packages and files
import 'package:flutter/material.dart';

// Import custom color constants, icon data, and size constants
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';

// A custom widget representing an icon with an InkWell for tap interaction
class AIconButton extends StatelessWidget {
  // Constructor with named parameters and a required iconColor
  const AIconButton({
    super.key,
    this.height,
    this.width,
    this.shape,
    this.color,
    required this.icon,
    required this.iconColor,
  });

  // Properties for widget customization
  final double? height;
  final double? width;
  final BoxShape? shape;
  final Color? color;
  final Color? iconColor;
  final IconData icon;

  // Build method to create the widget
  @override
  Widget build(BuildContext context) {
    // GestureDetector for tap interaction with an empty onTap function (no action)
    return Container(
      height: height, // Customizable height
      width: height, // Width set to height for a square container
      decoration: BoxDecoration(
        color: color, // Background color (nullable)
        border: Border.all(
            width: 1,
            color: AColors.darkGrey.withOpacity(0.5)), // Border customization
        // BorderRadius set based on the shape or default value
        borderRadius:
            shape == null ? BorderRadius.circular(ASizes.borderRadiusMd) : null,
        shape: shape ??
            BoxShape.rectangle, // Customizable shape (default: rectangle)
      ),
      // Padding around the icon for spacing
      child: Padding(
        padding: const EdgeInsets.all(ASizes.sm),
        // Icon widget with customizable size and color
        child: Icon(
          icon,
          size: ASizes.iconMd, // Customizable icon size
          color: iconColor, // Icon color (required)
        ),
      ),
    );
  }
}
