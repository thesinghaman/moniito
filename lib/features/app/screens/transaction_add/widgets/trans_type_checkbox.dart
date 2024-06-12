import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/transaction_controller.dart';

class ATransTypeCheckbox extends StatelessWidget {
  const ATransTypeCheckbox({
    super.key,
    required this.color,
    required this.title,
  });

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = TransactionController.instance;
    return Obx(
      () => Row(
        children: [
          Checkbox(
            value: title == 'Expense'
                ? controller.isExpense.value
                : controller.isIncome.value,
            fillColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return color;
              } else {
                return Colors.transparent;
              }
            }),
            onChanged: (bool? newValue) {
              if (newValue != null) {
                if (title == 'Expense' && newValue) {
                  controller.isExpense.value = true;
                  controller.isIncome.value = false; // Deselect income
                } else if (title == 'Income' && newValue) {
                  controller.isIncome.value = true;
                  controller.isExpense.value = false; // Deselect expense
                }
              }
            },
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 18, color: color),
          )
        ],
      ),
    );
  }
}
