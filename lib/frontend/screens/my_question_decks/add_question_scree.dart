
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/frontend/providers/add_question_provider.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:khoot/frontend/widgets/page_header.dart';
import 'package:provider/provider.dart';

class AddQuestionScreen extends StatelessWidget {
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddQuestionProvider>(context);
    return DraggableScrollableSheet(
      minChildSize: .6,
      maxChildSize: .9,
      initialChildSize: .6,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.only(top: 30),
          color: AppColors.primaryColor,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PageHeaderWidget(
                  title: "${provider.qm != null ? 'Update' : "Add"}  Question",
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    initialValue: provider.question,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white, filled: true,
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 24, color: AppColors.backGroundColor.withOpacity(.5),
                        fontWeight: FontWeight.w400
                      ),
                      hintText: "Question",
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
                    minLines: 5, maxLines: 5,
                    onChanged: (String stringValue) {
                      provider.question = stringValue;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    initialValue: provider.option1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white, filled: true,
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 24, color: AppColors.backGroundColor.withOpacity(.5),
                        fontWeight: FontWeight.w400
                      ),
                      hintText: "First option",
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
                    onChanged: (String stringValue) {
                      provider.option1 = stringValue;
                    },
                  ),
                ),

                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    initialValue: provider.option2,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white, filled: true,
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 24, color: AppColors.backGroundColor.withOpacity(.5),
                          fontWeight: FontWeight.w400
                      ),
                      hintText: "Second option",
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
                    onChanged: (String stringValue) {
                      provider.option2 = stringValue;
                    },
                  ),
                ),

                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    initialValue: provider.option3,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white, filled: true,
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 24, color: AppColors.backGroundColor.withOpacity(.5),
                          fontWeight: FontWeight.w400
                      ),
                      hintText: "Third option",
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
                    onChanged: (String stringValue) {
                      provider.option3 = stringValue;
                    },
                  ),
                ),

                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    initialValue: provider.option4,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white, filled: true,
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 24, color: AppColors.backGroundColor.withOpacity(.5),
                          fontWeight: FontWeight.w400
                      ),
                      hintText: "Forth option",
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
                    onChanged: (String stringValue) {
                      provider.option4 = stringValue;
                    },
                  ),
                ),

                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    initialValue: provider.answer,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white, filled: true,
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 24, color: AppColors.backGroundColor.withOpacity(.5),
                          fontWeight: FontWeight.w400
                      ),
                      hintText: "Answer",
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
                    onChanged: (String stringValue) {
                      provider.answer = stringValue;
                    },
                  ),
                ),

                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    initialValue: provider.qt.toString(),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white, filled: true,
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 24, color: AppColors.backGroundColor.withOpacity(.5),
                          fontWeight: FontWeight.w400
                      ),
                      hintText: "Question time (in seconds)",
                      contentPadding: const EdgeInsets.only(
                        top: 12, left: 16
                      ),
                    ),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      fontSize: 24, color: AppColors.backGroundColor,
                      fontWeight: FontWeight.w400
                    ),
                    keyboardType: TextInputType.number,
                    cursorColor: AppColors.backGroundColor.withOpacity(.5),
                    onChanged: (stringValue) {
                      provider.qt = num.parse(stringValue);
                    },
                  ),
                ),

                const SizedBox(height: 60,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton(
                    onPressed: () => provider.addQuestion(context),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                            vertical: 16
                        ))
                    ),
                    child: Text("${provider.qm != null ? 'Update' : "Add"} Question", style: TextStyle(
                        color: AppColors.backGroundColor, fontSize: 16
                    ),),
                  ),
                ),

                const SizedBox(height: 200,),

              ],
            ),
          ),
        );
      },
    );
  }
}
