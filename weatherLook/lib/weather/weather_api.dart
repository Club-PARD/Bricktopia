// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:homepage/weather/weather_model.dart';
import 'package:http/http.dart' as http;

Future getCurrentWeather() async {
  Weather? weather;

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double lat = position.latitude;
    double lon = position.longitude;

    String apiKey = "05bce39b122b5837ca69e880e3c94c0e";
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=kr");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {
      // Throw error here
    }
  } catch (e) {
    // Handle location permission denied error
    // Show an error message or provide an alternative way to input location
    print("Error: $e");
  }

  return weather;
}
