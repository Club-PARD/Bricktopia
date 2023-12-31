// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:weather_summary/get/get_weather_api.dart';
import 'package:weather_summary/widget/book/current.dart';
import 'package:weather_summary/widget/book/five_day_widget.dart';
import 'package:weather_summary/widget/book/hourly.dart';
import 'package:weather_summary/widget/image/background_widget.dart';

class BookWeatherPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  const BookWeatherPage({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  _BookWeatherPageState createState() => _BookWeatherPageState();
}

class _BookWeatherPageState extends State<BookWeatherPage> {
  List<Map<String, dynamic>> weatherList = [];

  double currentTemperature = 0.0;
  double currentMaxTemperature = 0.0;
  double currentMinTemperature = 0.0;
  double currentPop = 0.0;
  String currentWeatherDescription = '';
  String currentWeatherMain = '';

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  void getWeatherData() async {
    try {
      final Map<String, dynamic> weatherData =
          await fetchWeatherData(widget.latitude, widget.longitude);

      final List<dynamic> forecasts = weatherData['list'];
      weatherList = [];

      Map<String, List<Map<String, dynamic>>> weatherByDate = {};

      for (var forecast in forecasts) {
        final String date = forecast['dt_txt']
            .substring(0, 10); // Extracting only the date part
        final double temperature = forecast['main']['temp'].toDouble();
        final double pop = forecast['pop'].toDouble();
        final String weatherMain = forecast['weather'][0]['main'];
        final String time = forecast['dt_txt']
            .substring(11, 16); // Extracting only the time part

        if (!weatherByDate.containsKey(date)) {
          weatherByDate[date] = [];
        }

        weatherByDate[date]!.add({
          'temperature': temperature,
          'pop': pop * 100,
          'weatherMain': weatherMain,
          'time': time,
        });
      }

      weatherByDate.forEach((date, weatherDataList) {
        double maxTemperature = weatherDataList
            .map<double>((weatherData) => weatherData['temperature'])
            .reduce((value, element) => value > element ? value : element);
        double minTemperature = weatherDataList
            .map<double>((weatherData) => weatherData['temperature'])
            .reduce((value, element) => value < element ? value : element);
        double avgPop = weatherDataList
                .map<double>((weatherData) => weatherData['pop'])
                .reduce((value, element) => value + element) /
            weatherDataList.length;
        String mostFrequentWeatherMain = weatherDataList
            .map<String>((weatherData) => weatherData['weatherMain'])
            .toList()
            .fold<Map<String, int>>(
                {},
                (Map<String, int> map, String value) =>
                    map..update(value, (count) => count + 1, ifAbsent: () => 1))
            .entries
            .reduce((entry1, entry2) =>
                entry1.value > entry2.value ? entry1 : entry2)
            .key;

        weatherList.add({
          'date': date,
          'avgWeatherMain': mostFrequentWeatherMain,
          'avgPop': avgPop,
          'minTemperature': minTemperature,
          'maxTemperature': maxTemperature,
          'weatherInfoForDate': weatherDataList,
        });

        // Set currentMaxTemperature and currentMinTemperature for today
        final today = DateTime.now().toString().substring(0, 10);
        if (date == today) {
          setState(() {
            currentMaxTemperature = maxTemperature;
            currentMinTemperature = minTemperature;
          });
        }
      });

      setState(() {
        final currentWeather = forecasts.first;
        currentTemperature = currentWeather['main']['temp'].toDouble();
        currentPop = currentWeather['pop'].toDouble() * 100;
        currentWeatherDescription = currentWeather['weather'][0]['description'];
        currentWeatherMain = currentWeather['weather'][0]['main'];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: homeImage(context, currentWeatherMain),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CurrentBookWeatherWidget(
                  temperature: currentTemperature,
                  minTemperature: currentMinTemperature,
                  maxTemperature: currentMaxTemperature,
                  pop: currentPop,
                  weatherDescription: currentWeatherDescription,
                  weatherMain: currentWeatherMain,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
                HourlyBookWeathertWidget(weatherList: weatherList),
                FiveDayBookWeatherWidget(weatherList: weatherList),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 32,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
