import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_jo_user_application/services/secure_storage_service.dart';
import 'package:go_jo_user_application/services/supabase_storage.dart';

import 'core/helpers/getUser.dart';
import 'data/models/user_model.dart';
import 'domain/repos/favorite_repo.dart';
import 'domain/repos/place_repo.dart';
import 'firebase_options.dart';
import 'presentation/cubits/favorite_cubit/add_favorite_cubit/add_favorite_cubit.dart';
import 'presentation/cubits/place_cubit/get_places_by_parentPlace/get_places_by_parent_place_cubit.dart';
import 'presentation/cubits/place_cubit/get_topRating_places_cubit/get_top_rating_places_cubit.dart';
import 'presentation/hala_all/startingUP_screens_H/login_screen_hala/welcome_screen.dart';
import 'presentation/pages/home_page.dart';
import 'services/git_it_service.dart';
import 'services/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPreferencesService.init();
  setup(); // get_it
  await SupabaseStorage.initSupabaseStorage();
  await SupabaseStorage.ensureBucket(Buckets.userProfilePhotos);
  await SupabaseStorage.ensureBucket(Buckets.ticketPhotos);

  runApp(const GojoApp());
}

class GojoApp extends StatelessWidget {
  const GojoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // baseline (iPhone X)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'GOJO',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blueAccent,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: false,
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}

/// ================= SPLASH =================
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

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final String? token=await getSavedToken();

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
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'GOJO',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
