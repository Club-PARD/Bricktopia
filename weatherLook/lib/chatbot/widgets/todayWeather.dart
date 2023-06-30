// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homepage/chatbot/widgets/today_weather_card.dart';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class TodayWeather extends StatefulWidget {
  final String message;

  const TodayWeather(this.message, {Key? key}) : super(key: key);

  @override
  State<TodayWeather> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  List<WeatherData> weatherDataList = [];
  List<List<WeatherData>> groupedWeatherDataList = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherData2(widget.message);
  }

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
      setState(() {
        weatherDataList = dataList;
      });
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
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: groupedWeatherDataList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : TodayWeatherCard(groupedWeatherDataList: groupedWeatherDataList),
    );
  }
}
