

import 'package:dio/dio.dart';
import 'package:khoot/backend/models/entities/question_deck.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/base_provider.dart';
import 'package:khoot/utils/endpoints.dart';

class DeckProvider extends BaseProvider {

  List<QuestionDeck> decks = [];
  List<QuestionDeck> decksToDisplay = [];

  String searchParam = "";

  void initialize() async {
    try {
      final dio = Dio();
      final deckResponse = await dio.get(AppEndpoints.getDecks);
      decks = List.from(deckResponse.data['data']).map((e) => QuestionDeck.fromJson(e)).toList();
      decksToDisplay = decks;
      backToLoaded();
    } on DioError catch(error) {
      ToastAlert.showErrorAlert("Error: $error");
      backToError('Error: $error');
    } catch (error) {
      backToError("Error: $error");
    }
  }

  void searchQDeck(String param) async {
    try {
      searchParam = param;
      if (param.isEmpty) {
        decksToDisplay = decks;
      } else {
        if (param.length > 2) {
          decksToDisplay = decks.where((element) =>
            element.name!.toLowerCase().contains(param.toLowerCase()) ||
            element.user!.name!.toLowerCase().contains(param.toLowerCase())
          ).toList();
        }
      }
      notifyListeners();
    } catch (error) {
      ToastAlert.showErrorAlert("Error: $error");
    }
  }

  DeckProvider() {
    initialize();
  }

}