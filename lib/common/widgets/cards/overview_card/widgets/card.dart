// Import necessary packages and files
import 'package:flutter/material.dart';

// Import custom constants
import '/utils/constants/sizes.dart';

class ACard extends StatelessWidget {
  const ACard({
    super.key,
    required this.child,
    required this.startColor,
    required this.endColor,
  });

  final Widget child;
  final Color startColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ASizes.cardRadiusLg)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(ASizes.cardRadiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(ASizes.md),
          child: child,
        ),
      ),
    );
  }
}
