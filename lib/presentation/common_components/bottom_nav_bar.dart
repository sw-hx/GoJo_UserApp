import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/presentation/cubits/place_cubit/get_places_by_parentPlace/get_places_by_parent_place_cubit.dart';

import '../../domain/repos/favorite_repo.dart';
import '../../domain/repos/place_repo.dart';
import '../../services/git_it_service.dart';

import '../cubits/favorite_cubit/add_favorite_cubit/add_favorite_cubit.dart';
import '../cubits/place_cubit/get_topRating_places_cubit/get_top_rating_places_cubit.dart';

import '../pages/bookedtrips_page.dart';
import '../pages/events_screen.dart';
import '../pages/favorites_screen.dart';
import '../pages/home_page.dart';

/// coded by [suhaib]

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
        nextPage = MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetPlacesByParentPlaceCubit(
                placeRepo: getIt.get<PlaceRepo>(),
              )..getPlacesByParentPlace('ALL'),
            ),
            BlocProvider(
              create: (context) => GetTopRatingPlacesCubit(
                placeRepo: getIt.get<PlaceRepo>(),
              )..getTopRatingPlaces(),
            ),
            BlocProvider(
              create: (_) => AddFavoriteCubit(
                favoriteRepo: getIt.get<FavoriteRepo>(),
              ),
            ),
          ],
          child: const HomePage(),
        );
        break;

      case 1:
        nextPage = const FavoritesPage();
        break;

      case 2:
        nextPage =  EventsPage();
        break;

      case 3:
        nextPage = const BookedTripsPage();
        break;

      default:
        nextPage = const HomePage();
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
        type: BottomNavigationBarType.fixed,
        currentIndex: isMainPage ? widget.currentIndex! : 0,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 14,
        showSelectedLabels: isMainPage,
        showUnselectedLabels: false,
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.confirmation_number_outlined,
              color: isMainPage && widget.currentIndex == 3
                  ? Colors.white
                  : Colors.white70,
            ),
            label: "Booked",
          ),
        ],
      ),
    );
  }
}
