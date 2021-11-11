import 'package:xkcd_demo/models/comic.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  static final HttpService _instance = new HttpService._internal();

  final _baseURL = 'https://www.xkcd.com/';
  final _baseSuffix = 'info.0.json';

  Future<Comic> getComic({int num = 0}) async {
    String requestURL = num == 0
        ? _baseURL + _baseSuffix
        : _baseURL + num.toString() + '/' + _baseSuffix;
    final response = await http
        .get(Uri.parse(requestURL), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      return Comic.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load comic');
    }
  }

  Future<List<Comic>> getComicBatch(List<int> nums) async {
    final requestFutures = <Future>[];
    final retrievedComics = <Comic>[];

    for (int num in nums) {
      requestFutures.add(
          http.get(Uri.parse(_baseURL + num.toString() + '/' + _baseSuffix)));
    }

    final results = await Future.wait(requestFutures);

    for (var response in results) {
      if (response.statusCode == 200) {
        retrievedComics.add(Comic.fromJson(jsonDecode(response.body)));
      } else {
        throw Exception('Failed to load comics');
      }
    }

    return retrievedComics;
  }
}
