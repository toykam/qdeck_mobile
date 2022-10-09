import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/providers/game_provider.dart';
import 'package:khoot/frontend/route/route_names.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:provider/provider.dart';

class GameResultScreen extends StatelessWidget {
  const GameResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 100,),
        Text("Game Result", style: GoogleFonts.montserrat(
          fontSize: 24, fontWeight: FontWeight.w700,
        ), textAlign: TextAlign.center,),
        const SizedBox(height: 20,),
        Expanded(
          child: ListView.builder(
            itemCount: provider.participants.length,
            itemBuilder: (context, index) {
              final e = provider.participants[index];
              return ListTile(
                title: Text(e['username'], style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w300,
                    letterSpacing: 2
                ),),
                trailing: Text("${e['score']}", style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w600,
                  letterSpacing: 2
                )),
              );
            },
          ),
        ),

        const SizedBox(height: 10,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ElevatedButton(
            onPressed: () => context.go("/$homeScreenRoute"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                    vertical: 16
                ))
            ),
            child: Text("Home", style: TextStyle(
                color: AppColors.backGroundColor, fontSize: 16
            ),),
          ),
        ),

        const SizedBox(height: 20,),
      ],
    );
  }
}
