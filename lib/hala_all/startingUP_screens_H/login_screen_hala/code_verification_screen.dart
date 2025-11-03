import 'package:flutter/material.dart';
import 'package:go_jo_user_application/hala_all/startingUP_screens_H/login_screen_hala/sign_in_screen.dart';
import '../../../common_components/custom_returnArrow.dart';
import 'new_password_screen.dart';

/// # coded By [Hala]

class CodeVerificationScreen extends StatefulWidget {
  const CodeVerificationScreen({super.key});

  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

/// # coded By [Hala]

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  final codeController = TextEditingController();

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
            const SizedBox(height: 40),
            const Text(
              "Enter Verification Code",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                  color: Color(0xFF3D7C91),
              ),
            ),
            const Text(
              "We’ve sent a code to your email. Enter it below to continue.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Verification Code",
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
                backgroundColor: Color(0xFF3D7C91),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
                );
              },
              child: const Text(
                "Verify",
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
