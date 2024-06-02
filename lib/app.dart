// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moniito_v2/bindings/general_bindings.dart';

// Importing custom widgets and constants
import 'utils/constants/text_strings.dart';
import 'utils/theme/theme.dart';
import 'utils/constants/colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: ATexts.appName,
      themeMode: ThemeMode.light,
      theme: AAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),

      /// Show Loader or Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen.
      home: const Scaffold(
        backgroundColor: AColors.white,
        body: Center(child: CircularProgressIndicator(color: AColors.primary)),
      ),
    );
  }
}
