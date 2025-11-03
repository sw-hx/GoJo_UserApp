// conflict on suhib
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_jo_user_application/pages/home_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ScreenUtilInit(
//       designSize: const Size(360, 690),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: ( _ , child) {
//         return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home:HomePage()

//         );
//       },
//     ),);
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_jo_user_application/pages/home_page.dart';
import 'package:go_jo_user_application/services/firebase_auth_service.dart';
import 'package:go_jo_user_application/services/git_it_service.dart';
import 'package:go_jo_user_application/services/shared_preferences.dart';
import 'firebase_options.dart';
import 'hala_all/startingUP_screens_H/login_screen_hala/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferencesService.init();
  setup();//get it
  runApp(const GojoApp());
}

class GojoApp extends StatelessWidget {
  const GojoApp({super.key});

  /// # coded By [Hala]

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOJO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}

/// # coded By [Hala]
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 3));
    if(FirebaseAuthService().isLoggedIn()){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
    else{
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
    }
  }

  /// # coded By [Hala]

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

