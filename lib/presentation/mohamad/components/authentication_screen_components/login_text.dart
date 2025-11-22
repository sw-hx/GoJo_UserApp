import 'package:flutter/material.dart';
import 'package:go_jo_user_application/core/theme.dart';
// import 'package:google_fonts/google_fonts.dart';

/// ### Made by [Mohammad]

class LoginText extends StatelessWidget {
  final double fontSize;
  final String textString;
  final Color color;

  const LoginText({
    super.key,
    required this.textString,
    required this.fontSize,
    this.color = DefaultTheme.colorMainBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textString,
      style: DefaultTheme.defaultFont(
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      // style: GoogleFonts.openSans(
      // color: color,
      // fontSize: fontSize,
      // fontWeight: FontWeight.bold,
      // ),
    );
  }
}
