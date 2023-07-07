import 'package:flutter/material.dart';

import '../other/createFeedback.dart';
import '../other/service.dart';
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
              height: (MediaQuery.of(context).size.height) / 9.5,
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
            color: Color(0xff9E9E9E),
            thickness: 1.0,
            indent: (MediaQuery.of(context).size.width) / 12.63,
            endIndent: (MediaQuery.of(context).size.width) / 12.63,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                (MediaQuery.of(context).size.width) / 11.14,
                (MediaQuery.of(context).size.height) / 40,
                (MediaQuery.of(context).size.width) / 11.14,
                (MediaQuery.of(context).size.height) / 40,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const createFeedbackPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '피드백 작성',
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'NanumGothic-Regular'),
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
            color: Color(0xfff9E9E9E),
            thickness: 1.0,
            indent: (MediaQuery.of(context).size.width) / 12.63,
            endIndent: (MediaQuery.of(context).size.width) / 12.63,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width) / 11.14,
                  (MediaQuery.of(context).size.height) / 40,
                  (MediaQuery.of(context).size.width) / 11.14,
                  (MediaQuery.of(context).size.height) / 40),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const servicePage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '고객센터',
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'NanumGothic-Regular'),
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
            color: Color(0xff9E9E9E),
            thickness: 1.0,
            indent: (MediaQuery.of(context).size.width) / 12.63,
            endIndent: (MediaQuery.of(context).size.width) / 12.63,
          ),
        ],
      ),
    );
  }
}
