import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme.dart';
import '../../domain/repos/favorite_repo.dart';
import '../../domain/repos/place_repo.dart';
import '../../presentation/cubits/favorite_cubit/add_favorite_cubit/add_favorite_cubit.dart';
import '../../presentation/cubits/place_cubit/get_places_by_parentPlace/get_places_by_parent_place_cubit.dart';
import '../../presentation/cubits/place_cubit/get_topRating_places_cubit/get_top_rating_places_cubit.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/hala_all/startingUP_screens_H/login_screen_hala/welcome_screen.dart';
import '../../services/git_it_service.dart';
import '../../services/secure_storage_service.dart';

/// ### Made by [suhaib]

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() {
    Timer(const Duration(milliseconds: 3800), () async {
      final String? token = await getSavedToken();

      if (!mounted) return;

      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => GetPlacesByParentPlaceCubit(
                    placeRepo: getIt.get<PlaceRepo>(),
                  )..getPlacesByParentPlace('ALL'),
                ),
                BlocProvider(
                  create: (_) => GetTopRatingPlacesCubit(
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
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const WelcomeScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultTheme.colorWhite,
      body: Center(
        child: Image.asset(
          'assets/gif/ezgif-88c760f9e451773f.gif',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
