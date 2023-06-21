import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transportation_rent_mobile/view/page/homePage.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  @override
  void initState() {
    super.initState();
    splace();
  }

  void splace() {
    Timer(Duration(seconds: 3), () {
      Get.offAll(HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 230,
                height: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo/icon_apk.png'),
                    fit: BoxFit.contain,
                  ),
                  // color: Colors.grey,
                ),
              ),
            ],
          ),
        ));
  }
}
