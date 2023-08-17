import 'package:food_order/jobs_show/jobs/repository/app_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../constants.dart';

enum RequestMethod { get, post, patch, put, delete }

class ProviderHandler {
 static Future<String> requestApi(
    RequestMethod method,
    String path, {
    final Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    final Map<String, String>? headers,
    final boolToken = false,
  }) {
    String apiBase = baseUrl + path;
    print("apiBase....$apiBase");
    return getApiResponse(method, apiBase, params: params, body: body);
  }

 static Future<String> getApiResponse(
    RequestMethod method,
    String url, {
    final Map<String, dynamic>? params,
    final Map<String, dynamic>? body,
    final Map<String, String>? headers,
    final boolToken = false,
  }) async {
    Map<String, String> headers = boolToken
        ? {
            CONTENT_TYPE: APPLICATION_JSON,
            AUTHORIZATION:
                OAUTH_BEARER + AppRepository.getAuthToken()
          }
        : {};

    Response response;
    String respBody = "";
    try {
      print("try");
      switch (method) {
        case RequestMethod.get:
          response = await http.get(Uri.parse(url), headers: headers);
          if (response.statusCode == 200) {
            respBody = response.body;
            print(response.body);
          } else {
            print('GET request failed with status: ${response.statusCode}');
          }
          break;
        case RequestMethod.post:
          print("post...$url");
          response =
              await http.post(Uri.parse(url),headers: headers, body: body);
          print("post...$url");
          print("post.body..$body");
          print("post.response..${response.body}");
          if (response.statusCode == 200) {
            respBody = response.body;
            print(response.body);
          } else {
            print('post request failed with status: ${response.statusCode}');
          }
          break;
        case RequestMethod.put:
          response =
              await http.put(Uri.parse(url), headers: headers, body: body);
          if (response.statusCode == 200) {
            respBody = response.body;
            print(response.body);
          } else {
            print('put request failed with status: ${response.statusCode}');
          }
          break;
        case RequestMethod.delete:
          response =
              await http.delete(Uri.parse(url), headers: headers, body: body);
          if (response.statusCode == 200) {
            respBody = response.body;
            print(response.body);
          } else {
            print('delete request failed with status: ${response.statusCode}');
          }
          break;
        case RequestMethod.patch:
          response =
              await http.patch(Uri.parse(url), headers: headers, body: body);
          if (response.statusCode == 200) {
            respBody = response.body;
            print(response.body);
          } else {
            print('patch request failed with status: ${response.statusCode}');
          }
          break;
        default:
          throw Exception('Request Method: $method not implemented');
      }
    } catch (e) {
      return respBody = "";
    }
    return respBody;
  }
}
