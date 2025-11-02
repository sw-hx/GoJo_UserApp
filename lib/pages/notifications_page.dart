import 'package:flutter/material.dart';
import '../common_components/bottom_nav_bar.dart';
import '../common_components/custom_returnArrow.dart';
import '../components/components_notif/extandable_notif.dart';
import '../components/components_notif/model_notif.dart';
import 'home_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationModel> notifications = [
    const NotificationModel(
      companyName: "New Land Company",
      title: "Hey Zain...",
      mainText: "Your trip will be delayed until 2025/11/11 due to weather conditions.",
      details:
      "Due to weather conditions on the scheduled flight date of 11/8, the trip will be postponed to 11/11. Please contact us if you need to reschedule or have any questions.",
    ),
    const NotificationModel(
      companyName: "New Land Company",
      title: "Hey Zain...",
      mainText: "Your trip confirmed",
      details: "Your trip to Petra has been confirmed for 11/11/2025. We look forward to seeing you!",
    ),
    const NotificationModel(
      companyName: "Travel World",
      title: "Special Offer!",
      mainText: "Discounts on your next booking available now.",
      details:
      "Enjoy 25% off your next destination booked before 12/12. Don’t miss this amazing opportunity to explore more!",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomReturnArrow(targetPage: HomePage()),
                const SizedBox(height: 20),
                const Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF11324D),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Your journey starts here",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF11324D),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemCount: notifications.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final n = notifications[index];
                      return Dismissible(
                        key: ValueKey(n.title + n.mainText),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        onDismissed: (_) {
                          setState(() {
                            notifications.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Notification deleted'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  setState(() {
                                    notifications.insert(index, n);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: ExpandableNotificationCard(notification: n),
                      );
                    },
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
