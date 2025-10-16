import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';

/// # coded By [Hala]

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              "GOJO",
              style: TextStyle(fontSize: 28, color: Colors.blueAccent),
            ),
            const SizedBox(height: 30),
            const Text(
              "Discover",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Text(
              "Let’s get started!",
              style: TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),
            const SizedBox(height: 50),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    "Continue with",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  _buildWhiteButton("Continue with Google"),
                  const SizedBox(height: 10),
                  _buildWhiteButton("Continue with Facebook"),
                  const SizedBox(height: 10),
                  _buildWhiteButton("Continue with iCloud"),
                  const SizedBox(height: 15),
                  const Text("or", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      );
                    },
                    child: const Text(
                      "Create GOJO account",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text(
                  "Already I have an account",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhiteButton(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
        ),
      ),
    );
  }
}
