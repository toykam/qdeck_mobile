

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
    final deckProvider = Provider.of<DeckProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 60.h,),
          Text("Host a Game", style: GoogleFonts.montserrat(
            fontSize: 24.sp, fontWeight: FontWeight.w700,
          ), textAlign: TextAlign.center,),

          SizedBox(height: 5.h,),
          Text("Select a Question Deck", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 16.sp, fontWeight: FontWeight.w200
          ),),

          SizedBox(height: 20.h,),

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
                hintText: "Search Deck by name, creator",
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
              onChanged: (String v) => deckProvider.searchQDeck(v),
            ),
          ),
          SizedBox(height: 20.h,),

          Expanded(
            child: Builder(
              builder: (context) {
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

                if (deckProvider.decksToDisplay.isEmpty && deckProvider.searchParam.isEmpty) {
                  return const Center(
                    child: Text("No Question Deck"),
                  );
                }

                if (deckProvider.decksToDisplay.isEmpty && deckProvider.searchParam.isNotEmpty) {
                  return const Center(
                    child: Text("Question deck not found."),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    deckProvider.initialize();
                  },
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10, mainAxisSpacing: 10,
                        mainAxisExtent: 150
                    ),
                    itemCount: deckProvider.decksToDisplay.length,
                    itemBuilder: (context, index) {
                      final deck = deckProvider.decksToDisplay[index];
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
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${deck.name}", style: GoogleFonts.abel(
                                            fontSize: 16.sp, fontWeight: FontWeight.w900
                                        ),),

                                        Text("by: ${deck.user!.name}", style: GoogleFonts.abel(
                                            fontSize: 16.sp, fontWeight: FontWeight.w200
                                        ),),
                                      ],
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
