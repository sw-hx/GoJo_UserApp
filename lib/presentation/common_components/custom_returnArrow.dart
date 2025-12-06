import 'package:flutter/material.dart';

class CustomReturnArrow extends StatefulWidget {
  final Widget targetPage;

  const CustomReturnArrow({super.key, required this.targetPage});

  @override
  State<CustomReturnArrow> createState() => _CustomReturnArrowState();
}

class _CustomReturnArrowState extends State<CustomReturnArrow> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.keyboard_double_arrow_left_rounded,
          size: 60,
          color: Color.fromRGBO(18, 54, 69, 1),
        ),
        onPressed: () {
          Navigator.pop(context, true);
          },
        );
    }
}
