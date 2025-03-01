import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:relieflink/admin/adminpage.dart';
import 'package:relieflink/login/loginscreen.dart';
import 'package:relieflink/models/database_functions.dart';
import 'package:relieflink/screens/home_page.dart';
import 'package:relieflink/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadAdminStatus();
  await loadLoginStatus();
  await loadIDStatus();

  DisasterDataFetcher().fetchAndStoreDisasters();
  
  runApp(const CrisisAssistApp());
}

class CrisisAssistApp extends StatelessWidget {
  const CrisisAssistApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      title: 'Crisis Assist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2D7DD2),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D7DD2),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF2D7DD2),
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 24.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
      home: setInitialScreen(),
    );
  }
}

Widget setInitialScreen() {
  print("Login Status: $logStatus");
  print("Admin Status: $adminLog");

  if (adminLog) {
    return AdminPage(adminType: universalId,);
  }
  return logStatus ? const HomePage() : const LoginScreen();
}
