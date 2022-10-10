
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/backend/domain/services/i_localstorage_service.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/auth_provider.dart';
import 'package:khoot/frontend/route/route_names.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:khoot/service_locator.dart';
import 'package:khoot/utils/constants.dart';
import 'package:khoot/utils/endpoints.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  void register(BuildContext context) async {
    try {
      print("loading...");
      if (emailController.text.isEmpty) {
        ToastAlert.showErrorAlert("Please provide your email");
      } else if (passwordController.text.isEmpty) {
        ToastAlert.showErrorAlert("Please provide your password");
      } else {
        ToastAlert.showLoadingAlert("");
        final dio = Dio();
        final res = await dio.post(AppEndpoints.register, data: {
          "email": emailController.text,
          "name": nameController.text,
          "password": passwordController.text
        });

        // final token = res.data['token'];
        ToastAlert.closeAlert();
        ToastAlert.showAlert("Registration successful");
        // Provider.of<AuthProvider>(context, listen: false).initialize();
        context.pop();
      }
    } on DioError catch (error) {
      ToastAlert.closeAlert();
      ToastAlert.showErrorAlert(error.response!.data['message']);
    } catch (error) {
      ToastAlert.closeAlert();
      ToastAlert.showErrorAlert("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          const SizedBox(height: 100,),
          Text("Welcome", style: GoogleFonts.montserrat(
            fontSize: 24, fontWeight: FontWeight.w700,
          ), textAlign: TextAlign.center,),

          const SizedBox(height: 5,),
          const Text("Please provide your detail to continue", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w200
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
                      fontWeight: FontWeight.w400
                  ),
                  hintText: "Name",
                  contentPadding: const EdgeInsets.only(
                      top: 12, left: 16
                  ),
                ),
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontSize: 24, color: AppColors.backGroundColor,
                    fontWeight: FontWeight.w400
                ),
                keyboardType: TextInputType.name,
                cursorColor: AppColors.backGroundColor.withOpacity(.5),
                controller: nameController
            ),
          ),

          const SizedBox(height: 30,),
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
                      fontWeight: FontWeight.w400
                  ),
                  hintText: "Email",
                  contentPadding: const EdgeInsets.only(
                      top: 12, left: 16
                  ),
                ),
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontSize: 24, color: AppColors.backGroundColor,
                    fontWeight: FontWeight.w400
                ),
                keyboardType: TextInputType.name,
                cursorColor: AppColors.backGroundColor.withOpacity(.5),
                controller: emailController
            ),
          ),

          const SizedBox(height: 30,),
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
                      fontWeight: FontWeight.w400
                  ),
                  hintText: "Password",
                  contentPadding: const EdgeInsets.only(
                      top: 12, left: 16
                  ),
                ),
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontSize: 24, color: AppColors.backGroundColor,
                    fontWeight: FontWeight.w400
                ),
                keyboardType: TextInputType.visiblePassword,
                cursorColor: AppColors.backGroundColor.withOpacity(.5),
                obscureText: true,
                controller: passwordController
            ),
          ),


          const Expanded(child: SizedBox(height: 200,)),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              onPressed: () => register(context),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 16
                  ))
              ),
              child: Text("Sign Up", style: TextStyle(
                  color: AppColors.backGroundColor, fontSize: 16
              ),),
            ),
          ),

          const SizedBox(height: 10,),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(text: "Already have an account? "),
                TextSpan(
                  text: "Sign In",
                  recognizer: TapGestureRecognizer()..onTap = () {
                     context.replace("/auth/$loginScreenRoute");
                  }
                ),
              ]
            ),
          ),
          const SizedBox(height: 50,),

        ],
      ),
    );
  }
}
