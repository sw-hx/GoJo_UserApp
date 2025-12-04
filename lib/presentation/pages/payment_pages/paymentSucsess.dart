import 'package:flutter/material.dart';
import '../../common_components/custom_returnArrow.dart';
import '../home_page.dart';

/// Coded By [Hala]
class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
              children: [
                // السهم في الزاوية العلوية اليسار
                const Positioned(
                  top: 10,
                  left: 10,
                  child: CustomReturnArrow(targetPage: HomePage()),
                ),

                // المحتوى الرئيسي
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Spacer(),
                      const Text(
                        "Thank you, Suhaib",
                        style: TextStyle(
                          color: Color(0xFF256D85),
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Your Trip has been booked successfully",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF083F4F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF256D85),
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage(showBookingConfirmation: true),
                                  ),
                              );
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
            ),
        );
    }
}
