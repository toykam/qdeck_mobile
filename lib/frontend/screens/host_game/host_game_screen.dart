

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/providers/deck_provider.dart';
import 'package:khoot/frontend/route/route_names.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:provider/provider.dart';

class HostGameScreen extends StatelessWidget {
  const HostGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 100,),
          Text("Host a Game", style: GoogleFonts.montserrat(
            fontSize: 24, fontWeight: FontWeight.w700,
          ), textAlign: TextAlign.center,),

          const SizedBox(height: 5,),
          const Text("Select a Question Deck", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w200
          ),),

          const SizedBox(height: 20,),

          Expanded(
            child: ChangeNotifierProvider(
              create: (context) => DeckProvider(),
              builder: (context, child) {
                final deckProvider = Provider.of<DeckProvider>(context);
                if (deckProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (deckProvider.isError) {
                  return Center(
                    child: Text(deckProvider.message),
                  );
                }

                return ListView.builder(
                  itemCount: deckProvider.decks.length,
                  itemBuilder: (context, index) {
                    final deck = deckProvider.decks[index];
                    return ListTile(
                      title: Text("${deck.name}"),
                      trailing: InkWell(
                        onTap: () {
                          context.push("/$manageGameScreenRoute/${deck.id}");
                        },
                        child: Text('Play')
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
