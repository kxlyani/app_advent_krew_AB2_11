// Awareness Screen - Educational content and campaigns
import 'package:flutter/material.dart';

class AwarenessScreen extends StatelessWidget {
  const AwarenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn & Share'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Education & Awareness',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Learn about humanitarian crises and share knowledge',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Featured Content',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Featured content card
              Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image placeholder
                    Container(
                      height: 180.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                      ),
                      child: const Center(
                        child:
                            Icon(Icons.image, size: 48.0, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              'DOCUMENTARY',
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Understanding Climate Disasters: Causes and Responses',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Learn about how climate change is affecting disaster frequency and what humanitarian organizations are doing in response.',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('Watch'),
                                onPressed: () {
                                  // Play video
                                },
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {
                                  // Share content
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.bookmark_border),
                                onPressed: () {
                                  // Save content
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Educational Resources',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Educational content list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  List<String> contentTypes = [
                    'Article',
                    'Video',
                    'Infographic',
                    'Podcast',
                    'Interactive'
                  ];
                  List<String> titles = [
                    'How Humanitarian Aid Works',
                    'Refugee Crisis Explained',
                    'Understanding Disaster Response',
                    'The Role of NGOs in Crisis Situations',
                    'Climate Change and Humanitarian Crises'
                  ];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors
                          .primaries[index % Colors.primaries.length][100],
                      child: Icon(
                        index % 2 == 0 ? Icons.article : Icons.video_library,
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                      ),
                    ),
                    title: Text(titles[index]),
                    subtitle: Text(contentTypes[index]),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    onTap: () {
                      // Navigate to content
                    },
                  );
                },
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Active Campaigns',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Campaign list
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '#StandWithRefugees',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Share your support for refugees by using the hashtag #StandWithRefugees on social media.',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                            onPressed: () {
                              // Share campaign
                            },
                          ),
                          const SizedBox(width: 8.0),
                          TextButton(
                            onPressed: () {
                              // Learn more
                            },
                            child: const Text('Learn More'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '#ClimateAction',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Join the campaign to raise awareness about climate-related disasters.',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                            onPressed: () {
                              // Share campaign
                            },
                          ),
                          const SizedBox(width: 8.0),
                          TextButton(
                            onPressed: () {
                              // Learn more
                            },
                            child: const Text('Learn More'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
