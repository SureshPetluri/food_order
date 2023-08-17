

import 'package:food_order/jobs_show/jobs/constants.dart';
import 'package:food_order/jobs_show/jobs/provider/provider_handler.dart';

class LoginRepository {
  static Future<String> userLoginPost(Map<String, dynamic> body) async {
    return await ProviderHandler.requestApi(RequestMethod.post, userLogin,
        body: body);
  }

  static Future<String> userSignUpPost(Map<String, dynamic> body) async {
    return await ProviderHandler.requestApi(RequestMethod.post, userSignUp,
        body: body);
  }

  static Future<String> agentLoginPost(Map<String, dynamic> body) async {
    return await ProviderHandler.requestApi(RequestMethod.post, agentLogin,
        body: body);
  }

  static Future<String> agentSignUpPost(Map<String, dynamic> body) async {
    return await ProviderHandler.requestApi(RequestMethod.post, agentSignUp,
        body: body);
  }

  static Future<String> vendorLoginPost(Map<String, dynamic> body) async {
    return await ProviderHandler.requestApi(RequestMethod.post, vendorLogin,
        body: body);
  }

  static Future<String> vendorSignUpPost(Map<String, dynamic> body) async {
    return await ProviderHandler.requestApi(RequestMethod.post, vendorSignUp,
        body: body);
  }
}