

import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> sendFCMMessage(String token, String title, String body) async {
  final String serverKey = 'AAAAHXOa4oA:APA91bG3PcQwkNGCATsoKDoXjvROAGN2NSHcfIU6c4dcMqWRz93ThsBzUB9GmCsj77PakBLHcDQ_UQQTMluQYxb_DjufHO1wkKXXriAYX6wnmHPxaBQ9kQ3nYXIIH7bogx7NlDMuByNk';
  final String fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final bodyData = {
    'to': token,
    'notification': {'title': title, 'body': body},
  };

  try {
    final response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: headers,
      body: jsonEncode(bodyData),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully.');
    } else {
      print('Failed to send message. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending message: $e');
  }
}
