
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:khoot/backend/models/entities/question_model.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/base_provider.dart';
import 'package:khoot/frontend/providers/view_question_deck_provider.dart';
import 'package:khoot/service_locator.dart';
import 'package:khoot/utils/constants.dart';
import 'package:khoot/utils/endpoints.dart';
import 'package:provider/provider.dart';

class AddQuestionProvider extends BaseProvider {

  String qdeckId;
  QuestionModel? qm;

  String question = "";
  String option1 = "";
  String option2 = "";
  String option3 = "";
  String option4 = "";
  String answer = "";
  num qt = 5;

  void addQuestion(BuildContext context) async {
    try {
      if (question.isEmpty) {
        ToastAlert.showErrorAlert("Please provide the question");
      } else if (option1.isEmpty) {
        ToastAlert.showErrorAlert("Please provide the first option");
      } else if (option2.isEmpty) {
        ToastAlert.showErrorAlert("Please provide a second option");
      } else if (option3.isEmpty) {
        ToastAlert.showErrorAlert("Please provide a third option");
      } else if (option4.isEmpty) {
        ToastAlert.showErrorAlert("Please provide a forth option");
      } else if (answer.isEmpty) {
        ToastAlert.showErrorAlert("Please provide an answer to the question");
      } else if (![option1, option2, option3, option4].contains(answer)) {
        ToastAlert.showErrorAlert("One of the options must be the answer");
      } else {
        if (qm != null) {
          _updateQuestion(context);
        } else {
          _createQuestion(context);
        }
      }
    } on DioError catch (error) {
      ToastAlert.closeAlert();
      ToastAlert.showErrorAlert(error.response!.data['message']);
    }catch (error) {
      ToastAlert.closeAlert();
      ToastAlert.showErrorAlert("Error: $error");
    }
  }

  void _updateQuestion(BuildContext context) async {
    ToastAlert.showLoadingAlert("");
    final response = await getIt<Dio>().put(AppEndpoints.updateQuestion(qdeckId, qm!.id!), options: Options(
        headers: {...requireTokenHeader}
    ), data: {
      "question": question,
      "option1": option1,
      "option2": option2,
      "option3": option3,
      "option4": option4,
      "answer": answer,
      "questionTime": qt,
      "questionType": "Quiz"
    }).then((value) {
      ToastAlert.closeAlert();
      ToastAlert.showAlert(value.data['message']);
      Future.delayed(const Duration(seconds: 2)).then((value) {
        // Provider.of<ViewQuestionDeckProvider>(context, listen: false).initialize();
        Navigator.pop(context, "reload");
      });
    });
  }

  void _createQuestion(BuildContext context) async {
    ToastAlert.showLoadingAlert("");
    final response = await getIt<Dio>().post(AppEndpoints.addQuestion(qdeckId), options: Options(
        headers: {...requireTokenHeader}
    ), data: {
      "question": question,
      "option1": option1,
      "option2": option2,
      "option3": option3,
      "option4": option4,
      "answer": answer,
      "questionTime": qt,
      "questionType": "Quiz"
    }).then((value) {
      ToastAlert.closeAlert();
      ToastAlert.showAlert(value.data['message']);
      Future.delayed(const Duration(seconds: 2)).then((value) {
        // Provider.of<ViewQuestionDeckProvider>(context, listen: false).initialize();
        Navigator.pop(context, "reload");
      });
    });
  }

  AddQuestionProvider(this.qdeckId, [this.qm]) {
    if (qm != null) {
      question = qm!.question!;
      option1 = qm!.option1!;
      option2 = qm!.option2!;
      option3 = qm!.option3!;
      option4 = qm!.option4!;
      answer = qm!.answer!;
      qt = qm!.questionTime!;
    }
  }
}