import 'package:khoot/backend/domain/services/i_localstorage_service.dart';
import 'package:khoot/frontend/providers/base_provider.dart';
import 'package:khoot/service_locator.dart';
import 'package:khoot/utils/constants.dart';

class AuthProvider extends BaseProvider {

  bool isLoggedIn = false;

  void initialize() async {
    final token = await getIt<ILocalStorageService>().getItem(userDataBox, userTokenKey, defaultValue: null);
    isLoggedIn = token != null;
    notifyListeners();
  }

  AuthProvider() {
    initialize();
  }
}