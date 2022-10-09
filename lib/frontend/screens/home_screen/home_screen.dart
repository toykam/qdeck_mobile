

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/route/route_names.dart';
import 'package:khoot/frontend/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 100,),
          Text("Welcome to QDeck!...", style: GoogleFonts.montserrat(
            fontSize: 24.sp, fontWeight: FontWeight.w900,
          ), textAlign: TextAlign.center,),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () => context.push("/$hostGameScreenRoute"),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: const BoxDecoration(
                        color: Color(0xFFEB670F)
                    ),
                    child: const Center(child: Text("Host a Game", style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700
                    ),)),
                  ),
                ),
                const SizedBox(height: 30,),
                InkWell(
                  onTap: () => context.push("/$gameScreenRoute"),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFA602)
                    ),
                    child: const Center(child: Text("Join a Game", style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700
                    ),)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
