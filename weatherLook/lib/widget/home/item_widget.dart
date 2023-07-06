import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({super.key});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width) / 1.14,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.77), // 배경색 지정
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(217, 213, 252, 0.70),
            spreadRadius: 1, // 그림자의 퍼짐 정도
            blurRadius: 12, // 그림자의 흐림 정도
            offset: Offset(0, 2), // 그림자의 위치 (x, y)
          ),
        ],
      ),
      child: SizedBox(
        height: (MediaQuery.of(context).size.height) / 2.1,
        width: (MediaQuery.of(context).size.width) / 1.2,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                  ((MediaQuery.of(context).size.width) / 25),
                  0,
                  ((MediaQuery.of(context).size.width) / 25),
                  0),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: (MediaQuery.of(context).size.height) / 70,
                ),
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/items/longSleeve.png',
                      ),
                      Transform.translate(
                        offset: Offset(
                            0, (MediaQuery.of(context).size.height) / 17.7),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '긴팔',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'paybooc Light',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/items/knitwear.png',
                      ),
                      Transform.translate(
                        offset: Offset(
                            0, (MediaQuery.of(context).size.height) / 17.7),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '니트',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'paybooc Light',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/items/hoodie.png',
                      ),
                      Transform.translate(
                        offset: Offset(
                            0, (MediaQuery.of(context).size.height) / 17.7),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '후드티',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'paybooc Light',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/items/shirts.png',
                          width: 92,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(
                            0, (MediaQuery.of(context).size.height) / 17.7),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '셔츠',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'paybooc Light',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/items/longTrousers.png',
                          width: 88,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(
                            0, (MediaQuery.of(context).size.height) / 17.7),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '긴바지',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'paybooc Light',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/items/longSleeve.png',
                      ),
                      Transform.translate(
                        offset: Offset(
                            0, (MediaQuery.of(context).size.height) / 17.7),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '긴팔',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'paybooc Light',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Image.asset('assets/items/cap.png', width: 82),
                      ),
                      Transform.translate(
                        offset: Offset(
                            0, (MediaQuery.of(context).size.height) / 17.7),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '모자',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'paybooc Light',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/items/sandals.png',
                      ),
                      Transform.translate(
                        offset: Offset(
                            0, (MediaQuery.of(context).size.height) / 17.7),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '슬리퍼/샌들',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'paybooc Light',
                            ),
                          ),
                        ),
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
