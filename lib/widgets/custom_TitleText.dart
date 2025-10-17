import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//codded by zain

Widget customTitleText ({required String title,required int size}){

  return SizedBox(
    height: 50.h,
    child: Text(
      title,
      style: TextStyle(
          color: Color(0xff0B3647),
          fontSize: size.sp,
          fontWeight: FontWeight.bold
      ),
    ),
  );
}