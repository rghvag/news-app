
import 'package:http/http.dart' as http;
import 'package:newsapplication/models/article.dart';
import 'dart:convert';

import 'package:newsapplication/services/firebase_remote_config.dart';

class NewsService {
  final RemoteConfigService _remoteConfigService = RemoteConfigService();

  Future<List<Article>> fetchTopHeadlines() async {
    final country = await _remoteConfigService.getCountryCode();
    print('country:');
    print(country);
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=${country}&category=business&apiKey=55e360bf830145608daef57e523c26c2'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final articles = (jsonResponse['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      print(' code : ${response.statusCode}  ');
      throw Exception(' code : ${response.statusCode} ');
    }
  }
}
