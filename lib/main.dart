import 'package:flutter/material.dart';
import 'package:go_jo_user_application/screens/place_info_screen.dart';
import 'package:go_jo_user_application/views/screens/splash_screen/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
  runApp(
    ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(320, 568),
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//Code By zain
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
// <<<<<<< zain_task1
//     return ScreenUtilInit(
//       designSize: const Size(360, 690),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_ , child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home:PlaceInfoScreen(),
//           );
//       },
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
