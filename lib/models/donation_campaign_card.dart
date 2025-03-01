import 'package:flutter/material.dart';

class DonationCampaignCard extends StatelessWidget {
  final String title;
  final String organization;
  final double target;
  final double raised;
  final String imageUrl;
  final VoidCallback onDonate;

  const DonationCampaignCard({
    super.key,
    required this.title,
    required this.organization,
    required this.target,
    required this.raised,
    required this.imageUrl,
    required this.onDonate,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = raised / target;

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            height: 160.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 48.0, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'By $organization',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 12.0),
                // Progress bar
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress < 0.3
                        ? Colors.red
                        : progress < 0.7
                            ? Colors.orange
                            : Colors.green,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${raised.toStringAsFixed(0)} raised',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Goal: \$${target.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onDonate,
                    child: const Text('Donate Now'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}