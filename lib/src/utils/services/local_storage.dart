import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final box = GetStorage();
  Future<void> saveData(String key, String value) async {
    box.write(key, value);
  }

  String getData(String key) {
    if (box.read(key) != null) {
      return box.read(key);
    } else {
      return "";
    }
  }
}
