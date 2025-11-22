import 'package:flutter/material.dart';

class MapSection extends StatelessWidget {
  const MapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Image.asset('assets/images/map_image.png', fit: BoxFit.cover, height: 100),
    const Text("See on map", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
    ],
    );
    }
}