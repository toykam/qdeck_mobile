

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/add_question_provider.dart';
import 'package:khoot/frontend/providers/view_question_deck_provider.dart';
import 'package:khoot/frontend/screens/my_question_decks/add_question_scree.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:khoot/frontend/widgets/page_header.dart';
import 'package:provider/provider.dart';

class ViewQuestionDeckScreen extends StatelessWidget {
  const ViewQuestionDeckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qDeckProvider = Provider.of<ViewQuestionDeckProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 60.h),

          if (qDeckProvider.isError)
            ...[
              Center(
                child: Text(qDeckProvider.message, textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 20,),

            ],

          if (qDeckProvider.isLoading)
            ...[
              const PageHeaderWidget(
                title: "Loading...",
              )
            ],

          if (qDeckProvider.isLoaded)
            ...[
              PageHeaderWidget(
                title: qDeckProvider.questionDeck.name!,
              ),

              Expanded(
                child: qDeckProvider.questions.isEmpty ? Center(
                  child: Text("No question in this deck",
                    style: TextStyle(
                      fontSize: 24.sp, fontWeight: FontWeight.w100
                    ), textAlign: TextAlign.center,
                  ),
                ): RefreshIndicator(
                  onRefresh: () async {
                    qDeckProvider.initialize();
                  },
                  child: ListView.builder(
                    itemCount: qDeckProvider.questions.length,
                    itemBuilder: (context, index) {
                      final e = qDeckProvider.questions[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(e.question!, style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.w400,
                                      letterSpacing: 2, overflow: TextOverflow.ellipsis
                                  ),),
                                ),
                                SizedBox(width: 10.w,),
                                InkWell(
                                  onTap: () async {
                                    final res = await showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ChangeNotifierProvider(
                                            create: (context) => AddQuestionProvider(qDeckProvider.qdeckId, e),
                                            child: const AddQuestionScreen(),
                                          );
                                        },
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true
                                    );
                                    print("After ... $res");
                                    if (res != null) {
                                      qDeckProvider.initialize();
                                    }
                                  },
                                  child: Icon(Icons.edit)
                                ),
                                SizedBox(width: 10.w,),
                                InkWell(
                                  onTap: () async {
                                    ToastAlert.showConfirmAlert(context, "Do you want to delete this question?", () {
                                      qDeckProvider.deleteQDeckQuestion(context, e.id!);
                                    });
                                  },
                                  child: const Icon(Icons.delete, color: Colors.red,)
                                )
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Text("Answer: ${e.answer!}", style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300,
                                letterSpacing: 2
                            ),),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
        ],
      ),
      persistentFooterButtons: [
        if (qDeckProvider.isLoaded)
          ...[
            Row(
              children: [
                SizedBox(width: 10.w,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ToastAlert.showConfirmAlert(context, "Do you want to delete this deck?", () {
                        qDeckProvider.deleteQDeck(context);
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFe21b3c)),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32
                        ))
                    ),
                    child: const Text("Delete Deck", style: TextStyle(
                        color: Colors.white, fontSize: 16
                    ),),
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final res = await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ChangeNotifierProvider(
                              create: (context) => AddQuestionProvider(qDeckProvider.qdeckId),
                              child: const AddQuestionScreen(),
                            );
                          },
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true
                      );
                      print("After ... $res");
                      if (res != null) {
                        qDeckProvider.initialize();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32
                        ))
                    ),
                    child: Text("Add Question", style: TextStyle(
                        color: AppColors.backGroundColor, fontSize: 16
                    ),),
                  ),
                ),
                SizedBox(width: 10.w,),
              ],
            ),
          ],
      ],
    );
  }
}
