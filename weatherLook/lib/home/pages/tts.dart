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
        Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<String>(
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
}
