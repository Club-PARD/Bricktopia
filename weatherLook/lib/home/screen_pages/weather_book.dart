import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../chatbot/services/ai_handler.dart';
import '../homepage.dart';
import '../weather/weather_api.dart';
import '../weather/weather_model.dart';

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
  Weather? _weather;
  final AIHandler _openAI = AIHandler();
  late String aiWeatherresponse = "";


  Widget mainImage(String mainWeather) {
    if (mainWeather == "Clouds") {
      return Image.asset("assets/weather/big_clouds.png");
    } else if (mainWeather == "FewClouds") {
      return Image.asset("assets/weather/big_cloud_sun.png");
    } else if (mainWeather == "Rain") {
      return Image.asset("assets/weather/big_rainy.png");
    } else if (mainWeather == "Snow") {
      return Image.asset("assets/weather/big_snow.png");
    } else if (mainWeather == "Clear") {
      return Image.asset("assets/weather/big_sun.png");
    } else if (mainWeather == "Thunderstorm") {
      return Image.asset("assets/weather/big_thunder.png");
    } else if (mainWeather == "Night") {
      return Image.asset("assets/weather/big_night.png");
    }
    return Image.asset("assets/cloud_sun.png");
  }

  Future<String> makeASummary(double latitude, double longitude) async {
    String weatherSummary =
        await AIHandler().fetchWeatherData_m(latitude, longitude);
    final aiWeather = "$weatherSummary + 진짜 정말 제발 짧게 말해줘.";
    final aiResponse = await _openAI.getResponse(aiWeather);

    if (aiWeatherresponse.isEmpty) {
      aiWeatherresponse = aiResponse; // mainWeather2가 비어있을 경우에만 값 할당
    }
    return aiResponse;
  }

  //tts part
  bool isTts = false;
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
        SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot != null) {
                    _weather = snapshot.data as Weather?;
                    if (_weather == null) {
                      return const Text("Loading weather...");
                    } else {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                                  await prefs.remove(widget.id + '_latitude');
                                  await prefs.remove(widget.id + '_longitude');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                },
                                icon: Image.asset("assets/Mask group.png"),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                          SizedBox(height: (MediaQuery.of(context).size.height) / 45),
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
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/weather');
                                      },
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
                                        child: mainImage(_weather!.weather),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0, 100),
                            child: Container(
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
                                width:
                                    (MediaQuery.of(context).size.width) / 1.2,
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
                                          mainAxisSpacing:
                                              (MediaQuery.of(context)
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
                                                      fontFamily:
                                                          'paybooc Light',
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
                                                      fontFamily:
                                                          'paybooc Light',
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
                                                      fontFamily:
                                                          'paybooc Light',
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
                                                      fontFamily:
                                                          'paybooc Light',
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
                                                      fontFamily:
                                                          'paybooc Light',
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
                                                      fontFamily:
                                                          'paybooc Light',
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
                                                      fontFamily:
                                                          'paybooc Light',
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
                                                      fontFamily:
                                                          'paybooc Light',
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
                          ),
                          Transform.translate(
                            offset: const Offset(0, -360),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: (MediaQuery.of(context).size.width) / 1.14,
                              height: isContainerVisible ? 250 : null,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.77),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(217, 213, 252, 0.70),
                                    spreadRadius: 1,
                                    blurRadius: 12,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isTts = !isTts;
                                                });
                                                tts.speak(aiWeatherresponse_detail);
                                              },
                                              icon: Image.asset(
                                                'assets/briefing.png',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    18.18,
                                                color: isTts
                                                    ? Color(0xff5772D3)
                                                    : null,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  63,
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: FutureBuilder<String>(
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else {
                                                      final aiWeatherresponse =
                                                          snapshot.data;
                                                      return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          aiWeatherresponse!,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontSize: 14),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  future: isContainerVisible
                                                      ? brifMorning(
                                                          _weather!.lon,
                                                          _weather!.lat)
                                                      : makeASummary(
                                                          _weather!.lon,
                                                          _weather!.lat),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isContainerVisible =
                                                      !isContainerVisible;
                                                });
                                              },
                                              icon: isContainerVisible
                                                  ? Icon(
                                                      Icons.keyboard_arrow_up)
                                                  : Icon(Icons
                                                      .keyboard_arrow_down),
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
                        ],
                      );
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                future: getLocalWeather(widget.latitude!, widget.longitude!),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
