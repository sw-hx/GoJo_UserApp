import 'package:flutter/cupertino.dart';

//codded by zain

Widget customTitleText({required String title, required double size}) {
  return SizedBox(
    height: 50,
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xff0B3647),
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
