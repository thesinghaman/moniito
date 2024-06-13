import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '/utils/icons/iconsax_icons.dart';

class APicker {
  static void showPicker(BuildContext context, final controller) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext buildContext) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Iconsax.gallery),
                title: const Text('Photo Library'),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Iconsax.camera),
                title: const Text('Camera'),
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
}
