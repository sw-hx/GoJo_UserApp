import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_jo_user_application/presentation/hala_all/startingUP_screens_H/splah_screen_hala/splash_scrren.dart';
import 'package:go_jo_user_application/presentation/mohamad/screens/splash_screen/splash_screen.dart';
import 'package:go_jo_user_application/presentation/pages/SplashScreen.dart';
import 'firebase_options.dart';
import 'services/git_it_service.dart';
import 'services/shared_preferences.dart';
import 'services/supabase_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPreferencesService.init();

  setup();

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
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
