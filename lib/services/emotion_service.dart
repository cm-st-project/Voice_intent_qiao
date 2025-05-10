import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../models/pragmatic_result.dart';

class EmotionService {
  final String baseUrl;

  EmotionService({required this.baseUrl});

  Future<PragmaticResult> analyzePragmaticLanguage(String text) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/pragmatic"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return PragmaticResult.fromJson(data);
      } else {
        throw Exception(
          "Failed to analyze pragmatic language: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error analyzing pragmatic language: $e");
    }
  }
}
