import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:get/get.dart';
import 'package:moniito_v2/features/app/controllers/transaction_controller.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';

class AAddInvoiceButton extends StatelessWidget {
  final String title;
  final TransactionController controller = TransactionController.instance;

  AAddInvoiceButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Iconsax.gallery),
                title: Text('Photo Library'),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Iconsax.camera),
                title: Text('Camera'),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          if (controller.image.value.path.isEmpty)
            OutlinedButton(
              onPressed: () => _showPicker(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.receipt, color: AColors.darkGrey),
                  const SizedBox(width: ASizes.md),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AColors.darkGrey, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(ASizes.md),
              decoration: BoxDecoration(
                border: Border.all(color: AColors.borderPrimary),
                borderRadius: BorderRadius.circular(
                  ASizes.borderRadiusLg,
                ),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(ASizes.borderRadiusLg),
                  child: Stack(
                    children: [
                      Image.file(
                        File(controller.image.value.path),
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                            onTap: () {
                              controller.clearImage();
                            },
                            child:
                                Icon(Iconsax.close_circle5, color: Colors.red)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
