// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  List<Map<String, dynamic>> weatherList = [];

  double currentTemperature = 0.0;
  double currentMaxTemperature = 0.0;
  double currentMinTemperature = 0.0;
  double currentPop = 0.0;
  String currentWeatherDescription = '';
  String currentWeatherMain = '';

  String formatTime(String time) {
    final hour = time.split(':')[0];
    return '$hour시';
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Map<String, dynamic>> fetchWeatherData(
      double latitude, double longitude) async {
    const apiKey = '05bce39b122b5837ca69e880e3c94c0e';
    final apiUrl =
        'http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch weather data.');
    }
  }

  void getWeatherData() async {
    try {
      final Position position = await getCurrentLocation();
      final double latitude = position.latitude;
      final double longitude = position.longitude;

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
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget mainImage(String mainWeather) {
    if (mainWeather == "Clouds") {
      return Image.asset(
        "assets/clouds.png",
        width: 100,
        height: 100,
      );
    } else if (mainWeather == "Rain") {
      return Image.asset(
        "assets/rainy.png",
        width: 100,
        height: 100,
      );
    } else if (mainWeather == "Snow") {
      return Image.asset(
        "assets/snow.png",
        width: 100,
        height: 100,
      );
    } else if (mainWeather == "Clear") {
      return Image.asset(
        "assets/sun.png",
        width: 100,
        height: 100,
      );
    }
    return Image.asset(
      "assets/cloud_sun.png",
      width: 100,
      height: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: mainImage(currentWeatherMain),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('현재 날씨: ${currentTemperature.toInt()}°'),
                  Text(
                    '최고 날씨: ${currentMaxTemperature.toInt()}°',
                  ),
                  Text(
                    '최저 날씨: ${currentMinTemperature.toInt()}°',
                  ),
                ],
              ),
            ],
          ),
          Text(
            '강수량: ${currentPop.toInt()}%',
          ),
          Text(
            currentWeatherDescription,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: weatherList.map((weather) {
                      final List<Map<String, dynamic>> weatherInfoForDate =
                          weather['weatherInfoForDate'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Date: ${weather['date']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: weatherInfoForDate.map((weatherInfo) {
                                return Container(
                                  width: 120, // Adjust the width as needed
                                  margin: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatTime(weatherInfo['time']),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: mainImage(
                                            weatherInfo['weatherMain']
                                                .toString()),
                                      ),
                                      Text(
                                        '${weatherInfo['temperature'].toInt()}°',
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: weatherList.length,
                  itemBuilder: (context, index) {
                    final weather = weatherList[index];
                    final List<Map<String, dynamic>> weatherInfoForDate =
                        weather['weatherInfoForDate'];

                    final date = DateTime.parse(weather['date']);
                    final isFutureDate = date.isAfter(
                        DateTime.now().subtract(const Duration(days: 1)));

                    if (!isFutureDate) {
                      return const SizedBox(); // Skip data from past days
                    }

                    final isToday = DateTime.now().day == date.day;
                    final dayLabel = isToday
                        ? '오늘'
                        : DateFormat('EEE', 'ko_KR').format(date);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                dayLabel,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: mainImage(weather['avgWeatherMain']),
                            ),
                            Text('pop: ${weather['avgPop'].toInt()}%'),
                            Text('최저: ${weather['minTemperature'].toInt()}°'),
                            Text('최고: ${weather['maxTemperature'].toInt()}°'),
                          ],
                        ),
                        const Divider(),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
