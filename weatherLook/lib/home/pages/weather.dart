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
    final hour = int.parse(time.split(':')[0]);
    final dateTime = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, hour);
    final format = DateFormat('h a');
    return format.format(dateTime);
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

// 메인 날씨 아이콘
  Widget mainImage(String mainWeather) {
    if (mainWeather == "Clouds") {
      return Image.asset("assets/weather/big_clouds.png",
          width: (MediaQuery.of(context).size.width) / 3.1583,
          fit: BoxFit.cover);
    } else if (mainWeather == "FewClouds") {
      return Image.asset("assets/weather/big_cloud_sun.png",
          width: (MediaQuery.of(context).size.width) / 3.1583,
          fit: BoxFit.cover);
    } else if (mainWeather == "Rain") {
      return Image.asset("assets/weather/big_rainy.png",
          width: (MediaQuery.of(context).size.width) / 3.1583,
          fit: BoxFit.cover);
    } else if (mainWeather == "Snow") {
      return Image.asset("assets/weather/big_snow.png",
          width: (MediaQuery.of(context).size.width) / 3.1583,
          fit: BoxFit.cover);
    } else if (mainWeather == "Clear") {
      return Image.asset("assets/weather/big_sun.png",
          width: (MediaQuery.of(context).size.width) / 3.1583,
          fit: BoxFit.cover);
    } else if (mainWeather == "Thunderstorm") {
      return Image.asset("assets/weather/big_thunder.png",
          width: (MediaQuery.of(context).size.width) / 3.1583,
          fit: BoxFit.cover);
    } else if (mainWeather == "Night") {
      return Image.asset("assets/weather/big_night.png",
          width: (MediaQuery.of(context).size.width) / 3.1583,
          fit: BoxFit.cover);
    }
    return Image.asset("assets/cloud_sun.png",
        width: (MediaQuery.of(context).size.width) / 3.1583, fit: BoxFit.cover);
  }

// 5일간 날씨 미니 아이콘
  Widget fiveDayImage(String avgWeather) {
    if (avgWeather == "Clouds") {
      return Image.asset("assets/weather_mini/mini_clouds.png", width: 32);
    } else if (avgWeather == "Rain") {
      return Image.asset("assets/weather_mini/mini_rain.png", width: 32);
    } else if (avgWeather == "FewClouds") {
      return Image.asset("assets/weather_mini/mini_cloud_sun.png", width: 32);
    } else if (avgWeather == "Snow") {
      return Image.asset("assets/weather_mini/mini_snow.png", width: 32);
    } else if (avgWeather == "Clear") {
      return Image.asset("assets/weather_mini/mini_sun.png", width: 32);
    } else if (avgWeather == "Thunderstorm") {
      return Image.asset("assets/weather_mini/mini_thunder.png", width: 32);
    }
    // else if (avgWeather == "Night") {
    //   return Image.asset("assets/weather_mini/mini_night.png", width: 32);
    // }
    return Image.asset("assets/cloud_sun.png", width: 32);
  }

// 배경화면
  Widget homeImage(String mainWeather) {
    if (mainWeather == "Clouds") {
      return Image.asset("assets/home/home_clouds.png", fit: BoxFit.cover);
    } else if (mainWeather == "FewClouds") {
      return Image.asset("assets/home/home_cloud_sun.png", fit: BoxFit.cover);
    } else if (mainWeather == "Rain") {
      return Image.asset("assets/home/home_rain.png", fit: BoxFit.cover);
    } else if (mainWeather == "Snow") {
      return Image.asset("assets/home/home_snow.png", fit: BoxFit.cover);
    } else if (mainWeather == "Clear") {
      return Image.asset("assets/home/home_sun.png", fit: BoxFit.cover);
    } else if (mainWeather == "Thunderstorm") {
      return Image.asset("assets/home/home_thunderstorm.png",
          fit: BoxFit.cover);
    }
    //  else if (mainWeather == "Night") {
    //   return Image.asset("assets/home/home_night.png", fit: BoxFit.cover);
    // }
    return Image.asset("assets/cloud_sun.png",
        width: (MediaQuery.of(context).size.width) / 3.1583, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _fetch1(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //data를 아직 받지 못했을 때 실행되는 부분
            if (snapshot.hasData == false) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              );
            }
            //error 발생될 경우
            else if (snapshot.hasError) {
              return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: 15)));
            }
            //데이터를 정상적으로 가져온 경우
            else {
              return Stack(
                children: [
                  Container(child: homeImage(currentWeatherMain)),
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: (MediaQuery.of(context).size.height) / 12,
                        ),
                        Center(
                          child: mainImage(
                            currentWeatherMain,
                          ), // 날씨 아이콘
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height) / 55,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      (MediaQuery.of(context).size.width) / 12),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height:
                                        (MediaQuery.of(context).size.height) /
                                            40,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset('assets/rain.png'),
                                              SizedBox(
                                                  width: (MediaQuery.of(context)
                                                          .size
                                                          .width) /
                                                      64),
                                              Text('${currentPop.toInt()}%',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xff4E5FFF),
                                                      fontFamily:
                                                          'NanumGothic-Regular')), // 강수량
                                            ],
                                          ),
                                          SizedBox(
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                                70,
                                          ),
                                          Text(currentWeatherDescription,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'NanumGothic-Regular'))
                                        ],
                                      )
                                    ],
                                  ),
                                  // 첫 번째 Column의 내용
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('${currentTemperature.toInt()}°',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 36,
                                          fontFamily: 'NanumGothic-Light')),
                                  SizedBox(
                                    height:
                                        (MediaQuery.of(context).size.height) /
                                            70,
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('${currentMinTemperature.toInt()}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff4E5FFF),
                                                fontFamily: 'paybooc Medium')),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                126),
                                        Image.asset('assets/line.png',
                                            width: 18),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                126),
                                        Text('${currentMaxTemperature.toInt()}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xffDD5441),
                                                fontFamily: 'paybooc Medium')),
                                      ])
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      (MediaQuery.of(context).size.width) / 8),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 39,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: weatherList.map((weather) {
                                    final List<Map<String, dynamic>>
                                        weatherInfoForDate =
                                        weather['weatherInfoForDate'];
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: (MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  21),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              padding: const EdgeInsets.all(
                                                  8.0), // 내부 여백 설정
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: weatherInfoForDate
                                                      .map((weatherInfo) {
                                                    return Container(
                                                      width:
                                                          48, // Adjust the width as needed
                                                      margin:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            formatTime(
                                                                weatherInfo[
                                                                    'time']),
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xff4E5FFF),
                                                                fontFamily:
                                                                    'NanumGothic-Regular'),
                                                          ),
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                100,
                                                          ),
                                                          SizedBox(
                                                            width: 35.5,
                                                            height: 35.5,
                                                            child: mainImage(
                                                                weatherInfo[
                                                                        'weatherMain']
                                                                    .toString()),
                                                          ),
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                100,
                                                          ),
                                                          Text(
                                                            '${weatherInfo['temperature'].toInt()}°',
                                                            style: const TextStyle(
                                                                fontSize:
                                                                    13.734,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Color(
                                                                    0xff6D6D6D),
                                                                fontFamily:
                                                                    'paybooc Bold'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 18.95,
                                    MediaQuery.of(context).size.height / 45,
                                    MediaQuery.of(context).size.width / 13,
                                    MediaQuery.of(context).size.height / 90),
                                width: MediaQuery.of(context).size.width / 1.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white.withOpacity(0.3)),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              '    5일간의 날씨',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'paybooc Medium',
                                                  color: Color(0xff6D6D6D)),
                                            ),
                                            Row(
                                              children: [
                                                const Text('최고',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff6D6D6D),
                                                        fontFamily:
                                                            'paybooc Medium')),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20),
                                                const Text('최저',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff6D6D6D),
                                                        fontFamily:
                                                            'paybooc Medium')),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            80),
                                              ],
                                            ),
                                          ]),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: weatherList.length,
                                      itemBuilder: (context, index) {
                                        final weather = weatherList[index];
                                        final List<Map<String, dynamic>>
                                            weatherInfoForDate =
                                            weather['weatherInfoForDate'];

                                        final date =
                                            DateTime.parse(weather['date']);
                                        final isFutureDate = date.isAfter(
                                            DateTime.now().subtract(
                                                const Duration(days: 1)));

                                        if (!isFutureDate) {
                                          return const SizedBox(); // Skip data from past days
                                        }

                                        final isToday =
                                            DateTime.now().day == date.day;
                                        final dayLabel = isToday
                                            ? '오늘'
                                            : DateFormat('  EEE  ', 'ko_KR')
                                                .format(date);

                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              17.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              35),
                                                  SizedBox(
                                                    child: Text(dayLabel,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'baybooc Medium')),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              29),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              11,
                                                      child: fiveDayImage(weather[
                                                          'avgWeatherMain'])), // 아이콘 바꾸기
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              30),
                                                  if ('${weather['avgPop'].toInt()}%' !=
                                                      '0%')
                                                    Text(
                                                        '${weather['avgPop'].toInt()}%',
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'NanumGothic-Regular',
                                                            color: Color(
                                                                0xff4E5FFF))),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      '${weather['maxTemperature'].toInt()}°',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xffDD5441),
                                                          fontFamily:
                                                              'paybooc Medium')),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              16),
                                                  Text(
                                                      '${weather['minTemperature'].toInt()}°',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff4E5FFF),
                                                          fontFamily:
                                                              'paybooc Medium')),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  Future<String> _fetch1() async {
    await Future.delayed(const Duration(seconds: 5));
    return 'Call Data';
  }
}
