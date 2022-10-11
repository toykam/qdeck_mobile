

import 'package:dio/dio.dart';
import 'package:khoot/backend/domain/services/i_localstorage_service.dart';
import 'package:khoot/backend/models/entities/qdeck.dart';
import 'package:khoot/frontend/interactions/toast_alerts.dart';
import 'package:khoot/frontend/providers/base_provider.dart';
import 'package:khoot/service_locator.dart';
import 'package:khoot/utils/constants.dart';
import 'package:khoot/utils/endpoints.dart';

class MyDeckProvider extends BaseProvider {

  List<Qdeck> decks = [];
  List<Qdeck> decksToDisplay = [];
  String searchParam = "";


  void initialize() async {
    try {
      backToLoading();
      final token = await getIt<ILocalStorageService>().getItem(userDataBox, userTokenKey);
      // final dio = Dio();
      final response = await getIt<Dio>().get(AppEndpoints.myDeck, options: Options(
        headers: {
          "authorization": token
        }
      ));
      decks = List.from(response.data['data']).map((e) => Qdeck.fromJson(e)).toList();
      decksToDisplay = decks;
      backToLoaded();
    } catch (error) {
      backToError("Error $error");
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
            element.name!.toLowerCase().contains(param.toLowerCase())
          ).toList();
        }
      }
      notifyListeners();
    } catch (error) {
      ToastAlert.showErrorAlert("Error: $error");
    }
  }

  MyDeckProvider() {
    initialize();
  }
}