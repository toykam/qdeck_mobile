
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          const SizedBox(height: 100,),
          Text("Welcome back", style: GoogleFonts.montserrat(
            fontSize: 24, fontWeight: FontWeight.w700,
          ), textAlign: TextAlign.center,),

          const SizedBox(height: 5,),
          const Text("Please provide your detail to continue", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w200
          ),),
          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                fillColor: Colors.white, filled: true,
                hintStyle: GoogleFonts.montserrat(
                    fontSize: 24, color: AppColors.backGroundColor.withOpacity(.5),
                    fontWeight: FontWeight.w900
                ),
                hintText: "Email",
                contentPadding: const EdgeInsets.only(
                    top: 12, left: 16
                ),
              ),
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                  fontSize: 24, color: AppColors.backGroundColor,
                  fontWeight: FontWeight.w900
              ),
              keyboardType: TextInputType.name,
              cursorColor: AppColors.backGroundColor.withOpacity(.5),
            ),
          ),

          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                fillColor: Colors.white, filled: true,
                hintStyle: GoogleFonts.montserrat(
                    fontSize: 24, color: AppColors.backGroundColor.withOpacity(.5),
                    fontWeight: FontWeight.w900
                ),
                hintText: "Password",
                contentPadding: const EdgeInsets.only(
                    top: 12, left: 16
                ),
              ),
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                  fontSize: 24, color: AppColors.backGroundColor,
                  fontWeight: FontWeight.w900
              ),
              keyboardType: TextInputType.visiblePassword,
              cursorColor: AppColors.backGroundColor.withOpacity(.5),
            ),
          ),


          const Expanded(child: SizedBox(height: 200,)),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 16
                  ))
              ),
              child: Text("Sign In", style: TextStyle(
                  color: AppColors.backGroundColor, fontSize: 16
              ),),
            ),
          ),

          const SizedBox(height: 50,),

        ],
      ),
    );
  }
}
