

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoot/backend/domain/services/i_localstorage_service.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/my_deck_provider.dart';
import 'package:khoot/frontend/styles/colors.dart';
import 'package:khoot/frontend/widgets/page_header.dart';
import 'package:khoot/service_locator.dart';
import 'package:khoot/utils/constants.dart';
import 'package:khoot/utils/endpoints.dart';
import 'package:provider/provider.dart';

class CreateQuestionDeckScreen extends StatefulWidget {
  const CreateQuestionDeckScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuestionDeckScreen> createState() => _CreateQuestionDeckScreenState();
}

class _CreateQuestionDeckScreenState extends State<CreateQuestionDeckScreen> {

  final TextEditingController nameController = TextEditingController();


  void createQuestionDeck(BuildContext context) async {
    try {
      if (nameController.text.isEmpty) {
        ToastAlert.showErrorAlert("Please provide a name for your deck");
      } else {
        ToastAlert.showLoadingAlert("");
        final token = await getIt<ILocalStorageService>().getItem(userDataBox, userTokenKey, defaultValue: null);
        await getIt<Dio>().post(AppEndpoints.createQuestionDeck, data: {
          "name": nameController.text
        }, options: Options(
          headers: {
            "authorization": token
          }
        )).then((value) {
          ToastAlert.showAlert("Deck created successfully");
          Provider.of<MyDeckProvider>(context, listen: false).initialize();
          ToastAlert.closeAlert();
          context.pop();
        });
      }
    } on DioError catch (error) {
      ToastAlert.closeAlert();
      print(error);
      ToastAlert.showErrorAlert(error.response!.data['message']);
    } catch (error) {
      ToastAlert.closeAlert();
      ToastAlert.showErrorAlert("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    // ToastAlert.closeAlert();
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          const SizedBox(height: 100,),

          const PageHeaderWidget(
            title: "Create Question Deck",
            subtitle: "input question deck name below",
          ),

          const SizedBox(height: 50,),

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
                  hintText: "Deck name",
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
                controller: nameController
            ),
          ),

          const Expanded(child: SizedBox(height: 200,)),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ElevatedButton(
              onPressed: () => createQuestionDeck(context),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      vertical: 16
                  ))
              ),
              child: Text("Create Deck", style: TextStyle(
                  color: AppColors.backGroundColor, fontSize: 16
              ),),
            ),
          ),

          const SizedBox(height: 50,),

        ],
      ),
    );
  }
}