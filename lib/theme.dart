import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ### Made by [Mohammad]

class DefaultTheme {
  static const Color colorMainBlue = Color(0xff2E7996);
  static const Color colorFieldBlue = Color.fromARGB(85, 142, 196, 212);
  static const Color colorBlackTextFont = Colors.black;
  static const Color colorWhiteTextFont = Colors.white;

  static TextStyle defaultFont({TextStyle? style}) {
    return GoogleFonts.openSans(textStyle: style);
  }
}
