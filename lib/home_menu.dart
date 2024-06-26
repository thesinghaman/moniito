// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Importing custom widgets and constants
import 'utils/constants/sizes.dart';
import 'utils/constants/colors.dart';
import 'utils/icons/iconsax_icons.dart';
import '/features/app/controllers/transaction_controller.dart';

// Importing all screens.
import 'features/app/screens/home/home.dart';
import 'features/app/screens/stats/stats.dart';
import 'features/app/screens/settings/settings.dart';
import 'features/app/screens/transaction_add/add_transaction.dart';

// Main class representing the Home Menu screen
class HomeMenu extends StatelessWidget {
  // Constructor for the HomeMenu widget
  const HomeMenu({super.key});

  // Build method to create the HomeMenu widget
  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX state management
    final controller = Get.put(AppScreenController());

    // Return a Scaffold widget representing the Home Menu screen
    return Scaffold(
      backgroundColor: AColors.light,
      // Do not Extend the body to overlap the bottom navigation bar
      extendBody: false,
      // Define a bottom navigation bar using GetX Obx widget
      bottomNavigationBar: Obx(() {
        // Check if the current screen is NewTransactionScreen
        if (controller.selectedMenu.value == 2) {
          return const SizedBox.shrink();
        } else {
          return NavigationBar(
            height: 60,
            //labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            selectedIndex: controller.selectedMenu.value,
            backgroundColor: AColors.light,
            elevation: 0,
            indicatorColor: Colors.transparent,
            // Callback when a navigation destination is selected
            onDestinationSelected: (index) {
              if (index == 2) {
                controller.navigateToNewTransactionScreen();
              } else {
                controller.selectedMenu.value = index;
              }
            },
            // List of navigation destinations/icons in the bottom navigation bar
            destinations: [
              NavigationDestination(
                  icon: Icon(
                      controller.selectedMenu.value != 0
                          ? Iconsax.home_2
                          : Iconsax.home_25,
                      size: ASizes.iconLg - 5,
                      color: controller.selectedMenu.value != 0
                          ? AColors.primary.withOpacity(0.6)
                          : AColors.primary),
                  label: 'Home'),
              NavigationDestination(
                  icon: Icon(
                      controller.selectedMenu.value != 1
                          ? Iconsax.chart_2
                          : Iconsax.chart_215,
                      size: ASizes.iconLg - 5,
                      color: controller.selectedMenu.value != 1
                          ? AColors.primary.withOpacity(0.6)
                          : AColors.primary),
                  label: 'Stats'),
              NavigationDestination(
                // Custom navigation destination for 'Add' with an AddIcon
                icon: Material(
                  borderRadius: BorderRadius.circular(25),
                  elevation: 10,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AColors.primary,
                    ),
                    child: const Icon(
                      Iconsax.add,
                      color: AColors.white,
                      size: ASizes.iconLg - 5,
                    ),
                  ),
                ),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(
                    controller.selectedMenu.value != 3
                        ? Iconsax.wallet_34
                        : Iconsax.wallet_35,
                    size: ASizes.iconLg - 5,
                    color: controller.selectedMenu.value != 3
                        ? AColors.primary.withOpacity(0.6)
                        : AColors.primary),
                label: 'Wallet',
              ),
              NavigationDestination(
                icon: Icon(
                    controller.selectedMenu.value != 4
                        ? Iconsax.profile_circle4
                        : Iconsax.profile_circle5,
                    size: ASizes.iconLg - 5,
                    color: controller.selectedMenu.value != 4
                        ? AColors.primary.withOpacity(0.6)
                        : AColors.primary),
                label: 'Profile',
              ),
            ],
          );
        }
      }),
      // Display the selected screen based on the current menu index
      body: Obx(() => controller.screens[controller.selectedMenu.value]),
    );
  }
}

// Controller class for managing the state of the Home Menu screen
class AppScreenController extends GetxController {
  final controller = Get.put(TransactionController());
  // Singleton instance of AppScreenController
  static AppScreenController get instance => Get.find();

  // Reactive variable to track the selected menu index
  final Rx<int> selectedMenu = 0.obs;

  // List of screens to be displayed for each menu item
  final screens = [
    const HomeScreen(),
    const StatsScreen(),
    const Center(child: Text('Add')),
    const Center(child: Text('Wallets')),
    const SettingsScreen(),
  ];

  // Method to navigate to NewTransactionScreen
  void navigateToNewTransactionScreen() {
    controller.clearFormFields();
    Get.to(() => const AddTransactionScreen())!.then((_) {
      // When back button is pressed in NewTransactionScreen, navigate to HomeScreen
      selectedMenu.value = 0;
    });
  }
}
