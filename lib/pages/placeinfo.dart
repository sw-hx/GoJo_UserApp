import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class PlaceInfo extends StatelessWidget {
  final String placeName;

  const PlaceInfo({super.key, required this.placeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(placeName),
          backgroundColor: Colors.teal,
        ),
        body: const Center(
            child: Text(
              ' Place Info ',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            ),
      bottomNavigationBar: BottomNavBar(),
        );
    }
}
