import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth_android/local_auth_android.dart';

class LocalAuth {
  static final localAuthentication = LocalAuthentication();


  static Future<bool> hasBiometrics() async {
    try {
      print("hasBiometrics");
      return await localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      print("object");
      return await localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return [];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    // print("isAvailable ....,,,$isAvailable");
    if (!isAvailable) return false;

    try {
      print("isAvailable .try...,,,$isAvailable");
      return await localAuthentication.authenticate(
          localizedReason: 'Scan Fingerprint to Authenticate',
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Unlock Food Order!',
              cancelButton: 'Cancel',
            ),
            IOSAuthMessages(
              localizedFallbackTitle:'Unlock Food Order!',
              cancelButton: 'Cancel',
            ),
          ],
          options: const AuthenticationOptions(
              useErrorDialogs: true,
              stickyAuth: true,
              // biometricOnly: true,
              sensitiveTransaction: false));
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<bool> authenticateWithNameAndPassword() async {
    String storedEmail = "AuthRepository.authEmailRead()";
    String storedPassword = "AuthRepository.authPasswordRead()";
    print("authEmailRead  $storedPassword");
    if (storedEmail.isNotEmpty && storedPassword.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}