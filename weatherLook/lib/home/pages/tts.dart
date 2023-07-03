import 'package:flutter/material.dart';
import 'package:homepage/chatbot/screens/chat_screen.dart';
import 'package:homepage/chatbot/services/ai_handler.dart';

import 'package:homepage/home/setting.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

import '../add_process/search.dart';
import '../weather/weather_api.dart';
import '../weather/weather_model.dart';


class TextToSpeech extends StatefulWidget {
  const TextToSpeech({super.key});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  Weather? weather;

  final AIHandler _openAI = AIHandler();
  late String aiWeatherresponse = "";

  final FlutterTts tts = FlutterTts();

  double currentvol = 0.7;

  Future<String> brifMorning(double latitude, double longitude) async {
    String weatherSummary =
        await AIHandler().getWeatherDataSummary2(latitude, longitude);
    String aiWeather =
        "$weatherSummary + 에 오늘 날씨 20글자로 표현해줘. 오늘 날씨에 맞는 옷차림을 구체적으로 자세하게 한국말로 알려줘. 마지막으로 오늘 하루를 응원하고, 축복해줘.";
    final aiResponse = await _openAI.getResponse(aiWeather);

    if (aiWeatherresponse.isEmpty) {
      aiWeatherresponse = aiResponse;
    }
    tts.speak(aiWeatherresponse);
    return aiResponse;
  }

  @override
  void initState() {
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
        Container(
// 그라데이션 배경화면
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/home.png"),
              fit: BoxFit.cover, // 화면 자동 맞춤
            ),
          ),
        ),
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
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => SearchPage()),
                            // );
                          },
                          child: Image.asset(
                            'icon/icon_search.png',
                            width: (MediaQuery.of(context).size.width) / 15.8,
                          ),
                        ),
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
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot != null) {
                    weather = snapshot.data as Weather?;
                    if (weather == null) {
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
                                    Text(weather!.city,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24)),
                                    const SizedBox(height: 18),
                                    Text('${weather!.temp.toStringAsFixed(0)}°',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36)),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Text(
                                            '${weather!.daily_min_temp[0].toStringAsFixed(0)}°',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff5772D3))),
                                        Image.asset('assets/line.png',
                                            width: 18),
                                        SizedBox(
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                190),
                                        Text(
                                            '${weather!.daily_max_temp[0].toStringAsFixed(0)}°',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffDD5441))),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: InkWell(
                                    radius: 100,
                                    onTap: () {
                                      Navigator.pushNamed(context, '/weather');
                                    },
                                    child: Image.asset(
                                      'assets/weather/${weather!.icon}.png',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                          ),
                          Container(
                            height: (MediaQuery.of(context).size.height) / 1.7,
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
                            child: FutureBuilder<String>(
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final aiWeatherresponse = snapshot.data;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(aiWeatherresponse!),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () =>
                                                tts.speak(aiWeatherresponse),
                                            child: const Text("Start"),
                                          ),
                                          TextButton(
                                            onPressed: () => tts.stop(),
                                            child: const Text("Stop"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              },
                              future: brifMorning(weather!.lat, weather!.lon),
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
                alignment: Alignment(
                    Alignment.bottomRight.x, Alignment.bottomRight.y - 0.22),
                child: FloatingActionButton(
                  heroTag: 'brief',
                  onPressed: () {
                    Navigator.pop(context);
                    tts.stop();
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: Image.asset(
                    "icon/icon_briefing.png",
                    width: (MediaQuery.of(context).size.width) / 1,
                  ),
                ),
              ),
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
