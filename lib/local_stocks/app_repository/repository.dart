
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';

class Repository {
  static final GetStorage _storage = GetStorage(LOCAL_STORAGE);

  static bool? isDark() => _storage.read('themeMode');

  static changeTheme(bool val) => _storage.write('themeMode', val);
}