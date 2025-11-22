import 'package:flutter/material.dart';
import 'package:go_jo_user_application/presentation/hala_all/startingUP_screens_H/login_screen_hala/sign_in_screen.dart';
import '../../../common_components/custom_returnArrow.dart';
import 'code_verification_screen.dart';

/// # coded By [Hala]

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

/// # coded By [Hala]

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('GOJO',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3D7C91),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: const CustomReturnArrow(targetPage:LoginScreen(),),
                    ),
                  ],
                ),
            const SizedBox(height: 60),
            const Text(
              "Forgot Your Password?",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3D7C91),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "A verification code will be sent to your email",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,fontSize: 12),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:Color(0xFF3D7C91),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CodeVerificationScreen(),
                  ),
                );
              },
              child: const Text(
                "Send Code",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
        ),
    );
  }
}
