import 'package:flutter/material.dart';

class ATabItems extends StatelessWidget {
  const ATabItems({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(maxLines: 1, title, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
