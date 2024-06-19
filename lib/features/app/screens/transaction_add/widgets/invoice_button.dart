import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/common/widgets/transaction/receipt_image/add_receipt_outlined_button.dart';
import '/common/widgets/transaction/receipt_image/gallery_camera_picker.dart';
import '/common/widgets/transaction/receipt_image/receipt_image_container.dart';
import '/features/app/controllers/transaction_controller.dart';

class AAddInvoiceButton extends StatelessWidget {
  AAddInvoiceButton({super.key, required this.title});

  final String title;
  final TransactionController controller = TransactionController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          if (controller.image.value.path.isEmpty)
            AAddReceiptOutlinedButton(
              title: title,
              onPressed: () => APicker.showPicker(context, controller),
            )
          else
            AReceiptImageContainer(
                imagePath: controller.image.value.path,
                onClearImage: controller.clearImage)
        ],
      );
    });
  }
}
