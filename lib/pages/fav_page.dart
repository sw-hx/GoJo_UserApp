import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Favorites")),
        body: const Center(
          child: Text("Favorites Page (Empty for now)"),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
        );
    }
}