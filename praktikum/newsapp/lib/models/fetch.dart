import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsProvider extends ChangeNotifier {
  List _posts = [];

  List get posts => _posts;

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=31806ef65be84ce097b9691e3750d14b'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _posts = data["articles"];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
