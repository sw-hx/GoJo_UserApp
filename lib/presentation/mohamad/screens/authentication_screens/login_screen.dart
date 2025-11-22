import 'package:flutter/material.dart';
import 'package:go_jo_user_application/core/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/authentication_screen_components/login_fileds.dart';
import '../../components/authentication_screen_components/login_text.dart';
import '../../components/button_default.dart';
import '../../components/logo.dart';
import '../../components/text_button_default.dart';

///### coded by Mohammad
class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(alignment: AlignmentDirectional.topStart, child: Logo()),
              SizedBox(height: 50.h),
              LoginText(
                textString: "Sign In",
                fontSize: 40.sp,
                color: DefaultTheme.colorBlackTextFont,
              ),
              LoginText(textString: "Hi, Welcome back !", fontSize: 18.sp),
              SizedBox(height: 50.h),
              LoginFields(
                isPassword: false,
                icon: Icon(size: 30.r, Icons.email_sharp),
                headerText: 'Email  ',
                fontSize: 25.sp,
                hintText: 'Please Enter your Email',
              ),
              LoginFields(
                isPassword: true,
                icon: Icon(size: 30.r, Icons.password_rounded),
                headerText: 'Password  ',
                fontSize: 25.sp,
                hintText: 'Please Enter your Password',
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: TextButtonDefault(
                  text: 'Forget Password',
                  onPressed: forgetPasswordOnPressedButton,
                ),
              ),
              SizedBox(height: 15.h),
              ButtonDefault(text: 'Sign In', onPressed: signInOnPressedButton),
            ],
          ),
        ),
      ),
    );
  }

  void signInOnPressedButton() {}
  void forgetPasswordOnPressedButton() {}
}
