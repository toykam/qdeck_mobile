

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khoot/backend/models/entities/qdeck.dart';
import 'package:khoot/backend/models/entities/question_model.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/base_provider.dart';
import 'package:khoot/frontend/providers/my_deck_provider.dart';
import 'package:khoot/service_locator.dart';
import 'package:khoot/utils/constants.dart';
import 'package:khoot/utils/endpoints.dart';
import 'package:provider/provider.dart';

class ViewQuestionDeckProvider extends BaseProvider {

  String qdeckId;

  List<QuestionModel> questions = [];
  late Qdeck questionDeck;

  void initialize() async {
    try {
      final response = await getIt<Dio>().get(AppEndpoints.getUserDeck(qdeckId), options: Options(
        headers: {
          ...requireTokenHeader
        }
      ));
      questionDeck = Qdeck.fromJson(response.data['data']);
      questions = questionDeck.questions!;
      backToLoaded();
    } catch (error) {
      backToError("Error: $error");
    }
  }

  void deleteQDeck(BuildContext context) async {
    try {
      ToastAlert.showLoadingAlert("");
      final res = await getIt<Dio>().delete(AppEndpoints.deleteUserDeck(questionDeck.id!), options: Options(
        headers: {
          ...requireTokenHeader
        }
      ));
      ToastAlert.showAlert(res.data['message']);
      Future.delayed(const Duration(seconds: 2)).then((value) {
        context.pop();
        Provider.of<MyDeckProvider>(context, listen: false).initialize();
      });
    } on DioError catch(error) {
      print(error.response);
      ToastAlert.closeAlert();
      ToastAlert.showErrorAlert(error.response!.data['message']);
    } catch (error) {
      ToastAlert.closeAlert();
      ToastAlert.showErrorAlert("Error: $error");
    }
  }

  void deleteQDeckQuestion(BuildContext context, String qid) async {
    try {
      ToastAlert.showLoadingAlert("");
      final res = await getIt<Dio>().delete(AppEndpoints.deleteQuestion(questionDeck.id!, qid), options: Options(
        headers: {
          ...requireTokenHeader
        }
      ));
      ToastAlert.showAlert(res.data['message']);
      Future.delayed(const Duration(seconds: 2)).then((value) {
        initialize();
      });
    } on DioError catch(error) {
      ToastAlert.closeAlert();
      ToastAlert.showErrorAlert(error.response!.data['message']);
    } catch (error) {
      ToastAlert.closeAlert();
      ToastAlert.showErrorAlert("Error: $error");
    }
  }

  ViewQuestionDeckProvider(this.qdeckId) {
    initialize();
  }
}