
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/screens/splash/splash_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var localizationDelegate = LocalizedApp.of(context).delegate;
    return GetMaterialApp(
      title: 'Kabañas BarberShop',
      theme: ThemeData(fontFamily: 'Nunito'),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: SplashModule(),
    );
  }
}

// class AppWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Kabañas BarberShop',
//       builder: DevicePreview.appBuilder,
//       locale: DevicePreview.locale(context),
//       theme: ThemeData(fontFamily: 'Nunito'),
//       debugShowCheckedModeBanner: false,
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate
//       ],
//       supportedLocales: [const Locale('pt', 'BR')],
//       home: SplashModule(),
//     );
//   }
// }

