// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:homepage/home/weather/weather_model.dart';
import 'package:http/http.dart' as http;

Future getCurrentWeather() async {
  bool serviceEnabled;
  LocationPermission permission;
  Weather? weather;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double lat = position.latitude;
    double lon = position.longitude;

    String apiKey = "9400fa5b5392bd26329d0dd65aa01ecb";
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

Future getLocalWeather(double lat, double lon) async {
  Weather? weather;

  try {
    String apiKey = "9400fa5b5392bd26329d0dd65aa01ecb";
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