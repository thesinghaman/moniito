import 'package:flutter/material.dart';

class ATransactionMenuText extends StatelessWidget {
  const ATransactionMenuText({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title Text
        Flexible(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Value Text
        Flexible(
          flex: 2,
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
