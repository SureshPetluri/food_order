

import 'package:food_order/jobs_show/jobs/constants.dart';
import 'package:food_order/jobs_show/jobs/provider/provider_handler.dart';

class RegistrationRepository{

  static Future<String> userSignUpPost(Map<String, dynamic> body)async{
    return await ProviderHandler.requestApi(RequestMethod.post, userLogin,body: body);
  }
  static Future<String> vendorSignUpPost(Map<String, dynamic> body)async{
    return await ProviderHandler.requestApi(RequestMethod.post, userLogin,body: body);
  }
  static Future<String> agentSignUpPost(Map<String, dynamic> body)async{
    return await ProviderHandler.requestApi(RequestMethod.post, userLogin,body: body);
  }
}