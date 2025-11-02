import 'package:flutter/material.dart';
import 'package:go_jo_user_application/pages/home_page.dart';
import '../../common_components/bottom_nav_bar.dart';

/// Coded by[Hala]

class BugsThankYouScreen extends StatelessWidget {
  const BugsThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height:40),
              Row(
                children: const [
                  Icon(Icons.support_agent,color: Color.fromRGBO(18, 54, 69, 1),
                  size:40 ),
                  SizedBox(width: 10),
                  Text(
                    "Bugs Center",
                    style: TextStyle(
                        color: Color.fromRGBO(18, 54, 69, 1),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: const [
                    Text(
                      "Thank you, Suhsib",
                      style: TextStyle(
                        color:  Color(0xFF307896),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We will look into it",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),),
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF307896),

                  padding:
                    EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text("Back to Home page",
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize:20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
