import 'package:get/get.dart';
import '../service/Aiservice.dart';

class ChatController extends GetxController {
  final AiService _aiService = AiService();

  var messages = <Map<String, String>>[].obs;
  var isLoading = false.obs;

  void sendMessage(String text) async {
    if (text.isEmpty) return;

    messages.add({"role": "user", "message": text});
    isLoading(true);

    String reply = await _aiService.sendMessage(text);

    messages.add({"role": "bot", "message": reply});
    isLoading(false);
  }
}
