import 'package:flutter/material.dart';
import 'package:go_jo_user_application/mohamad/components/logo.dart';
import 'package:go_jo_user_application/pages/home_page.dart';
import 'signup_screen.dart';
import 'sign_in_screen.dart';

/// # coded By [Hala]

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Logo(
                          logoHight: screenHeight * 0.1,
                          logoWidth: screenWidth * 0.2,
                        ),
                      ),

                      // ✅ حجم النص يتأقلم تلقائياً حسب الشاشة
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: const Text(
                          "Discover",
                          style: TextStyle(
                            fontSize: 88,
                            color: Color(0xFF0B3C49),
                            height: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Let’s get started !",
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF3D7C91),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 25),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3D7C91),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Continue with",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xFF0B3C49),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),

                            _buildWhiteButton(
                              imagePath: "assets/images/google.jpg",
                              text: "Continue with Google",
                            ),
                            const SizedBox(height: 14),

                            _buildWhiteButton(
                              imagePath:
                              "assets/images/2023_Facebook_icon.svg.png",
                              text: "Continue with Facebook",
                            ),
                            const SizedBox(height: 14),

                            _buildWhiteButton(
                              imagePath: "assets/images/apple.png",
                              text: "Continue with iCloud",
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              "or",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
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
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                      ),
                                  ),
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          "Already i have an account",
                          style: TextStyle(
                            color: Color(0xFF3D7C91),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const HomePage()),
                          );
                        },
                        child: const Text(
                          "Skip for now",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWhiteButton({
    required String imagePath,
    required String text,
  }) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
            children: [
              Image.asset(
                imagePath,
                height: 35,
                width: 35,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
            ),
        );
    }
}
