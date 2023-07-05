// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:homepage/chatbot/screens/chat_screen.dart';
import 'package:homepage/chatbot/services/ai_handler.dart';
import 'package:homepage/home/setting.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

import '../weather/weather_api.dart';
import '../weather/weather_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Weather? _weather;
  final AIHandler _openAI = AIHandler();
  late String aiWeatherresponse = "";

  Future<String> makeASummary(double longitude, double latitude) async {
    String weatherSummary =
        await AIHandler().fetchWeatherData_m(longitude, latitude);
    final aiWeather = "$weatherSummary + 진짜 정말 제발 짧게 말해줘.";
    final aiResponse = await _openAI.getResponse(aiWeather);

    if (aiWeatherresponse.isEmpty) {
      aiWeatherresponse = aiResponse; // mainWeather2가 비어있을 경우에만 값 할당
    }
    return aiResponse;
  }

  //tts part
  bool isContainerVisible = false;
  late String aiWeatherresponse_detail = "";

  final FlutterTts tts = FlutterTts();
  double currentvol = 0.7;

  Future<String> brifMorning(double latitude, double longitude) async {
    String weatherSummary2 =
        await AIHandler().getWeatherDataSummary2(latitude, longitude);
    String aiWeather2 =
        "$weatherSummary2 + 정보를 가지고 오늘 날씨 유쾌하게 표현해줘. 오늘 날씨에 맞는 옷차림을 구체적으로 자세하게 한국말로 알려줘. 마지막으로 오늘 하루를 응원하고, 축복해줘.";
    final aiResponse2 = await _openAI.getResponse(aiWeather2);

    if (aiWeatherresponse_detail.isEmpty) {
      aiWeatherresponse_detail = aiResponse2;
    }
    tts.speak(aiWeatherresponse_detail);
    return aiResponse2;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      currentvol = await PerfectVolumeControl.getVolume();
//get current volume

      setState(() {
//refresh UI
      });
    });

    PerfectVolumeControl.stream.listen((volume) {
//volume button is pressed,
// this listener will be triggeret 3 times at one button press

      if (volume != currentvol) {
//only execute button type check once time
        if (volume > currentvol) {
//if new volume is greater, then it up button
          tts.stop();
        } else {
//else it is down button
          tts.stop();
        }
      }

      setState(() {
        currentvol = volume;
      });
    });

    super.initState();
// 언어 설정
    tts.setLanguage("ko-KR");
// 속도지정 (0.0이 제일 느리고 1.0이 제일 빠름)
    tts.setSpeechRate(0.4);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
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
                        SizedBox(
                            width: (MediaQuery.of(context).size.width) / 18.95),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingPage()),
                            );
                          },
                          child: Image.asset(
                            'icon/icon_settings.png',
                            width: (MediaQuery.of(context).size.width) / 13.5,
                          ),
                        ),
                        SizedBox(
                            width: (MediaQuery.of(context).size.width) / 17.23),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: (MediaQuery.of(context).size.height) / 29),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot != null) {
                    _weather = snapshot.data as Weather?;
                    if (_weather == null) {
                      return const Text("Loading weather...");
                    } else {
                      return Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                140),
                                        Text(_weather!.city,
                                            style: const TextStyle(
                                                fontFamily: 'paybooc Bold',
                                                fontSize: 20)), // 지역 이름(포항시)
                                      ],
                                    ),
                                    SizedBox(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            30),
                                    Text(
                                        '${_weather!.temp.toStringAsFixed(0)}°',
                                        style: const TextStyle(
                                            fontFamily: 'NanumGothic_Light',
                                            fontSize: 36)), // 현재 기온
                                    SizedBox(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            50),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                126),
                                        Text(
                                            _weather!.daily_min_temp[0]
                                                .toStringAsFixed(0),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'paybooc Medium',
                                                color: Color(0xff5772D3))),
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
                                        Text(
                                            _weather!.daily_max_temp[0]
                                                .toStringAsFixed(0),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'paybooc Medium',
                                                color: Color(0xffDD5441))),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                15.17),
                                        Image.asset('assets/rain.png',
                                            height: 12.5),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                63),
                                        Text(
                                          '${(_weather!.pop * 100).toInt()}%',
                                          style: const TextStyle(
                                              fontFamily: 'NanumGotihc-Regular',
                                              fontSize: 14,
                                              color: Color(0xff5772D3)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      child: const Text('날씨 더보기 >',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff4E5FFF))),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              55,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: InkWell(
                                        radius: 100,
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/weather');
                                        },
                                        child: Image.asset(
                                          'assets/weather/${_weather!.icon}.png',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 50,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isContainerVisible = !isContainerVisible;
                                });
                              },
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/briefing.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                18.18,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                63,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.6,
                                            child: FutureBuilder<String>(
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                } else {
                                                  final aiWeatherresponse =
                                                      snapshot.data;
                                                  return Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      aiWeatherresponse!,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 14),
                                                    ),
                                                  );
                                                }
                                              },
                                              future: makeASummary(
                                                  _weather!.lon, _weather!.lat),
                                            ),
                                          ),
                                          const Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height) / 17.4),
                          Container(
                            width: (MediaQuery.of(context).size.width) / 1.14,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.77), // 배경색 지정
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(217, 213, 252, 0.70),
                                  spreadRadius: 1, // 그림자의 퍼짐 정도
                                  blurRadius: 12, // 그림자의 흐림 정도
                                  offset: Offset(0, 2), // 그림자의 위치 (x, y)
                                ),
                              ],
                            ),
                            child: SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height) / 2.1,
                              width: (MediaQuery.of(context).size.width) / 1.2,
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        ((MediaQuery.of(context).size.width) /
                                            25),
                                        0,
                                        ((MediaQuery.of(context).size.width) /
                                            25),
                                        0),
                                    child: GridView(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            70,
                                      ),
                                      children: [
                                        Stack(
                                          children: [
                                            Image.asset(
                                              'assets/items/longSleeve.png',
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  0,
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                      17.7),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  '긴팔',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontFamily: 'paybooc Light',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Image.asset(
                                              'assets/items/knitwear.png',
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  0,
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                      17.7),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  '니트',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontFamily: 'paybooc Light',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Image.asset(
                                              'assets/items/hoodie.png',
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  0,
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                      17.7),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  '후드티',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontFamily: 'paybooc Light',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                'assets/items/shirts.png',
                                                width: 92,
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  0,
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                      17.7),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  '셔츠',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontFamily: 'paybooc Light',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                'assets/items/longTrousers.png',
                                                width: 88,
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  0,
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                      17.7),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  '긴바지',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontFamily: 'paybooc Light',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Image.asset(
                                              'assets/items/longSleeve.png',
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  0,
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                      17.7),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  '긴팔',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontFamily: 'paybooc Light',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Center(
                                              child: Image.asset(
                                                  'assets/items/cap.png',
                                                  width: 82),
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  0,
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                      17.7),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  '모자',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontFamily: 'paybooc Light',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Image.asset(
                                              'assets/items/sandals.png',
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  0,
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                      17.7),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  '슬리퍼/샌들',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontFamily: 'paybooc Light',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isContainerVisible)
                            Transform.translate(
                              offset: const Offset(0, -390),
                              child: Container(
                                height: 300,
                                width: 345,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: const [
                                    BoxShadow(
                                      color:
                                          Color.fromRGBO(217, 213, 252, 0.70),
                                      spreadRadius: 1, // 그림자의 퍼짐 정도
                                      blurRadius: 12, // 그림자의 흐림 정도
                                      offset: Offset(0, 2), // 그림자의 위치 (x, y)
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: FutureBuilder<String>(
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        final aiweatherresponseDetail =
                                            snapshot.data;
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            aiweatherresponseDetail!,
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        );
                                      }
                                    },
                                    future: brifMorning(
                                        _weather!.lon, _weather!.lat),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                future: getCurrentWeather(),
              ),
            ],
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
                    "icon/icon_chatbot.png",
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
