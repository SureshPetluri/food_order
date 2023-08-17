
import 'package:get_storage/get_storage.dart';

class AuthRepository{
  static final GetStorage signInRepo =  GetStorage("SIGN_IN_REPO");

  static loginComplete(String complete){
    return signInRepo.write("LOGIN", complete);
  }

  static rootObserverWrite(String rootName){
    return signInRepo.write("ROOT", rootName);
  }
  static authEmailWrite(String email){
    return signInRepo.write("EMAIL", email);
  }

  static authPasswordWrite(String password){
    return signInRepo.write("PASSWORD", password);
  }
  static String authEmailRead()=>signInRepo.read("EMAIL") ?? "";
  static String authPasswordRead()=>signInRepo.read("PASSWORD") ?? "";
  static String complete()=>signInRepo.read("LOGIN") ?? "";
  static String rootNameRead()=>signInRepo.read("ROOT") ?? "";

  setAuthToken(String password)=> signInRepo.write("authToken", password);

  String getAuthToken()=>signInRepo.read("authToken") ?? "";

}