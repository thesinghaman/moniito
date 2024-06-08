import 'package:flutter/material.dart';

import '/utils/icons/iconsax_icons.dart';
import '/utils/constants/sizes.dart';
import '/utils/device/device_utility.dart';
import '/features/authentication/controllers/onboarding/onboarding_controller.dart';

class AOnBoardingNextButton extends StatelessWidget {
  const AOnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: ASizes.defaultSpace,
      bottom: ADeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), backgroundColor: Colors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
