

import 'package:dio/dio.dart';
import 'package:khoot/backend/domain/services/i_localstorage_service.dart';
import 'package:khoot/backend/models/entities/qdeck.dart';
import 'package:khoot/frontend/providers/base_provider.dart';
import 'package:khoot/service_locator.dart';
import 'package:khoot/utils/constants.dart';
import 'package:khoot/utils/endpoints.dart';

class MyDeckProvider extends BaseProvider {
  List<Qdeck> decks = [];


  void initialize() async {
    try {
      final token = await getIt<ILocalStorageService>().getItem(userDataBox, userTokenKey);
      final dio = Dio();
      final response = await dio.get(AppEndpoints.myDeck);

      backToLoaded();
    } catch (error) {

    }
  }

  MyDeckProvider() {
    initialize();
  }
}