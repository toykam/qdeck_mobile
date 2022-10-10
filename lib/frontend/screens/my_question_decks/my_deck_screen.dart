
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/providers/my_deck_provider.dart';
import 'package:khoot/frontend/route/route_names.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:khoot/frontend/widgets/click_effect.dart';
import 'package:khoot/frontend/widgets/page_header.dart';
import 'package:provider/provider.dart';

class MyDeckScreen extends StatelessWidget {
  const MyDeckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deckProvider = Provider.of<MyDeckProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          SizedBox(height: 60.h,),
          // Text("My Deck", style: GoogleFonts.montserrat(
          //   fontSize: 24, fontWeight: FontWeight.w700,
          // ), textAlign: TextAlign.center,),
          //
          // const SizedBox(height: 5,),
          // const Text("Question Deck's created by you.", textAlign: TextAlign.center, style: TextStyle(
          //     fontSize: 16, fontWeight: FontWeight.w200
          // ),),

          const PageHeaderWidget(
            title: "My Deck",
            subtitle: "Question Deck's created by you.",
          ),

          const SizedBox(height: 24,),

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
                hintText: "Search Deck by name",
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(deckProvider.message),
                      ),
                      SizedBox(height: 20.h,),

                      InkWell(
                        onTap: () => deckProvider.initialize(),
                        child: Text("Refresh")
                      )
                    ],
                  );
                }
                final decks = deckProvider.decksToDisplay;
                if (decks.isEmpty && deckProvider.searchParam.isEmpty) {
                  return const Center(
                    child: Text("You do not have any Question Deck"),
                  );
                }
                if (decks.isEmpty && deckProvider.searchParam.isNotEmpty) {
                  return const Center(
                    child: Text("Question deck not found"),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    deckProvider.initialize();
                  },
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10, mainAxisSpacing: 10,
                      mainAxisExtent: 150
                    ),
                    itemCount: deckProvider.decks.length,
                    itemBuilder: (context, index) {
                      final deck = deckProvider.decks[index];
                      return AnimatedContainerOnClicked(
                        onClick: () {
                          context.push(
                            "/$myDeckScreenRoute/$viewQuestionDeckScreenRoute/${deck.id}"
                          );
                        },
                        // borderRadius: BorderRadius.circular(15),
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
                  ),
                );
              },
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ElevatedButton(
            onPressed: () => context.push("/$myDeckScreenRoute/$createQuestionDeckScreenRoute"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                vertical: 16, horizontal: 32
              ))
            ),
            child: Text("Create Question Deck", style: TextStyle(
                color: AppColors.backGroundColor, fontSize: 16
            ),),
          ),
        ),
      ],
    );
  }
}
