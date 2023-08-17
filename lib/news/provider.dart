import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchNews(String country,String category) async {
  final url = Uri.parse(
      'https://newsdata.io/api/1/news?apikey=pub_2639185c78fa0e52a7da3ff06a51a975aa582&q=india&country=in&language=en,te&category=$category');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final articles = jsonResponse['results'];
    return await articles;
  } else {
    throw Exception('Failed to fetch news');
  }
}
