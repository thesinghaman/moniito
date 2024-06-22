import 'package:flutter/material.dart';

import '/common/widgets/transaction/text_fields/date_picker.dart';
import '/features/app/controllers/transaction_controller.dart';
import '/utils/validators/validation.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/icons/iconsax_icons.dart';

class ADateField extends StatelessWidget {
  const ADateField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TransactionController.instance;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: ASizes.md, vertical: ASizes.xs - 1),
      child: TextFormField(
        readOnly: true,
        onTap: () {
          ADatePicker.selectDate(context, controller.date);
        },
        controller: controller.date,
        validator: (value) => AValidator.validateDate(value),
        maxLines: 1,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: AColors.darkerGrey, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            hintText: ATexts.date,
            hintStyle: const TextStyle().copyWith(
                fontSize: ASizes.fontSizeLg,
                color: AColors.darkGrey,
                fontWeight: FontWeight.w500,
                fontFamily: 'Uber Move'),
            prefixIcon: const Icon(Iconsax.calendar_1, color: AColors.darkGrey),
            suffixIcon:
                const Icon(Iconsax.arrow_down_1, color: AColors.darkGrey),
            border: InputBorder.none,
            counterText: '',
            focusedBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
              borderSide: const BorderSide(width: 1, color: AColors.grey),
            )),
      ),
    );
  }
}
