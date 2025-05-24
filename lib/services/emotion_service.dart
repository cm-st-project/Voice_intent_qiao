import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:project_mickey/models/emotion_result.dart';
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

  Future<EmotionResult> analyzeAudio(List<int> audioData) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/audio-prosody'),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          audioData,
          filename: 'audio.wav',
          contentType: MediaType('audio', 'wav'),
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return EmotionResult.fromJson(data);
      } else {
        throw Exception(
          'Failed to analyze emotion: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error analyzing emotion: $e');
    }
  }
}
