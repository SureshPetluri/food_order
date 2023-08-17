import 'package:get_storage/get_storage.dart';

class AppRepository {
  static final GetStorage _storage =
      GetStorage('STORAGE');

  static setAuthToken(String value) => _storage.write('authToken', value);
  static isSignIn(bool value) => _storage.write('signIn', value);

  static String getAuthToken() => _storage.read('authToken') ?? "";
  static bool getSignIn() => _storage.read('signIn') ?? false;
}
