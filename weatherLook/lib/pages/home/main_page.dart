// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_summary/chatbot/screens/chat_screen.dart';
import 'package:weather_summary/get/get_location.dart';
import 'package:weather_summary/get/get_weather_api.dart';
import 'package:weather_summary/service/item_model.dart';
import 'package:weather_summary/widget/home/home_app_bar_widget.dart';
import 'package:weather_summary/widget/home/home_weather_widget.dart';
import 'package:weather_summary/widget/home/item_widget.dart';
import 'package:weather_summary/widget/home/home_summary_box_widget.dart';
import 'package:weather_summary/widget/image/background_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CollectionReference temperatureRanges =
      FirebaseFirestore.instance.collection('temperature');

  double latitude = 0.0;
  double longitude = 0.0;

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
    getAvgTempString(currentMinTemperature, currentMaxTemperature);
    getMatchingItems();
  }

  void getWeatherData() async {
    try {
      final Position position = await getCurrentLocation();
      latitude = position.latitude;
      longitude = position.longitude;

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

  String getAvgTempString(
      double currentMinTemperature, double currentMaxTemperature) {
    double avgTemp = (currentMaxTemperature + currentMinTemperature) / 2;
    if (avgTemp < 5) {
      range = '0_to_4';
    } else if (avgTemp >= 5 && avgTemp < 9) {
      range = '5_to_8';
    } else if (avgTemp >= 9 && avgTemp < 12) {
      range = '9_to_11';
    } else if (avgTemp >= 12 && avgTemp < 17) {
      range = '12_to_16';
    } else if (avgTemp >= 17 && avgTemp < 20) {
      range = '17_to_19';
    } else if (avgTemp >= 20 && avgTemp < 23) {
      range = '20_to_22';
    } else if (avgTemp >= 23 && avgTemp < 28) {
      range = '23_to_27';
    } else if (avgTemp >= 28) {
      range = '28_to_30';
    }
    return range;
  }

  Future<void> getMatchingItems() async {
    final today = DateTime.now().toString().substring(0, 10);
    final matchingTemperatureDoc = temperatureRanges.doc(range);

    matchingTemperatureDoc.get().then((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        final topsCollection = matchingTemperatureDoc.collection('top');
        topsCollection.get().then((snapshot) {
          final topsData = snapshot.docs.map((doc) => doc.data()).toList();
          setState(() {
            topsList = topsData
                .map((data) => ClothingItem(
                      itemName: data['item_name'],
                      url: data['url'],
                    ))
                .toList();
          });
        });

        final outersCollection = matchingTemperatureDoc.collection('outer');
        outersCollection.get().then((snapshot) {
          final outersData = snapshot.docs.map((doc) => doc.data()).toList();
          setState(() {
            outersList = outersData
                .map((data) => ClothingItem(
                      itemName: data['item_name'],
                      url: data['url'],
                    ))
                .toList();
          });
        });

        final bottomCollection = matchingTemperatureDoc.collection('bottom');
        bottomCollection.get().then((snapshot) {
          final bottomData = snapshot.docs.map((doc) => doc.data()).toList();
          setState(() {
            bottomList = bottomData
                .map((data) => ClothingItem(
                      itemName: data['item_name'],
                      url: data['url'],
                    ))
                .toList();
          });
        });

        final otherCollection = matchingTemperatureDoc.collection('other');
        otherCollection.get().then((snapshot) {
          final otherData = snapshot.docs.map((doc) => doc.data()).toList();
          setState(() {
            otherList = otherData
                .map((data) => ClothingItem(
                      itemName: data['item_name'],
                      url: data['url'],
                    ))
                .toList();
          });
        });
      }
    });
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: (MediaQuery.of(context).size.height) / 10.8,
                  child: const HomeAppBarWidget(),
                ),
                HomeWeatherWidget(
                  temperature: currentTemperature,
                  minTemperature: currentMinTemperature,
                  maxTemperature: currentMaxTemperature,
                  pop: currentPop,
                  city: currentCity,
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
                      longitude: longitude,
                      latitude: latitude,
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: Stack(
            children: <Widget>[
              Align(
                alignment:
                    Alignment(Alignment.bottomRight.x, Alignment.bottomRight.y),
                child: FloatingActionButton(
                  heroTag: 'chat',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen()),
                    );
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: Image.asset(
                    "assets/icon/icon_chatbot.png",
                    width: (MediaQuery.of(context).size.width) / 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
