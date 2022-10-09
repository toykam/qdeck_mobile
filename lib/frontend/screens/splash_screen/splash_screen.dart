

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/route/route_names.dart';
import 'package:khoot/frontend/styles/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void navigateToGameScreen() {
    Timer(const Duration(seconds: 3), () {
      context.replace("/$homeScreenRoute");
    });
  }

  @override
  void initState() {
    navigateToGameScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("QDeck!...", style: GoogleFonts.montserrat(
            fontSize: 32, fontWeight: FontWeight.w700
          ),textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
