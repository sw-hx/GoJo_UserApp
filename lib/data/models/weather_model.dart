class WeatherModel {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final double precipitationSum;
  final int weatherCode;
  final String description;
  final String icon;

  WeatherModel({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.precipitationSum,
    required this.weatherCode,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      date: DateTime.parse(json["date"]),
      minTemp: (json["minTemp"] as num).toDouble(),
      maxTemp: (json["maxTemp"] as num).toDouble(),
      precipitationSum: (json["precipitationSum"] as num).toDouble(),
      weatherCode: json["weatherCode"],
      description: json["description"],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date.toIso8601String().split('T').first,
      "minTemp": minTemp,
      "maxTemp": maxTemp,
      "precipitationSum": precipitationSum,
      "weatherCode": weatherCode,
      "description": description,
      "icon": icon,
    };
  }
}
