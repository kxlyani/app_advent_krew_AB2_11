import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import '/services/OneSignalService.dart'; // Import the service
import 'OneSignalService.dart';
import 'package:relieflink/shared_preferences.dart';

class NotificationService {
  final OneSignalService _oneSignalService = OneSignalService();

  void startListening() {
    fetchDisasters();
    fetchCampaigns();
  }

  void fetchDisasters() async {
    Position? userLocation = await getUserLocation();
    
    if (userLocation == null) {
      print("❌ Unable to get user location");
      return;
    }

    // Example disaster data (Replace with Firebase API call)
    List<Map<String, dynamic>> disasters = [
      {
        "type": "Earthquake",
        "description": "A magnitude 6.5 earthquake has struck near the city.",
        "criticalLevel": "High",
        "latitude": 37.7750,
        "longitude": -122.4195
      },
      {
        "type": "Flood",
        "description": "Heavy rains have caused flooding in low-lying areas.",
        "criticalLevel": "Moderate",
        "latitude": 40.7128,
        "longitude": -74.0060
      },
      {
        "type": "Wildfire",
        "description": "A wildfire is spreading rapidly in the forest region.",
        "criticalLevel": "Severe",
        "latitude": 37.78,
        "longitude": -122.42
      }
    ];

    for (var disaster in disasters) {
      if (isDisasterNearby(disaster['latitude'], disaster['longitude'], userLocation)) {
        sendDisasterNotification(disaster);
      }
    }
  }

  void fetchCampaigns() async {
    // Replace with API call to fetch fundraising campaigns
    List<Map<String, dynamic>> campaigns = [
      {
        "campaign_name": "Help Flood Victims",
        "ngo_name": "Relief NGO",
        "disaster_type": "Flood",
      },
      {
        "campaign_name": "Support Wildfire Survivors",
        "ngo_name": "Aid Organization",
        "disaster_type": "Wildfire",
      }
    ];

    for (var campaign in campaigns) {
      sendFundraisingNotification(campaign);
    }
  }

  Future<Position?> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return null;
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  bool isDisasterNearby(double disasterLat, double disasterLng, Position userLocation) {
    double distance = Geolocator.distanceBetween(
        userLocation.latitude, userLocation.longitude, disasterLat, disasterLng);
    return distance < 10000; // 10 km radius
  }

  Future<void> sendDisasterNotification(Map<String, dynamic> data) async {
    String playerId = universalId; // Get from Shared Preferences

    _oneSignalService.sendNotification(
      title: "⚠ Disaster Alert: ${data['type']}",
      message: "${data['description']} - Severity: ${data['criticalLevel']}",
      playerId: playerId,
    );
  }

  Future<void> sendFundraisingNotification(Map<String, dynamic> data) async {
    String playerId = universalId; // Get from Shared Preferences

    _oneSignalService.sendNotification(
      title: "🚑 Help Needed: ${data['campaign_name']}",
      message:
          "NGO ${data['ngo_name']} is raising funds for ${data['disaster_type']}. Click to contribute.",
      playerId: playerId,
    );
  }
}