import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/validators/validation.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';

class AAddAmountTextField extends StatelessWidget {
  const AAddAmountTextField({super.key, required this.amount});

  final TextEditingController amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ASizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Amount Text
          Text(ATexts.amount,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AColors.grey)),

          // -- TextField to enter amount
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Currency Symbol
              Text('${ATexts.indianRupee} ',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AColors.textWhite)),

              // TextField
              Expanded(
                child: TextFormField(
                  validator: (value) => AValidator.validateAmount(value),
                  inputFormatters: [
                    IntegerDecimalThousandsSeparatorInputFormatter(),
                  ],
                  controller: amount,
                  maxLength: 15,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AColors.textWhite),
                  cursorColor: AColors.textWhite,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: '0',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AColors.textWhite),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
