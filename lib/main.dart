import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:kabanas_barbershop/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Intl.defaultLocale = 'pt-br';
  // var delegate = await LocalizationDelegate.create(
  //     fallbackLocale: 'pt', supportedLocales: ['en', 'fr', 'pt']);
  runApp(AppModule());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   Intl.defaultLocale = 'pt-br';
//   runApp(DevicePreview(builder: (_) => AppModule()));
// }