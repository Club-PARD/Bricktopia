import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import 'five_weather_card.dart';

class FivedayWeather extends StatefulWidget {
  final String message;

  const FivedayWeather(this.message, {Key? key}) : super(key: key);

  @override
  State<FivedayWeather> createState() => _FivedayWeatherState();
}

class _FivedayWeatherState extends State<FivedayWeather> {
  List<List<WeatherData>> groupedWeatherDataList = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherData(widget.message);
  }

  Future<void> fetchWeatherData(String city) async {
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
          pop : pop.toDouble(),
        );
        dataList.add(weatherData);
      }
      setState(() {
        groupedWeatherDataList = groupWeatherDataByDate(dataList);
      });
    } else {
      print('Failed to fetch weather data');
    }
  }

  List<List<WeatherData>> groupWeatherDataByDate(List<WeatherData> weatherDataList) {
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
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  List<WeatherData> compareWeatherData(List<List<WeatherData>> groupedDataList) {
    final List<WeatherData> comparedList = [];
    for (final group in groupedDataList) {
      double maxTemperature = group.first.maxTemperature;
      double minTemperature = group.first.minTemperature;
      double maxPop = group.first.pop;
      double totalHumidity = 0;
      String main = group.first.main;
      for (final weatherData in group) {
        if (weatherData.maxTemperature > maxTemperature) {
          maxTemperature = weatherData.maxTemperature;
        }
        if (weatherData.minTemperature < minTemperature) {
          minTemperature = weatherData.minTemperature;
        }
        if (weatherData.pop > maxPop) {
          maxPop = weatherData.pop;
        }
        totalHumidity += weatherData.humidity;
      }
      final averageHumidity = totalHumidity / group.length;
      final comparedData = WeatherData(
        time: group.first.time,
        maxTemperature: maxTemperature,
        minTemperature: minTemperature,
        humidity: averageHumidity,
        main: main,
        pop: maxPop,
      );
      comparedList.add(comparedData);
    }
    return comparedList;
  }

  @override
  Widget build(BuildContext context) {
    final comparedWeatherDataList = compareWeatherData(groupedWeatherDataList);

    return Container(
      child: comparedWeatherDataList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : FiveWeatherCard(weatherDataList: comparedWeatherDataList),
    );
  }
}
