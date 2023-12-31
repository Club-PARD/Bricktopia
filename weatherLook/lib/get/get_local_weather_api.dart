import 'dart:convert';
import 'package:http/http.dart' as http;

Future getLocalWeather(double lat, double lon) async {
  try {
    String apiKey = "9400fa5b5392bd26329d0dd65aa01ecb";
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=kr");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      // Throw error here
    }
  } catch (e) {
    // Handle location permission denied error
    // Show an error message or provide an alternative way to input location
    print("Error: $e");
  }
}
