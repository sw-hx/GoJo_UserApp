import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:go_jo_user_application/presentation/cubits/place_cubit/get_places_by_parentPlace/get_places_by_parent_place_cubit.dart';
import '../../../domain/repos/favorite_repo.dart';
import '../../../domain/repos/place_repo.dart';
import '../../../services/git_it_service.dart';
import '../../common_components/bottom_nav_bar.dart';
import '../../cubits/favorite_cubit/add_favorite_cubit/add_favorite_cubit.dart';
import '../../cubits/place_cubit/get_topRating_places_cubit/get_top_rating_places_cubit.dart';
import '../home_page.dart';

/// Coded by [Hala] – Enhanced by GOJO ✨

class BugsThankYouScreen extends StatelessWidget {
  const BugsThankYouScreen({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ================= HEADER =================
              Row(
                children: [
                  Icon(
                    Icons.support_agent,
                    color: const Color.fromRGBO(18, 54, 69, 1),
                    size: 40.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Bugs Center",
                    style: TextStyle(
                      color: const Color.fromRGBO(18, 54, 69, 1),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.2),

              const Spacer(),

              /// ================= THANK YOU CARD =================
              Center(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 30.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      /// ICON
                      Container(
                        padding: EdgeInsets.all(18.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF307896).withOpacity(0.12),
                        ),
                        child: Icon(
                          Icons.check_circle_outline,
                          color: const Color(0xFF307896),
                          size: 60.sp,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// TEXTS
                      Text(
                        "Thank you, $name 👋",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF307896),
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Text(
                        "We received your report\nand will look into it shortly.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.3)
                  .scale(begin: const Offset(0.95, 0.95)),

              const Spacer(),

              /// ================= BUTTON =================
              Center(
                child: SizedBox(
                  width: 0.8.sw,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (_) =>
                                GetPlacesByParentPlaceCubit(
                                  placeRepo: getIt<PlaceRepo>(),
                                )..getPlacesByParentPlace('ALL'),
                              ),
                              BlocProvider(
                                create: (_) =>
                                GetTopRatingPlacesCubit(
                                  placeRepo: getIt<PlaceRepo>(),
                                )..getTopRatingPlaces(),
                              ),
                              BlocProvider(
                                create: (_) =>
                                    AddFavoriteCubit(
                                      favoriteRepo:
                                      getIt<FavoriteRepo>(),
                                    ),
                              ),
                            ],
                            child: const HomePage(),
                          ),
                        ),
                            (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF307896),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50.r),
                      ),
                      elevation: 6,
                    ),
                    child: Text(
                      "Back to Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 400.ms)
                  .slideY(begin: 0.3),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
