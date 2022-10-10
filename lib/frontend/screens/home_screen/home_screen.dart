

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/auth_provider.dart';
import 'package:khoot/frontend/route/route_names.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:khoot/frontend/widgets/page_header.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 100,),
          // Text("Welcome to QDeck!...", style: GoogleFonts.montserrat(
          //   fontSize: 24.sp, fontWeight: FontWeight.w900,
          // ), textAlign: TextAlign.center,),

          const PageHeaderWidget(
            title: "Welcome to QDeck!...",
          ),

          Expanded(
            child: authProvider.isLoading ? const Center(
                child: CircularProgressIndicator.adaptive()
            ) : Column(
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

                if (authProvider.isLoggedIn)
                  ...[
                    const SizedBox(height: 30,),
                    InkWell(
                      onTap: () => context.push("/$myDeckScreenRoute"),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        decoration: const BoxDecoration(
                            color: Color(0xFF26890c)
                        ),
                        child: const Center(child: Text("My Question Decks", style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700
                        ),)),
                      ),
                    ),
                  ],
              ],
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        if (authProvider.isLoggedIn)
          ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  ToastAlert.showConfirmAlert(context, "Do you want to delete this deck?", () {
                    authProvider.logout();
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFe21b3c)),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 32
                  ))
                ),
                child: Text("Logout", style: TextStyle(
                    color: Colors.white, fontSize: 16
                ),),
              ),
            ),
          ],



      ],
    );
  }
}
