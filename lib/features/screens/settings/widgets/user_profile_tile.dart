import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../personalization/profile/profile.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/text_strings.dart';
import '/utils/icons/iconsax_icons.dart';
import '/utils/constants/image_strings.dart';

import '/common/widgets/images/a_circular_image.dart';

class AUserProfileTile extends StatelessWidget {
  const AUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const ACircularImage(
          image: AImages.profileImage, width: 50, height: 50, padding: 0),
      title: Text(
        ATexts.userFullName,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AColors.textWhite),
      ),
      subtitle: Text(
        ATexts.emailAddress,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: AColors.textWhite),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: const Icon(
          Iconsax.edit,
          color: AColors.white,
        ),
      ),
    );
  }
}
