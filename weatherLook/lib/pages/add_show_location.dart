import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weather_summary/get/get_weather_api.dart';
import 'package:weather_summary/item_model.dart';
import 'package:weather_summary/widget/add/add_app_bar_widget.dart';
import 'package:weather_summary/widget/home/home_weather_widget.dart';
import 'package:weather_summary/widget/home/item_widget.dart';

import '../widget/home/home_summary_box_widget.dart';

class AddShowLocation extends StatefulWidget {
  final double longitude;
  final double latitude;
  final String id;
  final String localName;

  const AddShowLocation({
    super.key,
    required this.longitude,
    required this.latitude,
    required this.id,
    required this.localName,
  });

  @override
  State<AddShowLocation> createState() => _AddShowLocationState();
}

class _AddShowLocationState extends State<AddShowLocation> {
  CollectionReference temperatureRanges =
      FirebaseFirestore.instance.collection('temperature');

  String range = '';

  List<ClothingItem> topsList = [];
  List<ClothingItem> outersList = [];
  List<ClothingItem> bottomList = [];
  List<ClothingItem> otherList = [];

  List<Map<String, dynamic>> weatherList = [];

  double currentTemperature = 0.0;
  double currentMaxTemperature = 0.0;
  double currentMinTemperature = 0.0;
  double currentPop = 0.0;
  String currentWeatherDescription = '';
  String currentWeatherMain = '';
  String currentCity = '';

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  void getWeatherData() async {
    try {
      final double latitude = widget.latitude;
      final double longitude = widget.longitude;

      final Map<String, dynamic> weatherData =
          await fetchWeatherData(latitude, longitude);

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
        currentCity = weatherData['city']['name'];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void updateTops(List<ClothingItem> tops) {
    setState(() {
      topsList = tops;
    });
  }

  void updateOuters(List<ClothingItem> outers) {
    setState(() {
      outersList = outers;
    });
  }

  void updateBottoms(List<ClothingItem> bottoms) {
    setState(() {
      bottomList = bottoms;
    });
  }

  void updateAccessories(List<ClothingItem> other) {
    setState(() {
      otherList = other;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          //backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AddAppBarWidget(
                  longitude: widget.longitude,
                  latitude: widget.latitude,
                  id: widget.id,
                  localName: widget.localName,
                ),
                SizedBox(height: (MediaQuery.of(context).size.height) / 29),
                HomeWeatherWidget(
                  temperature: currentTemperature,
                  minTemperature: currentMinTemperature,
                  maxTemperature: currentMaxTemperature,
                  pop: currentPop,
                  city: widget.localName,
                  weatherMain: currentWeatherMain,
                ),
                Stack(
                  children: [
                    ItemWidget(
                      topsList: topsList,
                      outersList: outersList,
                      bottomList: bottomList,
                      otherList: otherList,
                    ),
                    HomeSummaryBoxWidget(
                      longitude: widget.longitude,
                      latitude: widget.latitude,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
