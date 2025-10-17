import 'package:flutter/material.dart';
import 'package:go_jo_user_application/widgets/bottom_nav_bar.dart';
import 'home_page.dart';
//coded by suhaib

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool allowNotifications = false;

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
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.keyboard_double_arrow_left_outlined, size: 60, color: Colors.black87),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        },
                  ),
                  ),
                  const SizedBox(height: 10),

                  // profile image
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                      "https://cdn.racingnews365.com/2025/Hamilton/_1092x683_crop_center-center_85_none/XPB_1358753_HiRes.jpg?v=1752766813",
                    ),
                  ),
                  const SizedBox(height: 15),

                  // name + email
                  const Text(
                    "Suhaib Samaneh",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(18, 54, 69,1),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "suhaib@gmail.com",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // edit profile button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Edit profile", style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 25),

                  // info card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: const Border.fromBorderSide(BorderSide(width: .5),),
                      color: const Color(0xFFF6F6F6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Name", style: TextStyle(color: Colors.black54)),
                        SizedBox(height: 5),
                        Text(
                          "Suhaib Samaneh",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Divider(height: 25),
                        Text("Email", style: TextStyle(color: Colors.black54)),
                        SizedBox(height: 5),
                        Text(
                          "suhaib@gmail.com",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // preferences card
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
                      border: const Border.fromBorderSide(BorderSide(width: .5),),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.notifications_none_rounded, color: Color.fromRGBO(18, 54, 69,1),size: 30,),
                          title: const Text("Allow notifications", style: TextStyle(fontSize: 16),),
                          trailing: Switch(activeColor: const Color.fromRGBO(28, 176, 5, 1.0),
                            value: allowNotifications,
                            onChanged: (val) {
                              setState(() => allowNotifications = val);
                            },
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.support_agent_rounded, color: Colors.black87,size: 30,),
                          title: const Text("Bugs center",style: TextStyle(fontSize: 16),),
                          onTap: () {},
                        ),
                        const Divider(height: 1,),
                        ListTile(
                          leading: const Icon(Icons.logout_rounded, color: Colors.red,size: 30,),
                          title: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
      bottomNavigationBar: BottomNavBar(),
        );
    }
}
//coded by suhaib
