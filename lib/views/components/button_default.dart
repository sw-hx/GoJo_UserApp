import 'package:flutter/material.dart';
import 'package:go_jo_company_ui/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ### Coded by Mohammad
class ButtonDefault extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;
  final double borderRadius;

  ButtonDefault({
    required this.text,
    required this.onPressed,
    this.backgroundColor = DefaultTheme.colorMainBlue,
    this.textColor = DefaultTheme.colorWhiteTextFont,
    double? width,
    double? height,
    double? borderRadius,
    super.key,
  }) : width = width ?? 200.w,
       height = height ?? 40.h,
       borderRadius = borderRadius ?? 30.r;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: DefaultTheme.defaultFont(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: DefaultTheme.colorWhiteTextFont,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
