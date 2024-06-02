import 'package:flutter/material.dart';

import '/utils/constants/sizes.dart';
import '/utils/icons/iconsax_icons.dart';

class AProfileMenu extends StatelessWidget {
  const AProfileMenu({
    super.key,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
    required this.onPressed,
    this.showIcon = true,
  });

  final String title, value;
  final IconData icon;
  final VoidCallback onPressed;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: ASizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            // Title Text
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                )),

            // Value Text
            Expanded(
                flex: 5,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                )),

            if (showIcon)
              // Icon
              Expanded(
                  child: Icon(
                icon,
                size: 18,
              ))
          ],
        ),
      ),
    );
  }
}
