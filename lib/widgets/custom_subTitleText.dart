import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//codded by zain

Widget customTitleText ({required String title}){

  return Text(
    '$title',
    style: TextStyle(
        color: Color(0xff0B3647),
        fontSize: 22.sp,
        fontWeight: FontWeight.bold
    ),
  );
}