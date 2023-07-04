import 'dart:convert';
import 'package:homepage/model/weather_model.dart';
import 'package:http/http.dart' as http;

Future getCurrentWeather() async {
  late Weather weather;
  String lon = '129.365';
  String lat = '36.0322';
  String apiKey = "05bce39b122b5837ca69e880e3c94c0e";
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=kr");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  } else {
    // TODO: Throw error here
  }

  return weather;
}
