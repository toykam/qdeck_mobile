
import 'package:get_it/get_it.dart';
import 'package:khoot/backend/domain/services/i_localstorage_service.dart';
import 'package:khoot/backend/infra/service/local_storage/hive_localstorage.dart';

final getIt = GetIt.instance;
void setUpServiceLocator() {
  getIt.registerSingleton<ILocalStorageService>(HiveLocalStorage());
}