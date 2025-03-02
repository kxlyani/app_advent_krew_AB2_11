import 'package:flutter/material.dart';
import 'package:relieflink/login/loginscreen.dart';
import 'package:relieflink/models/donation_campaign_card.dart';
import 'package:relieflink/shared_preferences.dart';
import 'package:relieflink/widgets/donation_details.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    // Fetch login status (Mocked for now)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donate')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Make a Difference',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Your support can save lives and provide essential aid.',
                style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
              ),
              const SizedBox(height: 24.0),

              // Featured Campaigns
              const Text(
                'Featured Campaigns',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              DonationCampaignCard(
                title: 'Emergency Response: Nepal Earthquake',
                organization: 'International Red Cross',
                target: 500000,
                raised: 324560,
                imageUrl:
                    'https://educationpost.in/_next/image?url=https%3A%2F%2Fapi.educationpost.in%2Fs3-images%2F1736253267338-untitled%20(39).jpg&w=1920&q=75',
              ),
              const SizedBox(height: 16.0),
              DonationCampaignCard(
                title: 'Food Aid for Yemen',
                organization: 'World Food Programme',
                target: 1000000,
                raised: 782450,
                imageUrl:
                    'https://static01.nyt.com/images/2020/06/02/world/02yemen/merlin_151928292_cdfa4fd7-df5c-482a-9df3-cc1aa348260f-superJumbo.jpg?quality=75&auto=webp',
              ),
              const SizedBox(height: 24.0),

              // Filter Section
              const Text(
                'All Causes',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 40.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: selectedFilter == 'All',
                      onSelected: (selected) {
                        setState(() {
                          selectedFilter = 'All';
                        });
                      },
                    ),
                    const SizedBox(width: 8.0),
                    FilterChip(
                      label: const Text('Disaster Relief'),
                      selected: selectedFilter == 'Disaster Relief',
                      onSelected: (selected) {
                        setState(() {
                          selectedFilter = 'Disaster Relief';
                        });
                      },
                    ),
                    const SizedBox(width: 8.0),
                    FilterChip(
                      label: const Text('Medical Aid'),
                      selected: selectedFilter == 'Medical Aid',
                      onSelected: (selected) {
                        setState(() {
                          selectedFilter = 'Medical Aid';
                        });
                      },
                    ),
                    const SizedBox(width: 8.0),
                    FilterChip(
                      label: const Text('Food & Water'),
                      selected: selectedFilter == 'Food & Water',
                      onSelected: (selected) {
                        setState(() {
                          selectedFilter = 'Food & Water';
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Causes List (Replaced ListView.builder with Column)
              Column(
                children: List.generate(5, (index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: const Icon(Icons.volunteer_activism,
                              color: Colors.blue),
                        ),
                        title: Text('Cause ${index + 1}'),
                        subtitle: const Text('Organization name'),
                        trailing: SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () {
                              if (logStatus == true) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => DonationDetails(
                                      imageUrl:
                                          'https://dialogue.earth/content/uploads/2016/10/earthquake-clark-wang.jpg',
                                      title: 'Cause ${index + 1}',
                                      target: 1000,
                                      raised: 733,
                                      organization: 'Organization Name',
                                    ),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Login Required'),
                                    content: const Text(
                                        'You need to login to donate. Please login first.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (ctx) => LoginScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text('Login'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: const Text('Donate'),
                          ),
                        ),
                      ),
                      const Divider(), // Adds a visual separation
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
