class WeatherData {
  final DateTime time;
  final double maxTemperature;
  final double minTemperature;
  final double humidity;
  final double pop;
  final String main;
  final String city;

  WeatherData({
    required this.time,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    required this.main,
    required this.pop,
    required this.city,
  });

  @override
  String toString() {
    return 'Time: ${time.toString()}, '
        'Max Temperature: ${maxTemperature.toStringAsFixed(1)}°C, '
        'Min Temperature: ${minTemperature.toStringAsFixed(1)}°C, '
        'Humidity: ${humidity.toInt()}%, '
        'Main: $main, '
        'POP: ${(pop * 100).toInt()}%,'
        'City: $city';
  }
}