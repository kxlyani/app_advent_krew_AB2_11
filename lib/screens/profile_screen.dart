// Profile Screen - User profile and settings
import 'package:flutter/material.dart';
import 'package:relieflink/login/loginscreen.dart';
import 'package:relieflink/login/splash_screen.dart';
import 'package:relieflink/models/create_campaign_card.dart';
import 'package:relieflink/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String createEmailShortForm(String email) {
    // Check if the email has enough characters (at least 7)
    if (email.length < 7) {
      throw FormatException('Email should have at least 7 characters');
    }

    // Get the first letter
    String firstLetter = email[0].toUpperCase();

    // Get the letter 6 positions after the first letter
    String secondLetter = email[6].toUpperCase();

    return '$firstLetter$secondLetter'; // Combine the letters
  }

  @override
  Widget build(BuildContext context) {
    String shortform = createEmailShortForm(universalId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.blue,
                child: Text(
                  (universalId != 'Sign Up/ Login to view details')
                      ? shortform
                      : '-',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                (universalId != 'Sign Up/ Login to view details')
                    ? universalId
                    : 'Sign Up/ Login to view details',
                style: TextStyle(
                  fontSize: (universalId != 'Sign Up/ Login to view details')
                      ? 24.0
                      : 16.0,
                  fontWeight: (universalId != 'Sign Up/ Login to view details')
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Visibility(
                visible: universalId == 'Sign Up/ Login to view details',
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const LoginScreen()));
                  },
                  child: const Text('Login/Signup'),
                ),
              ),

              const SizedBox(height: 24.0),
              // Donation stats
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Your Impact',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '\$1,450',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'Total Donated',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '15',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'Donations',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '8',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'Organizations',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // View detailed impact
                        },
                        child: const Text('View Detailed Impact'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Visibility(
                visible: isNGO,
                child: ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Create Campaign'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => CreateCampaignCard(ngoEmail: universalId,),),);
                  
                  },
                ),
              ),
              // Profile sections
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Donation History'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                onTap: () {
                  // Navigate to donation history
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Payment Methods'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                onTap: () {
                  // Navigate to payment methods
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notification Preferences'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                onTap: () {
                  // Navigate to notification preferences
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text('Security & Privacy'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                onTap: () {
                  // Navigate to security and privacy
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help & Support'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                onTap: () {
                  // Navigate to help and support
                },
              ),
              const SizedBox(height: 24.0),
              // Logout button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    bool shouldExit = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Log Out?"),
                        content: const Text(
                            "You will be signed out of the application. Do you really want to log out?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );

                    if (shouldExit == true) {
                      await saveisNGOStatus(false);
      isNGO = false;
                      await saveLoginStatus(false);
                      logStatus = false;
                      await saveIDStatus('Sign Up/ Login to view details');
                      universalId = 'Sign Up/ Login to view details';
                      print('The logstatus is $logStatus');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                        (route) => false,
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Logout'),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
