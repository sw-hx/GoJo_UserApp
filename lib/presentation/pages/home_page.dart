import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_jo_user_application/core/helpers/getUser.dart';
import 'package:go_jo_user_application/domain/repos/profile_repo.dart';
import 'package:go_jo_user_application/presentation/common_components/bottom_nav_bar.dart';
import 'package:go_jo_user_application/presentation/components/components_HomePage/places_Card.dart';
import 'package:go_jo_user_application/presentation/components/components_HomePage/popularPlace_Card.dart';
import 'package:go_jo_user_application/presentation/components/components_HomePage/selector_places.dart';
import 'package:go_jo_user_application/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:go_jo_user_application/presentation/cubits/place_cubit/get_places_by_parentPlace/get_places_by_parent_place_cubit.dart';
import 'package:go_jo_user_application/presentation/effects/skeleton_place_card.dart';
import 'package:go_jo_user_application/presentation/pages/search_page.dart';

import '../../core/helpers/stretch_scroll_behavior.dart';
import '../../domain/repos/search_repo.dart';
import '../../services/git_it_service.dart';
import '../../services/storage_service.dart';
import '../cubits/place_cubit/get_topRating_places_cubit/get_top_rating_places_cubit.dart';
import '../cubits/search_cubit/search_cubit.dart';
import '../effects/skeleton_popular_card.dart';
import 'notifications_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final bool showBookingConfirmation;
  const HomePage({super.key, this.showBookingConfirmation = false});

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
            } else if (state is GetPlacesByParentPlaceSuccess) {
              places = state.places;
              placesExist = true;
              isLoadingPlaces = false;
              setState(() {});
            } else if (state is GetPlacesByParentPlaceFailure) {
              places = [];
              placesExist = false;
              isLoadingPlaces = false;
              setState(() {});
            }
          },
        ),
        BlocListener<GetTopRatingPlacesCubit, GetTopRatingPlacesState>(
          listener: (context, state) {
            if (state is GetTopRatingPlacesLoading) {
              isTopRatedLoading = true;
              setState(() {});
            } else if (state is GetTopRatingPlacesSuccess) {
              topRatedPlaces = state.places;
              isTopRatedLoading = false;
              setState(() {});
            } else if (state is GetTopRatingPlacesFailure) {
              isTopRatedLoading = false;
              setState(() {});
            }
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: StretchScrollBehavior(),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================= HEADER =================
                  SizedBox(
                    height: 80.h,
                    child: Row(
                      children: [
                        GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) => EditProfileCubit(
                                        profileRepo: getIt.get<ProfileRepo>(),
                                        storageService: getIt
                                            .get<StorageService>(),
                                      ),
                                      child: ProfilePage(),
                                    ),
                                  ),
                                );
                                if (result == true) setState(() {});
                              },
                              child: FutureBuilder(
                                future: getUserData(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircleAvatar(
                                      radius: 24.r,
                                      child: const Icon(Icons.person),
                                    );
                                  }
                                  final user = snapshot.data!;
                                  return Row(
                                    children: [
                                      user.profilePhoto != null
                                          ? CircleAvatar(
                                              radius: 24.r,
                                              backgroundImage:
                                                  user.profilePhoto != null
                                                  ? (user.profilePhoto!
                                                            .startsWith('http')
                                                        ? NetworkImage(
                                                            user.profilePhoto!,
                                                          )
                                                        : FileImage(
                                                            File(
                                                              user.profilePhoto!,
                                                            ),
                                                          ))
                                                  : null,
                                            )
                                          : CircleAvatar(
                                              radius: 24.r,
                                              child: Center(
                                                child: Text(
                                                  user.personFullName[0],
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        user.personFullName,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: const Color.fromRGBO(
                                            18,
                                            54,
                                            69,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 400.ms)
                            .scale(
                              begin: const Offset(0.8, 0.8),
                              curve: Curves.easeOutBack,
                            ),

                        const Spacer(),

                        IconButton(
                              icon: Icon(
                                Icons.notifications,
                                size: 38.sp,
                                color: const Color.fromRGBO(18, 54, 69, 1),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => NotificationsPage(),
                                  ),
                                );
                              },
                            )
                            .animate(onPlay: (c) => c.repeat())
                            .scaleXY(begin: 1, end: 1.1, duration: 1200.ms)
                            .then()
                            .scaleXY(begin: 1.1, end: 1),
                      ],
                    ),
                  ),

                  /// ================= TITLES =================
                  Text(
                    'Discover',
                    style: TextStyle(
                      fontSize: 46.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(18, 54, 69, 1),
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),

                  Text(
                    'Your journey starts here',
                    style: TextStyle(fontSize: 20.sp),
                  ).animate().fadeIn(delay: 200.ms),

                  SizedBox(height: 25.h),

                  /// ================= SEARCH =================
                  Hero(
                    tag: 'search_bar',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) =>
                                  SearchCubit(repo: getIt.get<SearchRepo>()),
                              child: const SearchPage(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 45.h,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(18, 54, 69, 1),
                          borderRadius: BorderRadius.circular(40.r),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10,
                              offset: Offset(0, 6),
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Where to go ....',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: const Color.fromRGBO(
                                58,
                                186,
                                242,
                                1,
                              ),
                              child: Icon(
                                Icons.search,
                                size: 24.sp,
                                color: const Color.fromRGBO(18, 54, 69, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),

                  SizedBox(height: 25.h),

                  /// ================= SELECTOR =================
                  const PlacesSelector()
                      .animate()
                      .fadeIn(delay: 400.ms)
                      .slideX(begin: 0.3),

                  SizedBox(height: 25.h),

                  /// ================= PLACES =================
                  isLoadingPlaces
                      ? SizedBox(
                          height: 250.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            separatorBuilder: (_, __) => SizedBox(width: 12.w),
                            itemBuilder: (_, __) => const SkeletonPlaceCard(),
                          ),
                        )
                      : placesExist
                      ? PlaceCardsList(places: places)
                            .animate()
                            .fadeIn(duration: 500.ms)
                            .slideX(begin: 0.2)
                            .scale(begin: const Offset(0.95, 0.95))
                      : Container(
                              width: double.infinity,
                              height: 235.h,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              margin: EdgeInsets.only(bottom: 15.h),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF23627E,
                                ).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: const Color(0xFF23627E),
                                  width: 1.5.w,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_off,
                                    size: 60.sp,
                                    color: const Color(0xFF23627E),
                                  ),
                                  SizedBox(height: 15.h),
                                  Text(
                                    'No destinations available',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF11324D),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Try choosing another area',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 500.ms)
                            .scale(begin: const Offset(0.9, 0.9)),

                  SizedBox(height: 20.h),

                  /// ================= TOP RATED =================
                  Text(
                    'Highest Rating',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(18, 54, 69, 1),
                    ),
                  ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2),

                  SizedBox(height: 10.h),

                  isTopRatedLoading
                      ? SizedBox(
                          height: 250.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            separatorBuilder: (_, __) => SizedBox(width: 12.w),
                            itemBuilder: (_, __) => const SkeletonPlaceCard(),
                          ),
                        )
                      : PopularCard(
                          places: topRatedPlaces,
                        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),

                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }
}
