import 'package:flutter/material.dart';
import 'package:weather_summary/other/feedback.dart';
// import 'package:homepage/home/briefingAlarm.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height: (MediaQuery.of(context).size.height) / 10.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // 아이콘들을 아래로 정렬
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // 오른쪽 정렬
                    children: [
                      SizedBox(width: (MediaQuery.of(context).size.width) / 14),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'icon/icon_back.png',
                          width: (MediaQuery.of(context).size.width) / 15.8,
                        ),
                      ),
                      SizedBox(
                          width: (MediaQuery.of(context).size.width) / 21.4),
                      const Text('설정',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              )),
          SizedBox(height: (MediaQuery.of(context).size.height) / 15),
          Divider(
            color: Colors.black,
            thickness: 1.0,
            indent: (MediaQuery.of(context).size.width) / 12.63,
            endIndent: (MediaQuery.of(context).size.width) / 12.63,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                (MediaQuery.of(context).size.width) / 11.14,
                (MediaQuery.of(context).size.height) / 50,
                (MediaQuery.of(context).size.width) / 11.14,
                (MediaQuery.of(context).size.height) / 50,
              ),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const briefingAlarmpage()),
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '브리핑 알림 설정',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(),
                    GestureDetector(
                        child: Image.asset(
                      'icon/icon_arrow.png',
                    ))
                  ],
                ),
              )),
          Divider(
            color: Colors.black,
            thickness: 1.0,
            indent: (MediaQuery.of(context).size.width) / 12.63,
            endIndent: (MediaQuery.of(context).size.width) / 12.63,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width) / 11.14,
                  (MediaQuery.of(context).size.height) / 50,
                  (MediaQuery.of(context).size.width) / 11.14,
                  (MediaQuery.of(context).size.height) / 50),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const feedbackPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '피드백',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(),
                    GestureDetector(
                        child: Image.asset(
                      'icon/icon_arrow.png',
                    ))
                  ],
                ),
              )),
          Divider(
            color: Colors.black,
            thickness: 1.0,
            indent: (MediaQuery.of(context).size.width) / 12.63,
            endIndent: (MediaQuery.of(context).size.width) / 12.63,
          ),
        ],
      ),
    );
  }
}
