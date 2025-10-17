import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ### Made by [Mohammad]

class Logo extends StatelessWidget {
  final double logoWidth;
  final double logoHight;

  Logo({super.key, double? logoWidth, double? logoHight})
    : logoWidth = logoWidth ?? 70.w,
      logoHight = logoHight ?? 70.h;

  @override
  Widget build(BuildContext context) {
    return Image(
      width: logoWidth,
      height: logoHight,
      image: AssetImage('assets/images/logo/go_jo_logo.png'),
    );
  }
}
