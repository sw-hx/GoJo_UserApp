import 'package:flutter/material.dart';
import 'screens/login_screen_hala/welcome_screen.dart';

void main() {
  runApp(const GojoApp());
}

class GojoApp extends StatelessWidget {
  const GojoApp({super.key});

  /// # coded By [Hala]

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOJO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}

/// # coded By [Hala]
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 3)); // شاشة ترحيب 3 ثوانٍ
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  /// # coded By [Hala]

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'GOJO',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
