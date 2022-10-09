
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/providers/game_provider.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 100,),
        // Padding(
        //   padding: const EdgeInsets.all(24),
        //   child: Text("Score ${provider.participant['score']}", style: GoogleFonts.inter(
        //       fontSize: 16, fontWeight: FontWeight.w300
        //   ),),
        // ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Text("Question ${provider.qn}/${provider.totalQuestions}", style: GoogleFonts.inter(
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
            child: Text("${provider.question.question}", style: GoogleFonts.inter(
              fontSize: 24, fontWeight: FontWeight.w500
            ),),
          ),
        ),
        if (!provider.waitingForOthers)
          ...[
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => provider.answerQuestion(context, provider.question.option1!),
                          child: _optionWidget("${provider.question.option1}", Color(0xFF1368ce)),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: InkWell(
                          onTap: () => provider.answerQuestion(context, provider.question.option2!),
                          child: _optionWidget("${provider.question.option2}", Color(0xFFffa602)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => provider.answerQuestion(context, provider.question.option3!),
                          child: _optionWidget("${provider.question.option3}", Color(0xFF26890c)),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: InkWell(
                          onTap: () => provider.answerQuestion(context, provider.question.option4!),
                          child: _optionWidget("${provider.question.option4}", Color(0xFF0aa3a3)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        const SizedBox(height: 100,),
      ],
    );
  }
}


Widget _optionWidget(String option, Color color) {
  return Container(
      padding: EdgeInsets.symmetric(
          vertical: 20
      ),
      decoration: BoxDecoration(
          color: color
      ),
      child: Center(
          child: Text("$option")
      )
  );
}