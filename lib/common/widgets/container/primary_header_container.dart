import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

class APrimaryHeaderContainer extends StatelessWidget {
  const APrimaryHeaderContainer(
      {super.key, required this.child, this.height = 230});

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ACustomCurvedEdges(),
      child: Container(
          height: height,
          width: double.infinity,
          color: AColors.primary,
          child: child),
    );
  }
}
