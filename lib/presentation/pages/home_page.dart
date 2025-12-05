import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_jo_user_application/core/helpers/getUser.dart';
import 'package:go_jo_user_application/presentation/common_components/bottom_nav_bar.dart';
import 'package:go_jo_user_application/presentation/components/components_HomePage/places_Card.dart';
import 'package:go_jo_user_application/presentation/components/components_HomePage/popularPlace_Card.dart';
import 'package:go_jo_user_application/presentation/components/components_HomePage/selector_places.dart';
import 'package:go_jo_user_application/presentation/cubits/place_cubit/get_places_by_parentPlace/get_places_by_parent_place_cubit.dart';
import 'package:go_jo_user_application/presentation/effects/skeleton_place_card.dart';
import 'package:go_jo_user_application/presentation/pages/search_page.dart';
import '../../domain/repos/search_repo.dart';
import '../../services/git_it_service.dart';
import '../cubits/place_cubit/get_topRating_places_cubit/get_top_rating_places_cubit.dart';
import '../cubits/search_cubit/search_cubit.dart';
import '../effects/skeleton_popular_card.dart';
import 'notifications_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final bool showBookingConfirmation;
  const HomePage({Key? key, this.showBookingConfirmation = false}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> places = [];
  bool placesExist = true;
  List<dynamic> topRatedPlaces = [];
  bool isLoadingPlaces = true;
  bool isTopRatedLoading = true;


  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetPlacesByParentPlaceCubit, GetPlacesByParentPlaceState>(
          listener: (context, state) {
            if (state is GetPlacesByParentPlaceLoading) {
              isLoadingPlaces = true;
              setState(() {});
            }

            if (state is GetPlacesByParentPlaceSuccess) {
              places = state.places;
              placesExist = true;
              isLoadingPlaces = false;
              setState(() {});
            }

            if (state is GetPlacesByParentPlaceFailure) {
              if (state.message.contains('no places')) {
                places = [];
                placesExist = false;
                isLoadingPlaces = false;
                setState(() {});
              }
            }
          },
        ),

        BlocListener<GetTopRatingPlacesCubit, GetTopRatingPlacesState>(
          listener: (context, state) {
            if (state is GetTopRatingPlacesLoading) {
              isTopRatedLoading = true;
              setState(() {});
            }

            if (state is GetTopRatingPlacesSuccess) {
              topRatedPlaces = state.places;
              isTopRatedLoading = false;
              setState(() {});
            }

            if (state is GetTopRatingPlacesFailure) {
              isTopRatedLoading = false;
              setState(() {});
            }
          },
        ),

      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const ProfilePage()),
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Text(getUserData().personFullName[0].toUpperCase()),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              getUserData().personFullName,
                              style: const TextStyle(
                                color: Color.fromRGBO(18, 54, 69, 1),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications,
                                color: Color.fromRGBO(18, 54, 69, 1), size: 40),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => NotificationsPage()),
                              );
                            },
                          ),
                          Positioned(
                            right: 3,
                            top: 10,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.red, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Text(
                  'Discover',
                  style: TextStyle(
                    color: Color.fromRGBO(18, 54, 69, 1),
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Your journey starts here', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 25),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => SearchCubit(repo: getIt.get<SearchRepo>()),
                          child: const SearchPage(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(0, 6),
                        ),
                      ],
                      color: Color.fromRGBO(18, 54, 69, 1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 3),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Where to go ....',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          width: 39,
                          height: 39,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(58, 186, 242, 1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Color.fromRGBO(18, 54, 69, 1),
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                const PlacesSelector(),
                const SizedBox(height: 25),

                isLoadingPlaces
                    ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SkeletonPlaceCard(),
                          SkeletonPlaceCard(),
                          SkeletonPlaceCard()
                        ],
                      ),
                    )
                    : placesExist
                    ? PlaceCardsList(places: places)
                    : Container(
                  width: double.infinity,
                  height: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF23627E).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFF23627E), width: 1.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_off,
                          size: 60, color: Color(0xFF23627E)),
                      SizedBox(height: 15),
                      Text(
                        'No destinations available',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF11324D),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Try choosing another area',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Highest Rating',
                  style: TextStyle(
                    color: Color.fromRGBO(18, 54, 69, 1),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                isTopRatedLoading
                    ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                                        children: const [
                      SkeletonPopularCard(),
                      SkeletonPopularCard(),
                      SkeletonPopularCard(),
                                        ],
                                      ),
                    )
                    : PopularCard(places: topRatedPlaces),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),

        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }
}
