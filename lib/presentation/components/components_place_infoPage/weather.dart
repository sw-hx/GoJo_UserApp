import 'package:flutter/material.dart';
import '../../../data/models/weather_model.dart';
import 'place_weather.dart';

class WeatherList extends StatelessWidget {
  final List<WeatherModel> weather;

  const WeatherList({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    if (weather.isEmpty) {
      return const SizedBox(
        height: 120,
        child: Center(child: Text("No weather data")),
      );
    }

    final int itemCount = weather.length ;

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final dayWeather = weather[index];

          return customWeatherDayInfo(
            dayWeather,
          );
        },
      ),
    );
  }
}
