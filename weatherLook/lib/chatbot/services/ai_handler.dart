// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class AIHandler {
  //추가
  List<WeatherData> weatherDataList = [];
  List<List<WeatherData>> groupedWeatherDataList = [];

  final _openAI = OpenAI.instance.build(
    token: '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',
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
    ),
  );

  Future<String> getResponse(String message) async {
    try {
      return 'Something went wrong';
    } catch (e) {
      return 'Bad response';
    }
  }

  Future<String> fetchWeatherData(String city) async {
    const apiKey = '9400fa5b5392bd26329d0dd65aa01ecb';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final weather = data['weather'][0]['main'];
      final temperature = data['main']['temp'];
      final humidity = data['main']['humidity'];
      final pop = data['pop'];

      return 'Current weather in $city:\nWeather: $weather\nTemperature: $temperature\nHumidity: $humidity\nPrecipitation: $pop';
    } else {
      return 'Failed to fetch weather data';
    }
  }

  //추가
  Future<void> fetchWeatherData2(String city) async {
    // Fetch weather data and populate weatherDataList
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=9400fa5b5392bd26329d0dd65aa01ecb&units=metric');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<WeatherData> dataList = [];
      for (final item in data['list']) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
        final maxTemp = item['main']['temp_max'];
        final minTemp = item['main']['temp_min'];
        final humidity = item['main']['humidity'];
        final main = item['weather'][0]['main'];
        final pop = item['pop'];

        final weatherData = WeatherData(
          time: dateTime,
          maxTemperature: maxTemp.toDouble(),
          minTemperature: minTemp.toDouble(),
          humidity: humidity.toDouble(),
          main: main.toString(),
          pop: pop.toDouble(),
        );
        dataList.add(weatherData);
      }
      weatherDataList = dataList;
    } else {
      print('Failed to fetch weather data');
    }
    // Filter weatherDataList for today's data
    final today = DateTime.now();
    final filteredDataList = weatherDataList.where((data) {
      return isSameDate(data.time, today);
    }).toList();

    // Group filteredDataList by date
    groupedWeatherDataList = groupWeatherDataByDate(filteredDataList);
  }

  List<List<WeatherData>> groupWeatherDataByDate(
      List<WeatherData> weatherDataList) {
    final groupedData = <List<WeatherData>>[];
    for (final weatherData in weatherDataList) {
      bool foundGroup = false;
      for (final group in groupedData) {
        if (isSameDate(group.first.time, weatherData.time)) {
          group.add(weatherData);
          foundGroup = true;
          break;
        }
      }
      if (!foundGroup) {
        groupedData.add([weatherData]);
      }
    }
    return groupedData;
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<String> getWeatherDataSummary(String city) async {
    await fetchWeatherData2(city);
    final buffer = StringBuffer();
    for (final group in groupedWeatherDataList) {
      for (final weatherData in group) {
        buffer.writeln(weatherData.toString());
      }
    }
    final groupedWeatherDataString = buffer.toString();

    final summary = await getResponse(groupedWeatherDataString);
    return summary;
  }
}
