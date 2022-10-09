
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/providers/game_provider.dart';
import 'package:provider/provider.dart';

class WaitingToStartScreen extends StatelessWidget {
  const WaitingToStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 100,),
        Text("Participants", style: GoogleFonts.montserrat(
          fontSize: 24, fontWeight: FontWeight.w700,
        ), textAlign: TextAlign.center,),

        const SizedBox(height: 5,),
        const Text("Waiting for the host to start...", textAlign: TextAlign.center, style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w200
        ),),
        const SizedBox(height: 20,),

        ...provider.participants.map((e) {
          return ListTile(
            title: Text(e['username'], style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w300,
              letterSpacing: 2
            ),),
          );
        })
      ],
    );
  }
}
