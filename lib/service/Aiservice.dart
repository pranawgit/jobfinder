import 'dart:convert';
import 'package:http/http.dart' as http;

class AiService {
  final String apiKey =
      "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";

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
        "HTTP-Referer": "https://yourapp.com",
        "X-Title": "Job App AI",
      },
      body: jsonEncode({
        "model": "openai/gpt-4o-mini",
        "messages": [
          {"role": "user", "content": message},
        ],
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data["choices"][0]["message"]["content"];
    } else {
      return "Error: ${data["error"]?["message"]}";
    }
  }
}
