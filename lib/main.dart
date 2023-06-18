import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transportation_rent_mobile/internet_injection/depedency_injection.dart';
import 'package:transportation_rent_mobile/view/page/splaceScreen.dart';

void main() {
  runApp(const MyApp());
  DepedencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      defaultTransition: Transition.size,
      debugShowCheckedModeBanner: false,
      title: 'Transportastion Rent',
      home: SplaceScreen(),
    );
  }
}
