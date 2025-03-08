// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:relieflink/shared_preferences.dart';

// class NotificationService {
//   final String apiBaseUrl =
//       "https://relieflink-e824d-default-rtdb.firebaseio.com";
//   final String oneSignalAppId = "419ea6c0-3874-4aa5-9e7c-04713d0d063f";
//   final String oneSignalApiKey =
//       "os_v2_app_igpknqbyorfklht4aryt2digh6qqpvy6s4aucs5ttkvovq5lbcjkkv7delog2ll64dle2rlsxa66aj24aq4hxbhz6k2hz3hnqnitjyq"; // Replace with your OneSignal REST API key

//   void startListening() {
//     fetchDisasters();
//     fetchCampaigns();
//   }
// void fetchDisasters() async {
//   // Position userLocation = Position(
//   //   latitude: 37.7749, // Example user latitude
//   //   longitude: -122.4194, // Example user longitude
//   //   timestamp: DateTime.now(),
//   //   accuracy: 10.0, // Example accuracy in meters
//   //   altitude: 30.0, // Example altitude in meters
//   //   altitudeAccuracy: 5.0, // Example altitude accuracy in meters
//   //   heading: 0.0, // Example heading in degrees
//   //   headingAccuracy: 5.0, // Example heading accuracy in degrees
//   //   speed: 0.0, // Example speed in m/s
//   //   speedAccuracy: 0.0, // Example speed accuracy in m/s
//   // );

//   Position? userLocation = await getUserLocation();

//   // Dummy disaster data
//   List<Map<String, dynamic>> disasters = [
//     {
//       "type": "Earthquake",
//       "description": "A magnitude 6.5 earthquake has struck near the city.",
//       "criticalLevel": "High",
//       "latitude": 37.7750, // Near user location
//       "longitude": -122.4195
//     },
//     {
//       "type": "Flood",
//       "description": "Heavy rains have caused flooding in low-lying areas.",
//       "criticalLevel": "Moderate",
//       "latitude": 40.7128, // Far from user location
//       "longitude": -74.0060
//     },
//     {
//       "type": "Wildfire",
//       "description": "A wildfire is spreading rapidly in the forest region.",
//       "criticalLevel": "Severe",
//       "latitude": 37.78, // Close to user
//       "longitude": -122.42
//     }
//   ];

//   for (var disaster in disasters) {
//     double lat = disaster['latitude'];
//     double lng = disaster['longitude'];

//     if (isDisasterNearby(lat, lng, userLocation!)) {
//       sendDisasterNotification(disaster);
//     }
//   }
// }




//   void fetchCampaigns() async {
//     final response = await http.get(Uri.parse("$apiBaseUrl/campaigns"));
//     if (response.statusCode == 200) {
//       List<dynamic> campaigns = json.decode(response.body);
//       for (var campaign in campaigns) {
//         sendFundraisingNotification(campaign);
//       }
//     }
//   }

//   Future<Position?> getUserLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return null;

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.deniedForever) return null;
//     }

//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   bool isDisasterNearby(
//       double disasterLat, double disasterLng, Position userLocation) {
//     double distance = Geolocator.distanceBetween(userLocation.latitude,
//         userLocation.longitude, disasterLat, disasterLng);
//     return distance < 1000000000000; // 10 km radius
//   }

//   Future<void> sendDisasterNotification(Map<String, dynamic> data) async {
//   String playerId = universalId;

//   print('DISASTER NOTIFICATION SENT, sending request to OneSignal...');

//   final response = await http.post(
//     Uri.parse("https://onesignal.com/api/v1/notifications"),
//     headers: {
//       "Authorization": "Basic $oneSignalApiKey",
//       "Content-Type": "application/json"
//     },
//     body: jsonEncode({
//       "app_id": oneSignalAppId,
//       "include_player_ids": [playerId],
//       "headings": {"en": "⚠ Disaster Alert: ${data['type']}"},
//       "contents": {
//         "en": "${data['description']} - Severity: ${data['criticalLevel']}"
//       },
//     }),
//   );

//   print("OneSignal Response: ${response.statusCode}");
//   print("Response Body: ${response.body}");
// }


//   Future<void> sendFundraisingNotification(Map<String, dynamic> data) async {
//     // Replace with your player ID or fetch it from your backend
//     String playerId =
//         universalId; // You need to store and retrieve this from your backend
//     print('FUNDRAISE NOTIFICATION SENT');
//     final response = await http.post(
//       Uri.parse("https://onesignal.com/api/v1/notifications"),
//       headers: {
//         "Authorization": "Basic $oneSignalApiKey",
//         "Content-Type": "application/json"
//       },
//       body: jsonEncode({
//         "app_id": oneSignalAppId,
//         "include_player_ids": [playerId],
//         "headings": {"en": "🚑 Help Needed: ${data['campaign_name']}"},
//         "contents": {
//           "en":
//               "NGO ${data['ngo_name']} is raising funds for ${data['disaster_type']}. Click to contribute."
//         },
//       }),
//     );

//     if (response.statusCode != 200) {
//       print("Failed to send fundraising notification: ${response.body}");
//     }
//   }

//   Future<void> fetchNotifications() async {
//     final response = await http.get(
//       Uri.parse(
//           "https://onesignal.com/api/v1/notifications?app_id=$oneSignalAppId"),
//       headers: {
//         "Authorization": "Basic $oneSignalApiKey",
//       },
//     );

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       print("Notifications: $data");
//     } else {
//       print("Failed to fetch notifications: ${response.body}");
//     }
//   }
// }

// class NotificationPage extends StatefulWidget {
//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   final NotificationService _notificationService = NotificationService();

//   @override
//   void initState() {
//     super.initState();
//     _notificationService.startListening();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Notifications Service")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Listening for disaster and campaign updates..."),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _notificationService.fetchNotifications(),
//               child: Text("Fetch Past Notifications"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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