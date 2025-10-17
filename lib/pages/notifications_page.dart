import 'package:flutter/material.dart';
import 'package:go_jo_user_application/widgets/bottom_nav_bar.dart';
import 'home_page.dart';
//coded by suhaib
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 8),
              const Text(
                "Notifications",
                style: TextStyle(
                  color: Color.fromRGBO(18, 54, 69,1),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Your journey starts here",
                style: TextStyle(
                  color: Color.fromRGBO(18, 54, 69,1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: const [
                    ExpandableNotificationCard(
                      companyName: "New Land Company",
                      title: "Hey Zain...",
                      mainText: "your trip will be delayed until 2025/11/11",
                      details:
                      "Due to weather conditions on the scheduled flight date of 11/8, the trip will be postponed to 11/11.",
                    ),
                    SizedBox(height: 16),
                    ExpandableNotificationCard(
                      companyName: "New Land Company",
                      title: "Hey Zain...",
                      mainText: "your trip confirmed",
                      details:
                      "Your trip to Petra has been confirmed for 11/11/2025.",
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





class ExpandableNotificationCard extends StatefulWidget {
  final String companyName;
  final String title;
  final String mainText;
  final String details;

  const ExpandableNotificationCard({
    super.key,
    required this.companyName,
    required this.title,
    required this.mainText,
    required this.details,
  });

  @override
  State<ExpandableNotificationCard> createState() =>
      _ExpandableNotificationCardState();
}

class _ExpandableNotificationCardState
    extends State<ExpandableNotificationCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Color.fromRGBO(18, 54, 69,1),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم الشركه (النص ال فوق)
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF256D85),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.companyName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(Icons.chat, color: Colors.white70),
                    ],
                  ),
                ),

                // عنوان + المحتوى
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.mainText,
                        style: const TextStyle(color: Colors.white),
                      ),

                      //الانيميشن
                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Divider(color: Colors.white70, thickness: 1),
                            const SizedBox(height: 8),
                            Text(
                              widget.details,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        crossFadeState: _isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ),
        );
    }
}
//coded by suhaib
