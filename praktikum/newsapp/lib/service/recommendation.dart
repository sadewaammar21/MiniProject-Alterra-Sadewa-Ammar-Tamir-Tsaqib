import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/constans/open_ai.dart';
import 'package:newsapp/models/open_ai_,odels.dart';
import 'package:newsapp/models/usage_model.dart';

class RecommendationService {
  static Future<GPTData> getRecommendation({
    required String newsRegion,
    required String jenisBerita,
  }) async {
    late GPTData gptData = GPTData(
      id: "",
      object: "",
      created: 0,
      model: "",
      choices: [],
      usage: UsageData(
        promptToken: 0,
        completionToken: 0,
        totalTokens: 0,
      ),
    );

    try {
      var url = Uri.parse("https://api.openai.com/v1/completions");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Charset": "utf-8",
        "Authorization": "Bearer $apikey",
      };

      String promptData =
          "Kamu adalah seorang ahli berita carikanlah berita tahun 2023 di daerah $jenisBerita Dengan jenis berita $jenisBerita deskripsi nya dan tanggal penerbitannya serta berikan berita yang banyak Bukan cuma satu ";

      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promptData,
        "max_tokens": 400,
        "temperature": 0.7,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0,
      });

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        gptData = gptDataFromJson(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }

    return gptData;
  }
}
