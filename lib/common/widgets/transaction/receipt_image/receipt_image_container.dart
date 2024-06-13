import 'dart:io';
import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';

// Widget for displaying the selected invoice image
class AReceiptImageContainer extends StatelessWidget {
  const AReceiptImageContainer({
    super.key,
    required this.imagePath,
    required this.onClearImage,
  });

  final String imagePath;
  final VoidCallback onClearImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ASizes.md),
      decoration: BoxDecoration(
        border: Border.all(color: AColors.borderPrimary),
        borderRadius: BorderRadius.circular(ASizes.borderRadiusLg),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ASizes.borderRadiusLg),
          child: Stack(
            children: [
              Image.file(
                File(imagePath),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: onClearImage,
                  child: const Icon(Iconsax.close_circle5, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
