// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

import 'package:homepage/chatbot/screens/chat_screen.dart';
import 'package:homepage/chatbot/services/ai_handler.dart';
import 'package:homepage/home/setting.dart';

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
    final aiWeather = "날씨 정보를 요약해서 한국말로 10글자 적어줘 +$weatherSummary";
    final aiResponse = await _openAI.getResponse(aiWeather);

    if (aiWeatherresponse.isEmpty) {
      aiWeatherresponse = aiResponse; // mainWeather2가 비어있을 경우에만 값 할당
    }

    return aiResponse;
  }

  @override
  void initState() {
    super.initState();
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
              SizedBox(height: (MediaQuery.of(context).size.height) / 24),
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
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20)),
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
                                            fontWeight: FontWeight.w300,
                                            fontSize: 36)),
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
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
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
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
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
                                      child: const Text('날씨 세부정보 >',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff4E5FFF))),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              100,
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
                            width: MediaQuery.of(context).size.width - 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/briefing.png',
                                        height:
                                            MediaQuery.of(context).size.height /
                                                18.18),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                63),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
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
                                            return Text(
                                              aiWeatherresponse!,
                                              overflow: TextOverflow.clip,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            );
                                          }
                                        },
                                        future: makeASummary(
                                            _weather!.lon, _weather!.lat),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: (MediaQuery.of(context).size.height) / 17.4),
                          Container(
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
                            child: Container(
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: -((MediaQuery.of(context).size.height) / 40),
                                    child: Container(
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
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                      ((MediaQuery.of(context).size.width) / 20),
                                      // ((MediaQuery.of(context).size.width) / 13.3), // emulator로 봤을 때 맞는 사이즈
                                      ((MediaQuery.of(context).size.height) / 23.53),
                                      ((MediaQuery.of(context).size.width) / 20),
                                      // ((MediaQuery.of(context).size.width) / 13.3), // mulator로 봤을 때 맞는 사이즈
                                      ((MediaQuery.of(context).size.height) / 23.53),
                                    ),
                                    child: Column(children: [
                                      Center(
                                        // 상의
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.asset('assets/items/hoodie.png',
                                                  width: (MediaQuery.of(context).size.height) /
                                                      10),
                                              SizedBox(
                                                  width: (MediaQuery.of(context).size.width) /
                                                      18.95),
                                              Image.asset('assets/items/paddedCoat.png',
                                                  width: (MediaQuery.of(context).size.height) /
                                                      10),
                                              SizedBox(
                                                  width: (MediaQuery.of(context).size.width) /
                                                      18.95),
                                              Image.asset('assets/items/paddedCoat.png',
                                                  width: (MediaQuery.of(context).size.height) /
                                                      10),
                                            ],
                                          )),
                                      SizedBox(
                                          height:
                                          (MediaQuery.of(context).size.height) / 38),
                                      Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.asset('assets/items/shorts.png',
                                                  width: (MediaQuery.of(context).size.height) /
                                                      10),
                                              SizedBox(
                                                  width: (MediaQuery.of(context).size.width) /
                                                      18.95),
                                              Image.asset('assets/items/hoodie.png',
                                                  width: (MediaQuery.of(context).size.height) /
                                                      10),
                                              SizedBox(
                                                  width: (MediaQuery.of(context).size.width) /
                                                      18.95),
                                              Image.asset('assets/items/shorts.png',
                                                  width: (MediaQuery.of(context).size.height) /
                                                      10),
                                            ],
                                          )),
                                      SizedBox(
                                          height:
                                          (MediaQuery.of(context).size.height) / 38),
                                      Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.asset('assets/items/sneakers.png',
                                                  width: (MediaQuery.of(context).size.height) /
                                                      10),
                                              SizedBox(
                                                  width: (MediaQuery.of(context).size.width) /
                                                      18.95),
                                              Image.asset('assets/items/cap.png',
                                                  width: (MediaQuery.of(context).size.height) /
                                                      10),
                                              SizedBox(
                                                  width: (MediaQuery.of(context).size.width) /
                                                      18.95),
                                              Image.asset('assets/items/sneakers.png',
                                                  width: (MediaQuery.of(context).size.height) /
                                                      10),
                                            ],
                                          )),
                                    ]),
                                  )
                                ],
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
