import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customWeatherDayInfo(){


  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.h),
    padding: EdgeInsets.all(12.sp),
    width: 70.w,
    decoration: BoxDecoration(
        color: Color(0xff2F7898),
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(2, 3),
          ),
        ]
    ),
    child: Column(
      children: [
        Text(
          '29°c',
          style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white
          ),
        ),
        Icon(
          Icons.sunny,
          color: Colors.yellow,
          size: 40.sp,
        ),
        Text(
          'Sun',
          style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white
          ),
        ),


      ],
    ),
  );
}