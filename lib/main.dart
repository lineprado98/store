import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:store/app/app_widget.dart';
import 'package:store/app/commons/services/service_locator/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store/firebase_options.dart';

void main() async {
  await setupInitialize();
  runApp(const AppWidget());
}

Future<void> setupInitialize() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ServiceLocator.setup();
}
