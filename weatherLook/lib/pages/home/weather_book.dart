import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import '../../../chatbot/services/ai_handler.dart';

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
  final AIHandler _openAI = AIHandler();
  late String aiWeatherresponse = "";

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
    return Container();
  }
}
