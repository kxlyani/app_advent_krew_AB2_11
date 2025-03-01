// Dashboard Screen - Shows Crisis Information and maps
import 'package:flutter/material.dart';
import 'package:relieflink/models/crisis_update_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crisis Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Urgent Crises',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Crisis map placeholder
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text('Interactive Crisis Map'),
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Recent Updates',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // List of crisis updates
              CrisisUpdateCard(
                title: 'Earthquake in Nepal',
                description:
                    'Magnitude 7.2 earthquake struck central Nepal. Over 5,000 people affected.',
                category: 'Natural Disaster',
                timestamp: '2 hours ago',
                criticalLevel: 'High',
                onTap: () {
                  // Navigate to detailed crisis view
                },
              ),
              const SizedBox(height: 12.0),
              CrisisUpdateCard(
                title: 'Flooding in Bangladesh',
                description:
                    'Heavy monsoon rains cause severe flooding. 10,000+ displaced.',
                category: 'Natural Disaster',
                timestamp: '6 hours ago',
                criticalLevel: 'High',
                onTap: () {
                  // Navigate to detailed crisis view
                },
              ),
              const SizedBox(height: 12.0),
              CrisisUpdateCard(
                title: 'Humanitarian Crisis in Yemen',
                description:
                    'Food shortages affecting vulnerable populations. Aid needed urgently.',
                category: 'Humanitarian Conflict',
                timestamp: '1 day ago',
                criticalLevel: 'Critical',
                onTap: () {
                  // Navigate to detailed crisis view
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}