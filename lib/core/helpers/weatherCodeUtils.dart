class WeatherCodeUtils {
  static const Map<int, String> _descriptions = {
    0: "Clear sky",
    1: "Mainly clear",
    2: "Partly cloudy",
    3: "Overcast",
    45: "Fog",
    48: "Depositing rime fog",
    51: "Light drizzle",
    53: "Moderate drizzle",
    55: "Dense drizzle",
    56: "Light freezing drizzle",
    57: "Dense freezing drizzle",
    61: "Slight rain",
    63: "Moderate rain",
    65: "Heavy rain",
    71: "Slight snow",
    73: "Moderate snow",
    75: "Heavy snow",
    80: "Rain showers",
    81: "Moderate rain showers",
    82: "Violent rain showers",
    95: "Thunderstorm",
    96: "Thunderstorm with slight hail",
    99: "Thunderstorm with heavy hail",
  };

  static String descriptionForCode(int code) {
    return _descriptions[code] ?? "Unknown";
  }

  static String iconForCode(int code) {
    if (code == 0) return "sun";
    if (code >= 1 && code <= 3) return "partly_cloudy";
    if (code >= 45 && code <= 48) return "fog";
    if ((code >= 51 && code <= 57) ||
        (code >= 61 && code <= 67) ||
        (code >= 80 && code <= 82)) {
      return "rain";
    }
    if (code >= 71 && code <= 77) return "snow";
    if (code >= 95) return "thunder";
    return "unknown";
  }
}
