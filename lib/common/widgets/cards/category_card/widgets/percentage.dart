import 'package:flutter/material.dart';

import '/utils/constants/sizes.dart';

class APercentage extends StatelessWidget {
  const APercentage({super.key, required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(ASizes.xs)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ASizes.xs, vertical: 1),
        child: Text(
          '${value.toString()} %',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 12, color: color),
        ),
      ),
    );
  }
}
