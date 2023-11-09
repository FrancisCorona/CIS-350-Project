import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const API_URL = "https://api-inference.huggingface.co/models/michellejieli/emotion_text_classifier";
const API_KEY = "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";

Future<List<List<Map<String, dynamic>>>> query(Map<String, dynamic> payload) async {
  final response = await http.post(
    Uri.parse(API_URL),
    headers: {
      'Authorization': 'Bearer $API_KEY',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(payload),
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse is List<dynamic> && jsonResponse.isNotEmpty) {
      return [jsonResponse[0].cast<Map<String, dynamic>>()];
    } else {
      throw Exception('Invalid response format');
    }
  } else {
    throw Exception('Failed to query the API: ${response.statusCode}');
  }
}

Future<String?> fetchTag(String message) async {
  try {
    final response = await query({
      "inputs": message,
    });

    if (response.isNotEmpty) {
      final firstLabel = response[0][0]['label'] as String;
      return emotionToEmoji[firstLabel];
    } else {
      throw Exception("Error: Empty API response on firstResponse");
    }
  } catch (e) {
    print("first request failed, trying again");
    await Future.delayed(const Duration(milliseconds: 1000)); // Add a 100ms delay to avoid spamming the api
    try {
      final secondResponse = await query({
        "inputs": message,
      });

      if (secondResponse.isNotEmpty) {
        final secondLabel =  secondResponse[0][0]['label'] as String;
        return emotionToEmoji[secondLabel];
      } else {
        throw Exception("Error: Empty API response on secondResponse");
      }
    } catch (secondException) {
      // Handle the error for the second query
      throw Exception("Error2: $secondException");
    }
  }
}

Map<String, String> emotionToEmoji = {
  'anger': '😡 angry',
  'disgust': '🤢 disgusted',
  'fear': '😨 fearful',
  'joy': '😄 joyful',
  'neutral': '😐 neutral',
  'sadness': '😢 sad',
  'surprise': '😲 surprised',
};
