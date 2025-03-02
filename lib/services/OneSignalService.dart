import 'package:http/http.dart' as http;
import 'dart:convert';

class OneSignalService {
  final String oneSignalAppId = "419ea6c0-3874-4aa5-9e7c-04713d0d063f";
  final String oneSignalApiKey = "os_v2_app_igpknqbyorfklht4aryt2digh6qqpvy6s4aucs5ttkvovq5lbcjkkv7delog2ll64dle2rlsxa66aj24aq4hxbhz6k2hz3hnqnitjyq";

  Future<void> sendNotification({
    required String title,
    required String message,
    required String playerId, 
  }) async {
    final Uri url = Uri.parse("https://onesignal.com/api/v1/notifications");

    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Basic $oneSignalApiKey"
    };

    final Map<String, dynamic> body = {
      "app_id": oneSignalAppId,
      "include_player_ids": [playerId], // Send notification to specific user
      "headings": {"en": title},
      "contents": {"en": message}
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("✅ Push notification sent successfully!");
    } else {
      print("❌ Failed to send notification: ${response.body}");
    }
  }
}