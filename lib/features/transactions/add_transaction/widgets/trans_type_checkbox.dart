import 'package:flutter/material.dart';

class ATransTypeCheckbox extends StatelessWidget {
  const ATransTypeCheckbox({
    super.key,
    required this.color,
    required this.value,
    required this.title,
  });

  final Color color;
  final bool value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          fillColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return color;
            } else {
              return Colors.transparent;
            }
          }),
          onChanged: null,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 18, color: color),
        )
      ],
    );
  }
}
