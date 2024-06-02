import 'package:flutter/material.dart';

class ASubtitleText extends StatelessWidget {
  const ASubtitleText(
      {super.key, required this.subtitle, required this.fontColor});

  final String subtitle;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontSize: 13, color: fontColor),
    );
  }
}
