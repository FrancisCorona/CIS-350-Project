import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> query(String postMessage) async {
  var apiKey = 'API_KEY';

  final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=$apiKey');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    "prompt": {
      "context": "You are an awesome summarizer, but can only use one word.",
      "examples": [
        {
          "input": {"content": "Ugh, parking at GVSU is a never-ending nightmare! Spent 30 minutes circling for a spot today."},
          "output": {"content": "Parking"}
        },
        {
          "input": {"content": "Does anyone else find Mackinac confusing as heck? Got lost AGAIN today."},
          "output": {"content": "Mackinac"}
        },
        {
          "input": {"content": "The dining hall food is terrible! We need better food options on campus."},
          "output": {"content": "Food"}
        }
      ],
      "messages": [
        {"content": "Generate one word to label the following text and do not use punctuation: $postMessage"}
      ]
    },
    "temperature": 1,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final string =  decodedResponse['candidates'][0]['content'];

      String cleanString = string.replaceAllMapped(
        RegExp(r'[^A-Za-z-]'), // This regex cleans up AI output, removing unwanted characters
            (match) {
          return ''; // Replace each non-matching character with an empty string
        },
      );

      return cleanString;
    } else {
      throw 'Request failed with status ${response.statusCode}.\n${response.body}';
    }
  } catch (error) {
    throw Exception('Error sending POST request: $error');
  }
}