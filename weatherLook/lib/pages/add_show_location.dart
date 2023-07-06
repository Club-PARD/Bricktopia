import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import '../../chatbot/services/ai_handler.dart';

class AddShowLocation extends StatefulWidget {
  final double? longitude;
  final double? latitude;
  final String id;

  const AddShowLocation({
    super.key,
    this.longitude,
    this.latitude,
    required this.id,
  });

  @override
  State<AddShowLocation> createState() => _AddShowLocationState();
}

class _AddShowLocationState extends State<AddShowLocation> {
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
      setState(() {});
    });

    PerfectVolumeControl.stream.listen((volume) {
      if (volume != currentvol) {
        if (volume > currentvol) {
          tts.stop();
        } else {
          tts.stop();
        }
      }

      setState(() {
        currentvol = volume;
      });
    });
    tts.setLanguage("ko-KR");
    tts.setSpeechRate(0.4);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
