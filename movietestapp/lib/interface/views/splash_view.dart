import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movietestapp/interface/controllers/internet_controller.dart';
import 'package:movietestapp/interface/controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});
  //splash controller for cache management; if internet is off.
  final splashController = Get.put(SplashController());
  //if internet is off? it will update watch view whenever connection is available.
  final internetController = Get.put(InternetController());

  @override
  Widget build(BuildContext context) {
    // Size s = getSize(context);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 100,
              width: 100,
              child: Lottie.asset('lib/assets/lotties/loading-anim.json',
                  fit: BoxFit.cover)),
          const SizedBox(width: 50, child: LinearProgressIndicator())
        ],
      )),
    );
  }
}
