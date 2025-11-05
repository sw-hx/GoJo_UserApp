import 'package:flutter/material.dart';
import 'package:go_jo_user_application/common_components/bottom_nav_bar.dart';
import '../domain/models/user_model.dart';
import '../hala_all/startingUP_screens_H/login_screen_hala/welcome_screen.dart';
import '../common_components/custom_returnArrow.dart';
import '../helpers/getUser.dart';
import 'Bugs_pages/bugs_page.dart';
import 'home_page.dart';

/// coded by [suhaib]


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool allowNotifications = false;
  UserModel user=getUserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: const CustomReturnArrow(targetPage: HomePage()),
                ),
                const SizedBox(height: 10),

                CircleAvatar(
                  radius: 80,
                  child: Text(user.name[0].toUpperCase(),style: TextStyle(fontSize: 50),),
                ),
                const SizedBox(height: 15),

                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(18, 54, 69, 1),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {},
                  child:
                  const Text("Edit profile", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: const Border.fromBorderSide(
                      BorderSide(width: .5),
                    ),
                    color: const Color(0xFFF6F6F6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name", style: TextStyle(color: Colors.black54)),
                      const SizedBox(height: 5),
                      Text(
                        user.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Divider(height: 25),
                      const Text("Email", style: TextStyle(color: Colors.black54)),
                      const SizedBox(height: 5),
                      Text(
                        user.email,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Preferences",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    border: const Border.fromBorderSide(
                      BorderSide(width: .5),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.notifications_none_rounded,
                          color: Color.fromRGBO(18, 54, 69, 1),
                          size: 30,
                        ),
                        title: const Text(
                          "Allow notifications",
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Switch(
                          activeThumbColor:
                          const Color.fromRGBO(28, 176, 5, 1.0),
                          value: allowNotifications,
                          onChanged: (val) {
                            setState(() => allowNotifications = val);
                          },
                        ),
                      ),
                      const Divider(height: 1),

                      // Bugs Center
                      ListTile(
                        leading: const Icon(
                          Icons.support_agent_rounded,
                          color: Colors.black87,
                          size: 30,
                        ),
                        title: const Text(
                          "Bugs center",
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BugsReportScreen()),
                          );
                        },
                      ),

                      const Divider(height: 1),

                      // Logout
                      ListTile(
                        leading: const Icon(
                          Icons.logout_rounded,
                          color: Colors.red,
                          size: 30,
                        ),
                        title: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WelcomeScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
        );
    }
}
