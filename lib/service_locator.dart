
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khoot/backend/domain/services/i_localstorage_service.dart';
import 'package:khoot/backend/infra/service/local_storage/hive_localstorage.dart';
import 'package:khoot/utils/constants.dart';

final getIt = GetIt.instance;


void setUpServiceLocator() {
  final dio = Dio();
  dio.interceptors.add(TokenInterceptor());

  getIt.registerSingleton<ILocalStorageService>(HiveLocalStorage());
  getIt.registerSingleton<Dio>(dio);
}


class TokenInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint("TokenInterceptor:::OnRequest");
    /// check for token requirement
    if (options.headers.containsKey('requireToken')) {
      options.headers.remove("requiresToken");
      if (options.headers['requireToken'] == true) {
        final token = await getIt<ILocalStorageService>().getItem(userDataBox, userTokenKey);
        // if (token == null) {
        //   final error = DioError(requestOptions: options, error: "Unauthenticated");
        //   super.onError(error, handler);
        // }
        options.headers['authorization'] = "$token";
      }
    }
    // return options;
    super.onRequest(options, handler);
  }

}