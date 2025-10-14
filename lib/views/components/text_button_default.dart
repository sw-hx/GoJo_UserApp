import 'package:flutter/material.dart';
import 'package:go_jo_company_ui/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ### Coded by Mohammad
class TextButtonDefault extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;

  const TextButtonDefault({
    required this.text,
    required this.onPressed,
    this.textColor = DefaultTheme.colorMainBlue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: DefaultTheme.defaultFont(
          style: TextStyle(
            color: textColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
