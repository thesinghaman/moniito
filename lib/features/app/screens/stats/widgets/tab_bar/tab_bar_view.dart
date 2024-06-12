import 'package:flutter/material.dart';

import '/common/widgets/charts/chart.dart';
import '/utils/constants/sizes.dart';
import '../../spends/spends.dart';
import '../../categories/categories.dart';

class ATabBarView extends StatelessWidget {
  const ATabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: ASizes.spaceBtwSections / 2),

              /// -- Chart
              AChart(),
              SizedBox(height: ASizes.spaceBtwSections / 2),

              /// -- Spends Section
              ASpends()
            ],
          ),
        ),
        ACategories(),
      ],
    );
  }
}
