import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/presentation/cubits/place_cubit/get_places_by_parentPlace/get_places_by_parent_place_cubit.dart';
import '../../../domain/repos/favorite_repo.dart';
import '../../../domain/repos/place_repo.dart';
import '../../../services/git_it_service.dart';
import '../../common_components/bottom_nav_bar.dart';
import '../../cubits/favorite_cubit/add_favorite_cubit/add_favorite_cubit.dart';
import '../../cubits/place_cubit/get_topRating_places_cubit/get_top_rating_places_cubit.dart';
import '../home_page.dart';

/// Coded by[Hala]

class BugsThankYouScreen extends StatelessWidget {
  const BugsThankYouScreen({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                children: const [
                  Icon(
                      Icons.support_agent, color: Color.fromRGBO(18, 54, 69, 1),
                      size: 40),
                  SizedBox(width: 10),
                  Text(
                    "Bugs Center",
                    style: TextStyle(
                        color: Color.fromRGBO(18, 54, 69, 1),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Thank you, $name",
                      style: TextStyle(
                        color: Color(0xFF307896),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We will look into it",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) =>
                                  GetPlacesByParentPlaceCubit(
                                    placeRepo: getIt<PlaceRepo>(),
                                  )
                                    ..getPlacesByParentPlace(
                                        'ALL'
                                    ),
                                ),
                                BlocProvider(
                                  create: (context) =>
                                  GetTopRatingPlacesCubit(placeRepo: getIt.get<PlaceRepo>())
                                    ..getTopRatingPlaces(),
                                ),
                                BlocProvider(
                                  create: (_) =>
                                      AddFavoriteCubit(favoriteRepo: getIt.get<FavoriteRepo>()),
                                ),
                              ],
                              child: HomePage(),
                            ),),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF307896),

                    padding:
                    EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text("Back to Home page",
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
