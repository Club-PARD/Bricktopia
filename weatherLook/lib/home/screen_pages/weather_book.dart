import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../chatbot/models/weather_model.dart';
import '../../chatbot/screens/chat_screen.dart';
import '../../chatbot/services/ai_handler.dart';
import '../add_process/search.dart';
import '../homepage.dart';
import '../setting.dart';

class WeatherBook extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String id;

  const WeatherBook({
    Key? key,
    required this.id,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<WeatherBook> createState() => _WeatherBookState();
}

class _WeatherBookState extends State<WeatherBook> {
  List<List<WeatherData>> groupedWeatherDataList = [];
  final AIHandler _openAI = AIHandler();

  //HomePage homePage = HomePage();
  late String aiWeatherresponse = "";

  @override
  void initState() {
    super.initState();
    fetchWeatherData3(widget.longitude, widget.latitude).then((value) {
      setState(() {
        print(value);
        groupedWeatherDataList = value;
      });
    });
    makeASummary(widget.longitude, widget.latitude).then((value) {
      setState(() {
        if (aiWeatherresponse.isEmpty) {
          aiWeatherresponse = value; // mainWeather2가 비어있을 경우에만 값 할당
        }
      });
    });
  }

  Future<String> makeASummary(double longitude, double latitude) async {
    String weatherSummary =
        await AIHandler().fetchWeatherData_m(longitude, latitude);
    final aiWeather =
        "날씨 정보를 바탕으로 은유적인 포현으로 10글자 적어줘 + $weatherSummary + 한국말로 적어줘야해.";
    final aiResponse = await _openAI.getResponse(aiWeather);
    return aiResponse;
  }

  Future<List<List<WeatherData>>> fetchWeatherData3(
      double longitude, double latitude) async {
    const apiKey = '05bce39b122b5837ca69e880e3c94c0e';
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final city = data['city']['name'];
      final List<WeatherData> dataList = [];
      for (final item in data['list']) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
        final maxTemp = item['main']['temp_max'];
        final minTemp = item['main']['temp_min'];
        final humidity = item['main']['humidity'];
        final main = item['weather'][0]['main'];
        final pop = item['pop'];
        print(main);
        final weatherData = WeatherData(
          time: dateTime,
          maxTemperature: maxTemp.toDouble(),
          minTemperature: minTemp.toDouble(),
          humidity: humidity.toDouble(),
          main: main.toString(),
          pop: pop.toDouble(),
          city: city.toString(),
        );
        dataList.add(weatherData);
      }

      // Filter weatherDataList for today's data
      final today = DateTime.now();
      final filteredDataList = dataList.where((data) {
        return isSameDate(data.time, today);
      }).toList();

      // Group filteredDataList by date
      return groupWeatherDataByDate(filteredDataList);
    } else {
      print('Failed to fetch weather data');
      return [];
    }
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
    late List<int> maxTemperatures = [];
    late List<int> minTemperatures = [];
    late List<int> averageTemperatures = [];
    late List<int> precipitationList = [];
    late List<String> mainWeatherList = [];
    late String mainWeather2 = ""; // mainWeather2 초기화
    late String mainCity2 = ""; // mainWeather2 초기화

    for (final group in groupedWeatherDataList) {
      int maxTemperature = group.first.maxTemperature.round();
      int minTemperature = group.first.minTemperature.round();
      int totalTemperature = 0;
      int totalPrecipitation = 0;
      String mainWeather = group.first.main;
      String mainCity = group.first.city;

      for (final weatherData in group) {
        if (weatherData.maxTemperature.round() > maxTemperature) {
          maxTemperature = weatherData.maxTemperature.round();
        }
        if (weatherData.minTemperature.round() < minTemperature) {
          minTemperature = weatherData.minTemperature.round();
        }

        totalTemperature += (weatherData.maxTemperature.round() +
                weatherData.minTemperature.round()) ~/
            2;
        totalPrecipitation += (weatherData.pop * 100).round();

        if (weatherData.main != mainWeather) {
          mainWeather =
              'Mixed'; // If there are different main weathers, set it as 'Mixed'
        }
      }

      int averageTemperature = totalTemperature ~/ group.length;
      int averagePrecipitation = totalPrecipitation ~/ group.length;

      maxTemperatures.add(maxTemperature);
      minTemperatures.add(minTemperature);
      averageTemperatures.add(averageTemperature);
      precipitationList.add(averagePrecipitation);
      mainWeatherList.add(mainWeather);
      if (mainCity2.isEmpty) {
        mainCity2 = mainCity; // mainWeather2가 비어있을 경우에만 값 할당
      }
      if (mainWeather2.isEmpty) {
        mainWeather2 = mainWeather; // mainWeather2가 비어있을 경우에만 값 할당
      }

      print('${minTemperatures.join(', ')}°');
      print('${averageTemperatures.join(', ')}°');
      print(mainWeather2);
      print(mainCity2);
    }

    return Column(
      children: [
        SizedBox(
            // 앱바 역할
            height: (MediaQuery.of(context).size.height) / 10.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // 아이콘들을 아래로 정렬
              crossAxisAlignment: CrossAxisAlignment.end, // 아이콘들을 오른쪽으로 정렬
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
                  children: [
                    IconButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.remove('${widget.id}_latitude');
                          await prefs.remove('${widget.id}_longitude');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        },
                        icon: const Icon(Icons.delete)),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width) / 18.95),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const SettingPage()),
                    //     );
                    //   },
                    //   child: Image.asset(
                    //     'icon/icon_settings.png',
                    //     width: (MediaQuery.of(context).size.width) / 13.5,
                    //   ),
                    // ),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width) / 17.23),
                  ],
                ),
              ],
            )),
        Container(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: (MediaQuery.of(context).size.width) / 10.2),
              Column(
                children: [
                  SizedBox(
                      height: (MediaQuery.of(context).size.height) / 22.857),
                  Text(mainCity2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24)),
                  SizedBox(height: (MediaQuery.of(context).size.height) / 35),
                  Text('${averageTemperatures.join(', ')}°',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 36)),
                  SizedBox(
                      height: (MediaQuery.of(context).size.height) / 57.15),
                  Row(
                    children: [
                      Text('${minTemperatures.join(', ')}°',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5772D3))),
                      Image.asset('assets/line.png', width: 18),
                      SizedBox(
                          width: (MediaQuery.of(context).size.width) / 190),
                      Text('${maxTemperatures.join(', ')}°',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffDD5441))),
                    ],
                  )
                ],
              ),
              SizedBox(width: (MediaQuery.of(context).size.width) / 3),
              Column(
                children: [
                  SizedBox(height: (MediaQuery.of(context).size.height) / 42),
                  mainImage(mainWeather2)
                ],
              )
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              Column(
                children: [
                  SizedBox(height: (MediaQuery.of(context).size.height) / 20.5),
                  Row(
                    children: [
                      SizedBox(
                          width: (MediaQuery.of(context).size.width) / 10.2),
                      SizedBox(
                        width: 180,
                        height: 45,
                        child: Text(
                          aiWeatherresponse,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(width: (MediaQuery.of(context).size.width) / 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: (MediaQuery.of(context).size.height) / 33.33),
                  Image.asset(
                    'assets/rain.png',
                    width: 20,
                  ),
                  SizedBox(
                      height: (MediaQuery.of(context).size.height) / 128.4),
                  Text(
                    '${precipitationList.join(', ')}%',
                    style:
                        const TextStyle(fontSize: 14, color: Color(0xff5772D3)),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: (MediaQuery.of(context).size.height) / 17.4),
        Container(
            height: ((MediaQuery.of(context).size.height) / 22),
            width: ((MediaQuery.of(context).size.width) / 1.7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(217, 213, 252, 0.70),
                  spreadRadius: 1, // 그림자의 퍼짐 정도
                  blurRadius: 12, // 그림자의 흐림 정도
                  offset: Offset(0, 2), // 그림자의 위치 (x, y)
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '오늘의 아이템을 추천드려요!',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5772D3)),
                ),
              ],
            )),
        SizedBox(
          height: ((MediaQuery.of(context).size.height) / 66.66),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
            // 여기 패딩이 좀 문제인듯!!!!!!
            ((MediaQuery.of(context).size.width) /
                20), // 이건 우리 갤럭시로 봤을 때 맞는 사이즈
            // ((MediaQuery.of(context).size.width) / 13.3), // 이건 우리 emulator로 봤을 때 맞는 사이즈
            ((MediaQuery.of(context).size.height) / 23.53),
            ((MediaQuery.of(context).size.width) /
                20), // 이건 우리 갤럭시로 봤을 때 맞는 사이즈
            // ((MediaQuery.of(context).size.width) / 13.3), // 이건 우리 emulator로 봤을 때 맞는 사이즈
            ((MediaQuery.of(context).size.height) / 23.53),
          ),
          width: (MediaQuery.of(context).size.width) / 1.14,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.77), // 배경색 지정
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(217, 213, 252, 0.70),
                spreadRadius: 1, // 그림자의 퍼짐 정도
                blurRadius: 12, // 그림자의 흐림 정도
                offset: Offset(0, 2), // 그림자의 위치 (x, y)
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(children: [
                Center(
                    // 상의
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/items/hoodie.png',
                        width: (MediaQuery.of(context).size.height) / 10),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width) / 18.95),
                    Image.asset('assets/items/paddedCoat.png',
                        width: (MediaQuery.of(context).size.height) / 10),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width) / 18.95),
                    Image.asset('assets/items/paddedCoat.png',
                        width: (MediaQuery.of(context).size.height) / 10),
                  ],
                )),
                SizedBox(height: (MediaQuery.of(context).size.height) / 38),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/items/shorts.png',
                        width: (MediaQuery.of(context).size.height) / 10),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width) / 18.95),
                    Image.asset('assets/items/hoodie.png',
                        width: (MediaQuery.of(context).size.height) / 10),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width) / 18.95),
                    Image.asset('assets/items/shorts.png',
                        width: (MediaQuery.of(context).size.height) / 10),
                  ],
                )),
                SizedBox(height: (MediaQuery.of(context).size.height) / 38),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/items/sneakers.png',
                        width: (MediaQuery.of(context).size.height) / 10),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width) / 18.95),
                    Image.asset('assets/items/cap.png',
                        width: (MediaQuery.of(context).size.height) / 10),
                    SizedBox(
                        width: (MediaQuery.of(context).size.width) / 18.95),
                    Image.asset('assets/items/sneakers.png',
                        width: (MediaQuery.of(context).size.height) / 10),
                  ],
                )),
              ])
            ],
          ),
        )
      ],
    );
    // floatingActionButton: Stack(
    //   children: <Widget>[
    //     Align(
    //       alignment: Alignment(
    //           Alignment.bottomRight.x, Alignment.bottomRight.y - 0.22),
    //       child: FloatingActionButton(
    //         heroTag: 'brief',
    //         onPressed: () {},
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //         shape: const CircleBorder(),
    //         child: Image.asset(
    //           "icon/icon_briefing.png",
    //           width: (MediaQuery.of(context).size.width) / 1,
    //         ),
    //       ),
    //     ),
    //     Align(
    //       alignment: Alignment(
    //           Alignment.bottomRight.x, Alignment.bottomRight.y - 0.05),
    //       child: FloatingActionButton(
    //         heroTag: 'chat',
    //         onPressed: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => ChatScreen()),
    //           );
    //         },
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //         shape: const CircleBorder(),
    //         child: Image.asset(
    //           "icon/icon_chatbot.png",
    //           width: (MediaQuery.of(context).size.width) / 1,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
