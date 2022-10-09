

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
              fontSize: 16, fontWeight: FontWeight.w200
          ),),

          const SizedBox(height: 20,),
          const SizedBox(height: 24,),

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

                return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10, mainAxisSpacing: 10,
                    mainAxisExtent: 150
                  ),
                  itemCount: deckProvider.decks.length,
                  itemBuilder: (context, index) {
                    final deck = deckProvider.decks[index];
                    // return ListTile(
                    //   title: Text("${deck.name}"),
                    //   trailing: InkWell(
                    //     onTap: () {
                    //       context.push("/$manageGameScreenRoute/${deck.id}");
                    //     },
                    //     child: Text('Play')
                    //   ),
                    // );
                    return InkWell(
                      onTap: () {
                        context.push("/$manageGameScreenRoute/${deck.id}");
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: const Color(0xFF333333),
                              ),
                              child: Center(
                                child: Text("QD", style: GoogleFonts.cedarvilleCursive(
                                  fontSize: 32.sp, fontWeight: FontWeight.w900
                                ),),
                              ),
                            ),
                            Positioned(
                              bottom: 0, left: 0, right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8
                                ),
                                child: Text("${deck.name}", style: GoogleFonts.abel(
                                    fontSize: 16.sp, fontWeight: FontWeight.w900
                                ),)
                              ),
                            )
                          ],
                        ),
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
