// 성국이가 하는 페이지

import 'package:flutter/material.dart';

class createFeedbackPage extends StatefulWidget {
  const createFeedbackPage({super.key});

  @override
  State<createFeedbackPage> createState() => _createFeedbackPageState();
}

class _createFeedbackPageState extends State<createFeedbackPage> {
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
                      const Text('피드백 작성하기',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              )),
          SizedBox(height: (MediaQuery.of(context).size.height) / 16),
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
                      '오늘 추천해드린 옷차림 아이템들에\n대해서 만족하셨나요?',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                        height: (MediaQuery.of(context).size.height) / 33.33),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleButton(),
                      ],
                    ),

                    SizedBox(
                        height: (MediaQuery.of(context).size.height) / 16.6),
                    const Text(
                      '불필요한 아이템이 있으셨나요?',
                      style: TextStyle(fontSize: 18),
                    ),
                    // 박스
                    SizedBox(
                        height: (MediaQuery.of(context).size.height) / 20.5),
                    const Text(
                      '더 필요한 아이템이 있으셨나요?(선택사항)',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height) / 32),
                    // 텍스트필드
                    SizedBox(height: (MediaQuery.of(context).size.height) / 22),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width) / 2.7,
            height: (MediaQuery.of(context).size.height) / 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                  )),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const ()),
                // );
              },
              child: const Text(
                "피드백 전송하기",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatefulWidget {
  const CircleButton({super.key});

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  int selectedValue = 0;

  @override
  void initState() {
    super.initState();
    selectedValue = 1; // 초기 선택 값
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(2, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedValue = index + 1;
            });
          },
          child: Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedValue == index + 1 ? Colors.blue : Colors.grey,
            ),
          ),
        );
      })
          .expand((button) => [
                button,
                const SizedBox(width: 16.0), // 버튼 사이의 간격 조정
              ])
          .toList(),
    );
  }
}
