
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/game_provider.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:provider/provider.dart';

class GameCodeScreen extends StatelessWidget {
  GameCodeScreen({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastAlert.closeAlert();
    final provider = Provider.of<GameProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 100,),
        Text("Game Code", style: GoogleFonts.montserrat(
          fontSize: 24, fontWeight: FontWeight.w700,
        ), textAlign: TextAlign.center,),

        const SizedBox(height: 200,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              fillColor: Colors.white, filled: true,
              hintStyle: GoogleFonts.montserrat(
                fontSize: 24, color: AppColors.backGroundColor.withOpacity(.5),
                fontWeight: FontWeight.w900
              ),
              hintText: "Code",
              contentPadding: const EdgeInsets.only(
                top: 12
              ),
            ),
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 24, color: AppColors.backGroundColor,
              fontWeight: FontWeight.w900
            ),
            keyboardType: TextInputType.number,
            cursorColor: AppColors.backGroundColor.withOpacity(.5),
          ),
        ),

        const Expanded(child: SizedBox(height: 200,)),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ElevatedButton(
            onPressed: () => provider.checkKahoot(context, _controller.text),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                vertical: 16
              ))
            ),
            child: Text("Proceed", style: TextStyle(
              color: AppColors.backGroundColor, fontSize: 16
            ),),
          ),
        ),

        const SizedBox(height: 50,),
      ],
    );
  }
}
