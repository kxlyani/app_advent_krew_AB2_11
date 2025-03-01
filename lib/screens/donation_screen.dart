// Donation Screen - Allows users to donate to causes
import 'package:flutter/material.dart';
import 'package:relieflink/models/donation_campaign_card.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Make a Difference',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Your support can save lives and provide essential aid.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Featured Campaigns',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              DonationCampaignCard(
                title: 'Emergency Response: Nepal Earthquake',
                organization: 'International Red Cross',
                target: 500000,
                raised: 324560,
                imageUrl: 'https://placeholder.com/nepal_earthquake',
                onDonate: () {
                  // Show donation dialog or navigate to donation page
                },
              ),
              const SizedBox(height: 16.0),
              DonationCampaignCard(
                title: 'Food Aid for Yemen',
                organization: 'World Food Programme',
                target: 1000000,
                raised: 782450,
                imageUrl: 'https://placeholder.com/yemen_food_aid',
                onDonate: () {
                  // Show donation dialog or navigate to donation page
                },
              ),
              const SizedBox(height: 24.0),
              const Text(
                'All Causes',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Filter options
              SizedBox(
                height: 40.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: true,
                      onSelected: (selected) {
                        // Filter by all causes
                      },
                    ),
                    const SizedBox(width: 8.0),
                    FilterChip(
                      label: const Text('Disaster Relief'),
                      selected: false,
                      onSelected: (selected) {
                        // Filter by disaster relief
                      },
                    ),
                    const SizedBox(width: 8.0),
                    FilterChip(
                      label: const Text('Medical Aid'),
                      selected: false,
                      onSelected: (selected) {
                        // Filter by medical aid
                      },
                    ),
                    const SizedBox(width: 8.0),
                    FilterChip(
                      label: const Text('Food & Water'),
                      selected: false,
                      onSelected: (selected) {
                        // Filter by food and water
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              // List of all causes
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5, // Mock data
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: const Icon(Icons.volunteer_activism,
                          color: Colors.blue),
                    ),
                    title: Text('Cause ${index + 1}'),
                    subtitle: const Text('Organization name'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Show donation dialog
                      },
                      child: const Text('Donate'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}