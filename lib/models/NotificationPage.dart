import 'package:flutter/material.dart';
// import '../services/NotificationService.dart';
import 'package:relieflink/services/NotificationService.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications Service")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Listening for disaster and campaign updates..."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _notificationService.fetchCampaigns(),
              child: Text("Fetch Fundraising Campaigns"),
            ),
          ],
        ),
      ),
    );
  }
}