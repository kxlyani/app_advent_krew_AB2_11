// Transparency Screen - Shows fund allocation and impact
import 'package:flutter/material.dart';
import 'package:relieflink/models/impact_stat_card.dart';

class TransparencyScreen extends StatelessWidget {
  const TransparencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impact & Transparency'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Impact',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Track how your donations are making a difference',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 24.0),
              // Impact stats
              Row(
                children: [
                  Expanded(
                    child: ImpactStatCard(
                      icon: Icons.volunteer_activism,
                      value: '\$1,280',
                      label: 'Your Donations',
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: ImpactStatCard(
                      icon: Icons.people,
                      value: '128',
                      label: 'People Helped',
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    child: ImpactStatCard(
                      icon: Icons.location_on,
                      value: '5',
                      label: 'Countries Reached',
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: ImpactStatCard(
                      icon: Icons.favorite,
                      value: '8',
                      label: 'Campaigns Supported',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Fund Allocation',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Fund allocation chart placeholder
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text('Fund Allocation Chart'),
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Recent Updates',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Project updates list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue[100],
                                child: const Icon(Icons.update,
                                    color: Colors.blue),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Project Update ${index + 1}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      'Organization ${index + 1}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${index + 1}d ago',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            'Update details about how funds are being used and the impact they\'re making in the affected area.',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  // View full report
                                },
                                child: const Text('View Full Report'),
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {
                                  // Share update
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
