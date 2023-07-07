import 'package:flutter/material.dart';

import 'createFeedback.dart';

class feedbackPage extends StatefulWidget {
  const feedbackPage({super.key});

  @override
  State<feedbackPage> createState() => _feedbackPageState();
}

class _feedbackPageState extends State<feedbackPage> {
  bool _switchValue = true;

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
                      const Text('피드백',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              )),
          SizedBox(height: (MediaQuery.of(context).size.height) / 15),
          Padding(
            padding: EdgeInsets.fromLTRB(
                (MediaQuery.of(context).size.width) / 11.14,
                0,
                (MediaQuery.of(context).size.width) / 11.14,
                0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '피드백 알림 설정',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height) / 47),
                    const Text(
                      '매일 오후 10시에 날씨 추천에\n대한 피드백 알림이 전송됩니다.',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Column(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Switch(
                        value: _switchValue,
                        activeColor: const Color(0xff4E5FFF),
                        onChanged: (bool value) {
                          setState(() {
                            _switchValue = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                        height: (MediaQuery.of(context).size.height) / 14.54),
                  ],
                ),
              ],
            ),
          ),
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
                      '피드백 작성하기',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const createFeedbackPage()),
                          );
                        },
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
