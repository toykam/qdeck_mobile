import 'package:hive/hive.dart';
import 'package:khoot/backend/domain/services/i_localstorage_service.dart';
import 'package:khoot/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

class HiveLocalStorage implements ILocalStorageService {

  HiveLocalStorage() {
    init();
  }

  @override
  Future getItem(storage, key, {defaultValue}) async {
    final box = await Hive.openBox(storage);
    return box.get(key, defaultValue: defaultValue);
  }

  @override
  Future<void> init() async {
    final dbPath = await getApplicationDocumentsDirectory();
    Hive.init(dbPath.path);
    await Hive.openBox(userDataBox);
  }

  @override
  Future<bool> removeItem(storage, key) async {
    final box = await Hive.openBox(storage);
    box.delete(key);
    return (await getItem(storage, key, defaultValue: null)) == null;
  }

  @override
  Future<bool> setItem(storage, key, value) async {
    final box = await Hive.openBox(storage);
    await box.put(key, value);
    return (await getItem(storage, key, defaultValue: null)) == value;
  }

}