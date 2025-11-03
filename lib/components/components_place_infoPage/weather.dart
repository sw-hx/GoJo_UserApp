import 'package:flutter/material.dart';

import 'place_weather.dart';

class WeatherList extends StatelessWidget {
  final int days;

  const WeatherList({super.key, this.days = 4});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: days, itemBuilder: (context, index) => customWeatherDayInfo()),
        );
    }
}