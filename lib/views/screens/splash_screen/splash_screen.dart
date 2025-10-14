import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_jo_company_ui/theme.dart';
import 'package:go_jo_company_ui/views/screens/authentication_screens/login_screen.dart';

///## Coded by mohammad
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultTheme.colorMainBlue,
      body: Center(
        child: Image.asset(
          'assets/gif/gojo.gif',
          width: 200.w,
          height: 200.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
