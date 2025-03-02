import 'package:flutter/material.dart';
import 'package:relieflink/screens/razorpay_screen.dart';

class DonationDetails extends StatelessWidget {
  const DonationDetails({
    super.key,
    required this.title,
    required this.organization,
    required this.target,
    required this.raised,
    required this.imageUrl,
  });

  final String title;
  final String organization;
  final double target;
  final double raised;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final double progress = raised / target;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image display (Using NetworkImage if a URL is provided)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imageUrl,
                height: 250.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            // Title and Organization
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'By $organization',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
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
            const SizedBox(height: 12.0),
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
            const SizedBox(height: 24.0),
            // Donate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement donation logic or navigation to donation page
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Donate'),
                      content: const Text('Do you want to donate now?'),
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
                                builder: (ctx) => CampaignDonationPage(campaignId: title,),
                              ),
                            );
                          },
                          child: const Text('Donate'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Donate Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green, // Background color of the button
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
