import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/device/device_utility.dart';

import '../../../controllers/onboarding/onboarding_controller.dart';

class AOnBoardingDotNavigation extends StatelessWidget {
  const AOnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      bottom: ADeviceUtils.getBottomNavigationBarHeight() + 25,
      left: ASizes.defaultSpace,
      child: SmoothPageIndicator(
        count: 3,
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        effect: const ExpandingDotsEffect(
            activeDotColor: AColors.black, dotHeight: 6),
      ),
    );
  }
}
