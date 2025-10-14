import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_jo_company_ui/theme.dart';
import 'package:go_jo_company_ui/views/components/authentication_screen_components/login_text.dart';

/// ### Made by [Mohammad]
class LoginFields extends StatelessWidget {
  final double fontSize;
  final String headerText;
  final String hintText;
  final Color color;
  final Icon icon;
  final bool isPassword;

  const LoginFields({
    required this.headerText,
    required this.hintText,
    required this.fontSize,
    required this.icon,
    required this.isPassword,
    this.color = DefaultTheme.colorMainBlue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              LoginText(
                fontSize: fontSize,
                textString: headerText,
                color: color,
              ),
              icon,
            ],
          ),
          SizedBox(height: 5.h),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(90.r)),
              ),
              alignLabelWithHint: true,
              filled: true,
              fillColor: DefaultTheme.colorFieldBlue,
              hintText: hintText,
              hintStyle: DefaultTheme.defaultFont(
                style: TextStyle(fontSize: 13.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
