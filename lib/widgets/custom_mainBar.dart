import 'package:flutter/material.dart';
import 'package:go_jo_user_application/screens/place_info_screen.dart';
import 'package:go_jo_user_application/screens/user_favorites_screen.dart';

import '../screens/events_screen.dart';

class BottomNavBar extends StatefulWidget {
  final int? currentIndex;

  const BottomNavBar({super.key, this.currentIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _onItemTapped(int index) {
    if (index == widget.currentIndex) return;

    Widget nextPage;
    switch (index) {
      case 0:
        nextPage = PlaceInfoScreen();
        break;
      case 1:
        nextPage =  FavoritesScreen();
        break;
      case 2:
        nextPage =  EventsScreen();
        break;
      default:
        nextPage =  PlaceInfoScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => nextPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMainPage = widget.currentIndex != null;

    return SafeArea(
      top: false,
      child: BottomNavigationBar(
        backgroundColor: const Color(0xff123645),
        selectedFontSize: 14,
        currentIndex: isMainPage ? widget.currentIndex! : 0,
        onTap: _onItemTapped,
        selectedItemColor: isMainPage ? Colors.white : Colors.white70,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: isMainPage,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: isMainPage && widget.currentIndex == 0
                  ? Colors.white
                  : Colors.white70,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              color: isMainPage && widget.currentIndex == 1
                  ? Colors.white
                  : Colors.white70,
            ),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
              color: isMainPage && widget.currentIndex == 2
                  ? Colors.white
                  : Colors.white70,
            ),
            label: "Events",
          ),
        ],
      ),
    );
  }
}