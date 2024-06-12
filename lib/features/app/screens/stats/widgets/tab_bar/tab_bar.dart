import 'package:flutter/material.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import 'tab_item.dart';

class ATabBar extends StatelessWidget {
  const ATabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(ASizes.borderRadiusMd),
      ),
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: ASizes.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ASizes.borderRadiusMd),
          border: Border.all(color: AColors.grey),
        ),

        /// -- Tab Items
        child: TabBar(
          tabs: const [
            ATabItems(title: ATexts.spends),
            ATabItems(title: ATexts.categories),
          ],
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: const BoxDecoration(
            color: AColors.primary,
            borderRadius:
                BorderRadius.all(Radius.circular(ASizes.borderRadiusMd)),
          ),
          splashBorderRadius:
              const BorderRadius.all(Radius.circular(ASizes.borderRadiusMd)),
          labelColor: AColors.textWhite,
          labelStyle: Theme.of(context).textTheme.titleLarge,
          unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
          unselectedLabelColor: AColors.darkGrey,
        ),
      ),
    );
  }
}
