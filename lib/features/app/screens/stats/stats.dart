import 'package:flutter/material.dart';

import '/common/widgets/appbar/appbar.dart';
import '/common/widgets/icons/icon_button.dart';
import '/utils/constants/text_strings.dart';
import '/utils/icons/iconsax_icons.dart';
import '/utils/constants/colors.dart';
import 'widgets/tab_bar/tab_bar.dart';
import 'widgets/tab_bar/tab_bar_view.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AColors.light,

      /// -- AppBar
      appBar: AAppBar(
        title: Text(
          ATexts.statsScreen,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: const [
          AIconButton(
            iconColor: AColors.primary,
            icon: Iconsax.setting_44,
          )
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // The flexible app bar with the tabs
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: false,
              forceElevated: innerBoxIsScrolled,
              bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(0.0), child: ATabBar()),
            )
          ],
          // The content of each tab
          body: const ATabBarView(),
        ),
      ),
    );
  }
}
