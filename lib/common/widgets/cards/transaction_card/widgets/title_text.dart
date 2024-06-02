import 'package:flutter/material.dart';

class ATransactionTitle extends StatelessWidget {
  const ATransactionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
    );
  }
}
