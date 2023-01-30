import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/screen/landing/splash_screen2.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/image/logo_kkn.png',
      duration: 1000,
      //curve: Curves.ease,
      splashIconSize: 250,
      backgroundColor: MyColor.neutral900,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: const SplashScreenTwo(),
    );
  }
}
