import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  List<Map<String, dynamic>> campaigns = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCampaigns();
  }

  Future<void> fetchCampaigns() async {
    final url = Uri.parse('https://relieflink-e824d-default-rtdb.firebaseio.com/campaigns.json');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);
        if (data != null) {
          setState(() {
            campaigns = data.entries.map((entry) => entry.value as Map<String, dynamic>).toList();
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load campaigns');
      }
    } catch (error) {
      print('Error fetching campaigns: $error');
      setState(() {
        isLoading = false;
      });
    }
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
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: campaigns.map((campaign) {
                        return Column(
                          children: [
                            DonationCampaignCard(
                              title: campaign['campaignName'],
                              organization: campaign['ngoEmail'],
                              target: (campaign['goal']),
                              raised: (campaign['raised']),
                              merchantId: campaign['merchantId'],
                              imageUrl: campaign['imageUrl'] ?? 'https://educationpost.in/_next/image?url=https%3A%2F%2Fapi.educationpost.in%2Fs3-images%2F1736253267338-untitled%20(39).jpg&w=1920&q=75',
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        );
                      }).toList(),
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
                    _buildFilterChip('All'),
                    _buildFilterChip('Disaster Relief'),
                    _buildFilterChip('Medical Aid'),
                    _buildFilterChip('Food & Water'),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Causes List
              Column(
                children: List.generate(5, (index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: const Icon(Icons.volunteer_activism, color: Colors.blue),
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
                                      target: '1000',
                                      raised: '733',
                                      organization: 'Organization Name',
                                      merchantId: '',
                                    ),
                                  ),
                                );
                              } else {
                                _showLoginDialog();
                              }
                            },
                            child: const Text('Donate'),
                          ),
                        ),
                      ),
                      const Divider(),
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

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: selectedFilter == label,
        onSelected: (selected) {
          setState(() {
            selectedFilter = label;
          });
        },
      ),
    );
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Required'),
        content: const Text('You need to login to donate. Please login first.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => LoginScreen()),
              );
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
