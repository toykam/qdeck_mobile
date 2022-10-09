
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/providers/manage_game_provider.dart';
import 'package:khoot/frontend/route/route_names.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:provider/provider.dart';

class ManageGameScreen extends StatelessWidget {
  const ManageGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ManageGameProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 100,),
          Text("Host a Game", style: GoogleFonts.montserrat(
            fontSize: 24, fontWeight: FontWeight.w700,
          ), textAlign: TextAlign.center,),

          if (provider.isLoading)
            ...[
              Center(
                child: CircularProgressIndicator.adaptive(),
              )
            ],

          if (provider.isError)
            ...[
              Center(
                child: Text('${provider.message}'),
              )
            ],
          if (provider.isLoaded)
            ...[
              if (provider.gameEnded)
                ...[
                  const SizedBox(height: 5,),
                  const Text("Game Result", textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w200
                  ),),
                  const SizedBox(height: 20,),
                  ...provider.participants.map((e) {
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
                  })
                ],
              if (!provider.gameEnded)
                ...[
                  if (provider.waitingForParticipants)
                    ...[const SizedBox(height: 5,),
                      const Text("Waiting for participants", textAlign: TextAlign.center, style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w200
                      ),),
                    ],

                  const SizedBox(height: 20,),

                  if (provider.qDeck != null && provider.kahootSession == null)
                    ...[
                      ...provider.qDeck!.questions!.map((e) {
                        return ListTile(
                          title: Text(e.question!, style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500,
                              letterSpacing: 2
                          ),),
                          subtitle: Text("Answer: ${e.answer!}", style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300,
                              letterSpacing: 2
                          ),),
                        );
                      })
                    ],

                  if (provider.qDeck == null)
                    ...[
                      const Center(child: CircularProgressIndicator.adaptive())
                    ],

                  if (provider.waitingForParticipants)
                    ...[
                      Text("Game Code: ${provider.kahootSession!.code}", style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w600,
                      ), textAlign: TextAlign.center,),
                      const SizedBox(height: 10,),
                      ...provider.participants.map((e) {
                        return ListTile(
                          title: Text(e['username'], style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w300,
                              letterSpacing: 2
                          ),),
                        );
                      })
                    ],

                  if (provider.gameStarted)
                    ...[
                      if (!provider.showLeaderboard)
                        ...[
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text("Question ${provider.qn}/${provider.totalQuestion}", style: GoogleFonts.inter(
                                      fontSize: 32, fontWeight: FontWeight.w800
                                  ),),
                                ),

                                Text("${provider.seconds}", style: GoogleFonts.inter(
                                    fontSize: 32, fontWeight: FontWeight.w800
                                ),)
                              ],
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text("${provider.question!.question}", style: GoogleFonts.inter(
                                  fontSize: 24, fontWeight: FontWeight.w500
                              ),),
                            ),
                          ),
                        ],

                      if (provider.showLeaderboard)
                        ...[
                          ...provider.participants.map((e) {
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
                          })
                        ],
                    ],
                ],

              ],
            ],

      ),
      persistentFooterButtons: [
        if (provider.isLoaded)
          ...[
            if (!provider.gameEnded)
              ...[
                if (provider.qDeck != null && provider.kahootSession == null)
                  ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: ElevatedButton(
                        onPressed: () => provider.create(),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32
                            ))
                        ),
                        child: Text("Create Session", style: TextStyle(
                            color: AppColors.backGroundColor, fontSize: 16
                        ),),
                      ),
                    ),
                  ],

                if (provider.kahootSession != null && !provider.gameStarted)
                  ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: ElevatedButton(
                        onPressed: () => provider.start(),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32
                            ))
                        ),
                        child: Text("Start Game", style: TextStyle(
                            color: AppColors.backGroundColor, fontSize: 16
                        ),),
                      ),
                    ),
                  ],

                if (provider.gameStarted && provider.showLeaderboard)
                  ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: ElevatedButton(
                        onPressed: () => provider.nextQuestion(),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32
                            ))
                        ),
                        child: Text("Next Question", style: TextStyle(
                            color: AppColors.backGroundColor, fontSize: 16
                        ),),
                      ),
                    ),
                  ],
              ],

            if (provider.gameEnded)
              ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton(
                    onPressed: () => context.go("/$homeScreenRoute"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32
                        ))
                    ),
                    child: Text("Back To Home", style: TextStyle(
                        color: AppColors.backGroundColor, fontSize: 16
                    ),),
                  ),
                ),
              ]

          ],

      ],
    );
  }
}
