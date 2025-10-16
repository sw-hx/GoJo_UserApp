import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customEventsCard(){

  return Card(
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    clipBehavior: Clip.hardEdge,
    child: Stack(
      children: [
        Image.asset(
          'assets/images/petra.jpg',
          height: 300.h,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 120.w,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10.r)
            ),
            child: Text(
              "Children's Museum",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.black45, // أسود شفاف (بدون withOpacity)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "7:30 pm",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "11/11",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "There will be an event at the Children's Museum where a group of content creators will attend and do beautiful and wonderful activities.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),

      ],
    ),
  );
}