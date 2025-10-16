import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customUserFavCard(){

  return Padding(
    padding:  EdgeInsets.symmetric(vertical: 12),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/petra.jpg',
            height: 100.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              'Petra',
              style:  TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 45.sp,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 2,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.white,size: 30.sp,),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    ),
  );
}