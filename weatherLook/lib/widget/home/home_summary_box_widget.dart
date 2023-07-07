// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:weather_summary/chatbot/services/ai_handler.dart';

class HomeSummaryBoxWidget extends StatefulWidget {
  final double longitude;
  final double latitude;
  const HomeSummaryBoxWidget({
    super.key,
    required this.longitude,
    required this.latitude,
  });

  @override
  State<HomeSummaryBoxWidget> createState() => _HomeSummaryBoxWidgetState();
}

class _HomeSummaryBoxWidgetState extends State<HomeSummaryBoxWidget> {
  bool isTts = false;
  bool isContainerVisible = false;

  final AIHandler _openAI = AIHandler();
  late String aiWeatherresponse = "";
  late String aiWeatherresponse_detail = "";

  final FlutterTts tts = FlutterTts();
  double currentvol = 0.7;

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

  Future<String> makeASummary() async {
    String weatherSummary =
        await AIHandler().fetchWeatherData_m(widget.longitude, widget.latitude);
    final aiWeather = "$weatherSummary + 진짜 정말 제발 짧게 말해줘.";
    final aiResponse = await _openAI.getResponse(aiWeather);

    if (aiWeatherresponse.isEmpty) {
      aiWeatherresponse = aiResponse; // mainWeather2가 비어있을 경우에만 값 할당
    }
    return aiResponse;
  }

  Future<String> brifMorning() async {
    String weatherSummary2 = await AIHandler()
        .getWeatherDataSummary2(widget.latitude, widget.longitude);
    String aiWeather2 =
        "$weatherSummary2 + 정보를 가지고 오늘 날씨 유쾌하게 표현해줘. 오늘 날씨에 맞는 옷차림을 구체적으로 자세하게 한국말로 알려줘. 마지막으로 오늘 하루를 응원하고, 축복해줘.";
    final aiResponse2 = await _openAI.getResponse(aiWeather2);

    if (aiWeatherresponse_detail.isEmpty) {
      aiWeatherresponse_detail = aiResponse2;
    }
    return aiResponse2;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (isTts == false) {
                            tts.speak(aiWeatherresponse);
                          } else {
                            tts.stop();
                          }

                          setState(() {
                            isTts = !isTts;
                          });
                        },
                        icon: Image.asset(
                          'assets/briefing.png',
                          height: MediaQuery.of(context).size.height / 18.18,
                          color: isTts ? const Color(0xff5772D3) : null,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 63,
                      ),
                      Expanded(
                        child: FutureBuilder<String>(
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final aiWeatherresponse = snapshot.data;
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  aiWeatherresponse!,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              );
                            }
                          },
                          future: isContainerVisible
                              ? brifMorning()
                              : makeASummary(),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isContainerVisible = !isContainerVisible;
                          });
                        },
                        icon: isContainerVisible
                            ? const Icon(Icons.keyboard_arrow_up)
                            : const Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
