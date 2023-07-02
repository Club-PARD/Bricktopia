import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class TextToSpeech extends StatefulWidget {
  const TextToSpeech({super.key});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  final String test =
      '현재 제주는 흐린 상태이며 기온은 낮지만 일교차가 조금 있습니다. 습도가 높아 매우 높고 오후 6시에 비소식이 있습니다. 상의는 반팔 티셔츠 혹은 긴팔 티셔츠를 입으시고, 하의는 긴바지가 적당할 것 같습니다. 에어컨이 있는 곳에 들어가면 추울 수 있으니 셔츠나 가디건도 챙기시길 추천합니다. 습도가 높기 때문에 운동화 대신 편한 샌들을 신는게 좋을 것 같아요! 비소식이 있으니 우산을 꼭 챙겨주세요. 오늘도 즐거운 하루 보내세요!';

  final FlutterTts tts = FlutterTts();

  double currentvol = 0.7;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text to Speech"),
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      // Expanded 위젯 추가
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weather AI',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => tts.speak(test),
                  child: const Text("Start"),
                ),
                TextButton(
                  onPressed: () => tts.stop(),
                  child: const Text("Stop"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
