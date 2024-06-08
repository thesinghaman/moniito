import 'package:flutter/material.dart';

import '/features/personalization/controllers/user_controller.dart';
import '/utils/constants/colors.dart';
import '/utils/icons/iconsax_icons.dart';
import '/utils/constants/image_strings.dart';
import '/common/widgets/images/a_circular_image.dart';

class AUserProfileTile extends StatelessWidget {
  const AUserProfileTile({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const ACircularImage(
          image: AImages.profileImage, width: 50, height: 50, padding: 0),
      title: Text(
        controller.user.value.fullName,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AColors.textWhite),
      ),
      subtitle: Text(
        controller.user.value.email,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: AColors.textWhite),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Iconsax.edit,
          color: AColors.white,
        ),
      ),
    );
  }
}
