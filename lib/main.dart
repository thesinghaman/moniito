// Import necessary packages and files
import 'app.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'data/repositories/authentication/authentication_repositories.dart';

Future<void> main() async {
  // Ensure that first Initialization is done before loading UI
  final WidgetsBinding widgetBinding =
      WidgetsFlutterBinding.ensureInitialized();

  /// -- GetX Local Storage
  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  // Intialize the firebase, '.then' is used to control what screen to show next,
  // like if user is logged in redirect to home screen, if email is not verifed, redirect to
  // email verification etc.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((_) => Get.put(AuthenticationRepository()));

  /// -- Overcome from transparent spaces at the bottom in iOS full Mode
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  /// -- Main App Starts here.
  runApp(const App());
}
