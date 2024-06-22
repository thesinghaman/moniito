import 'dart:ui';
import 'package:flutter/material.dart';

import '/utils/constants/sizes.dart';

class ReceiptDialog extends StatelessWidget {
  final String receiptImageUrl;

  const ReceiptDialog({super.key, required this.receiptImageUrl});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
      child: Dialog(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(ASizes.md),
              child: const CircularProgressIndicator(),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(ASizes.borderRadiusLg),
              child: Image.network(receiptImageUrl),
            ),
          ],
        ),
      ),
    );
  }
}
