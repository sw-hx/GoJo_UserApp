import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Events")),
        body: const Center(
          child: Text("Events Page (Empty for now)"),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 2),
        );
    }
}