import 'package:flutter/material.dart';

class createFeedbackPage extends StatefulWidget {
  const createFeedbackPage({super.key});

  @override
  State<createFeedbackPage> createState() => _createFeedbackPageState();
}

class _createFeedbackPageState extends State<createFeedbackPage> {
  bool isToggleOn = false; // 초기 토글 상태

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
                          'assets/icon/icon_back.png',
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
                    SizedBox(height: (MediaQuery.of(context).size.height) / 45),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleButton(),
                      ],
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height) / 25),
                    const Text(
                      '불필요한 아이템이 있으셨나요?',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height) / 45),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        ((MediaQuery.of(context).size.width) / 23),
                        ((MediaQuery.of(context).size.height) / 67),
                        ((MediaQuery.of(context).size.width) / 23),
                        ((MediaQuery.of(context).size.height) / 67),
                      ),
                      width: (MediaQuery.of(context).size.width) / 1.22,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.77), // 배경색 지정
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(
                              0xff4E5FFF), // Set the border color here
                          width: 2.0, // Set the border thickness here
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(children: [
                            Center(
                                // 상의
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/items/paddedCoat.png',
                                    width:
                                        (MediaQuery.of(context).size.height) /
                                            10),
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width) /
                                        18.95),
                                Image.asset('assets/items/hoodie.png',
                                    width:
                                        (MediaQuery.of(context).size.height) /
                                            10),
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width) /
                                        18.95),
                                Image.asset('assets/items/shorts.png',
                                    width:
                                        (MediaQuery.of(context).size.height) /
                                            10),
                              ],
                            )),
                            SizedBox(
                                height:
                                    (MediaQuery.of(context).size.height) / 45),
                            Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/items/sneakers.png',
                                    width:
                                        (MediaQuery.of(context).size.height) /
                                            10),
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width) /
                                        18.95),
                                Image.asset('assets/items/cap.png',
                                    width:
                                        (MediaQuery.of(context).size.height) /
                                            10),
                                // SizedBox(
                                //     width: (MediaQuery.of(context).size.width) /
                                //         18.95),
                                // Image.asset('assets/items/shorts.png',
                                //     width:
                                //         (MediaQuery.of(context).size.height) /
                                //             10),
                              ],
                            )),
                          ])
                        ],
                      ),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height) / 25),
                    const Text(
                      '더 필요한 아이템이 있으셨나요?(선택사항)',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height) / 60),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isToggleOn = false; // 예 선택
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                            backgroundColor: isToggleOn
                                ? const Color(0xff4E5FFF)
                                : const Color(0xffE4E8F6),
                            minimumSize: const Size(50, 38), // 버튼의 최소 높이 설정
                          ),
                          child: const Text(
                            '상의',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                        SizedBox(
                            width: (MediaQuery.of(context).size.width) /
                                35), // 간격 조정
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isToggleOn = false; // 아니오 선택
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                            backgroundColor: isToggleOn
                                ? const Color(0xff4E5FFF)
                                : const Color(0xffE4E8F6),
                            minimumSize: const Size(50, 38), // 버튼의 최소 높이 설정
                          ),
                          child: const Text(
                            '하의',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                        SizedBox(
                            width: (MediaQuery.of(context).size.width) /
                                35), // 간격 조정
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isToggleOn = false; // 아니오 선택
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                            backgroundColor: isToggleOn
                                ? const Color(0xff4E5FFF)
                                : const Color(0xffE4E8F6),
                            minimumSize: const Size(50, 38), // 버튼의 최소 높이 설정
                          ),
                          child: const Text(
                            '신발',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                        SizedBox(
                            width: (MediaQuery.of(context).size.width) /
                                35), // 간격 조정
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isToggleOn = false; // 아니오 선택
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                            backgroundColor: isToggleOn
                                ? const Color(0xff4E5FFF)
                                : const Color(0xffE4E8F6),
                            minimumSize: const Size(80, 38), // 버튼의 최소 높이 설정
                          ),
                          child: const Text(
                            '악세사리',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height) / 80),
                    SizedBox(
                      height: 50,
                      width: (MediaQuery.of(context).size.width) / 1.24,
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: '세부 아이템', // 힌트 텍스트 설정
                          hintStyle:
                              TextStyle(color: Color(0xff898989), fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff4E5FFF)), // 밑줄의 색상을 보라색으로 설정
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height) / 23),
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
        return Row(
          children: [
            GestureDetector(
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
                  border: Border.all(
                    color: selectedValue == index + 1
                        ? const Color(0xff4E5FFF)
                        : const Color(0xff4E5FFF),
                    width: 2.0,
                  ),
                  color: selectedValue == index + 1
                      ? const Color(0xff4E5FFF)
                      : const Color(0xffffffff),
                ),
              ),
            ),
            SizedBox(
                width: (MediaQuery.of(context).size.width) /
                    21), // 토글 버튼과 텍스트 사이의 간격 조정
            Text(
              index == 0 ? '예' : '아니오',
              style: TextStyle(
                fontSize: 20.0, // 텍스트 크기를 20으로 설정
                color: selectedValue == index + 1
                    ? const Color(0xff000000)
                    : const Color(0xff000000),
              ),
            ),
            SizedBox(
                width: (MediaQuery.of(context).size.width) /
                    5), // 토글 버튼과 텍스트 사이의 간격을 8.0으로 조정
          ],
        );
      }),
    );
  }
}
