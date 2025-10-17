import 'package:flutter/material.dart';

Widget customWeatherDayInfo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    padding: EdgeInsets.all(12),
    width: 70,
    decoration: BoxDecoration(
      color: Color(0xff2F7898),
      borderRadius: BorderRadius.circular(50),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 3)),
      ],
    ),
    child: Column(
      children: [
        Text('29°c', style: TextStyle(fontSize: 20, color: Colors.white)),
        Icon(Icons.sunny, color: Colors.yellow, size: 40),
        Text('Sun', style: TextStyle(fontSize: 20, color: Colors.white)),
      ],
    ),
  );
}
