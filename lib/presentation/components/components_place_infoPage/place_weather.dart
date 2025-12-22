import 'package:flutter/material.dart';
import '../../../core/helpers/weatherCodeUtils.dart';
import '../../../data/models/weather_model.dart';

Widget customWeatherDayInfo(WeatherModel weather) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    width: 85,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff3A8DAD),
          Color(0xff2F7898),
        ],
      ),
      borderRadius: BorderRadius.circular(45),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(2, 4),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _dayName(weather.date),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          weatherIconFromCode(weather.weatherCode),

          Text(
            "${weather.maxTemp.toInt()}°",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

String _dayName(DateTime date) {
  const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  return days[date.weekday % 7];
}

Widget weatherIconFromCode(int code) {
  final icon = WeatherCodeUtils.iconForCode(code);

  switch (icon) {
    case "sun":
      return const Icon(Icons.wb_sunny, color: Colors.orangeAccent, size: 36);

    case "partly_cloudy":
      return const Icon(Icons.cloud, color: Colors.white70, size: 36);

    case "fog":
      return const Icon(Icons.blur_on, color: Colors.grey, size: 36);

    case "rain":
      return const Icon(Icons.water_drop, color: Colors.lightBlueAccent, size: 36);

    case "snow":
      return const Icon(Icons.ac_unit, color: Colors.white, size: 36);

    case "thunder":
      return const Icon(Icons.flash_on, color: Colors.yellowAccent, size: 36);

    default:
      return const Icon(Icons.help_outline, color: Colors.white, size: 36);
  }
}
