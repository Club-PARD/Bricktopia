import 'package:flutter/material.dart';
import 'package:homepage/api/weather_api.dart';
import 'package:homepage/model/weather_model.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  Weather? _weather;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(
                // 앱바 역할
                height: (MediaQuery.of(context).size.height) / 10.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // 아이콘들을 아래로 정렬
                  crossAxisAlignment: CrossAxisAlignment.end, // 아이콘들을 오른쪽으로 정렬
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
                      children: [
                        GestureDetector(
                          onTap: () {
                            /*
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()),
                              );
                              */
                          },
                          child: Image.asset(
                            'asset/home/icon_search.png',
                            width: (MediaQuery.of(context).size.width) / 15.8,
                          ),
                        ),
                        SizedBox(
                            width: (MediaQuery.of(context).size.width) / 18.95),
                        GestureDetector(
                          onTap: () {
                            /*
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SettingPage()),
                              );
                              */
                          },
                          child: Image.asset(
                            'asset/home/icon_settings.png',
                            width: (MediaQuery.of(context).size.width) / 13.5,
                          ),
                        ),
                        SizedBox(
                            width: (MediaQuery.of(context).size.width) / 17.23),
                      ],
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot != null) {
                    _weather = snapshot.data;
                    if (_weather == null) {
                      return const Text("Loading weather...");
                    } else {
                      return Column(
                        children: [
                          Container(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width) /
                                        10.2),
                                Column(
                                  children: [
                                    SizedBox(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            22.857),
                                    Text(_weather!.city,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24)),
                                    SizedBox(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            35),
                                    Text(
                                        '${_weather!.temp.toStringAsFixed(0)}°',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36)),
                                    SizedBox(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            57.15),
                                    Row(
                                      children: [
                                        Text(
                                            '${_weather!.daily_min_temp[0].toStringAsFixed(0)}°',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff5772D3))),
                                        Image.asset('asset/home/line.png',
                                            width: 18),
                                        SizedBox(
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                190),
                                        Text(
                                            '${_weather!.daily_max_temp[0].toStringAsFixed(0)}°',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffDD5441))),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width) /
                                        3),
                                Column(
                                  children: [
                                    SizedBox(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            42),
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: InkWell(
                                        radius: 100,
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/weather');
                                        },
                                        child: Image.asset(
                                          'asset/weather/${_weather!.icon}.png',
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            20.5),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                10.2),
                                        const Text(
                                          '하루종일 흐리고 비가 올 예정',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width) /
                                        5),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            33.33),
                                    Image.asset(
                                      'asset/home/pop.png',
                                      width: 20,
                                    ),
                                    SizedBox(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            128.4),
                                    Text(
                                      '${(_weather!.pop * 100).toInt()}%',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff5772D3)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                future: getCurrentWeather(),
              ),
              SizedBox(height: (MediaQuery.of(context).size.height) / 17.4),
              Container(
                  height: ((MediaQuery.of(context).size.height) / 22),
                  width: ((MediaQuery.of(context).size.width) / 1.7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(217, 213, 252, 0.70),
                        spreadRadius: 1, // 그림자의 퍼짐 정도
                        blurRadius: 12, // 그림자의 흐림 정도
                        offset: Offset(0, 2), // 그림자의 위치 (x, y)
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '오늘의 아이템을 추천드려요!',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff5772D3)),
                      ),
                    ],
                  )),
              SizedBox(
                height: ((MediaQuery.of(context).size.height) / 66.66),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  // 여기 패딩이 좀 문제인듯!!!!!!
                  ((MediaQuery.of(context).size.width) /
                      20), // 이건 우리 갤럭시로 봤을 때 맞는 사이즈
                  // ((MediaQuery.of(context).size.width) / 13.3), // 이건 우리 emulator로 봤을 때 맞는 사이즈
                  ((MediaQuery.of(context).size.height) / 23.53),
                  ((MediaQuery.of(context).size.width) /
                      20), // 이건 우리 갤럭시로 봤을 때 맞는 사이즈
                  // ((MediaQuery.of(context).size.width) / 13.3), // 이건 우리 emulator로 봤을 때 맞는 사이즈
                  ((MediaQuery.of(context).size.height) / 23.53),
                ),
                width: (MediaQuery.of(context).size.width) / 1.14,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.77), // 배경색 지정
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(217, 213, 252, 0.70),
                      spreadRadius: 1, // 그림자의 퍼짐 정도
                      blurRadius: 12, // 그림자의 흐림 정도
                      offset: Offset(0, 2), // 그림자의 위치 (x, y)
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(children: [
                      const Center(
                          // 상의
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /*
                          Image.asset('assets/items/hoodie.png',
                              width: (MediaQuery.of(context).size.height) / 10),
                          SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width) / 18.95),
                          Image.asset('assets/items/paddedCoat.png',
                              width: (MediaQuery.of(context).size.height) / 10),
                          SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width) / 18.95),
                          Image.asset('assets/items/paddedCoat.png',
                              width: (MediaQuery.of(context).size.height) / 10),
                              */
                        ],
                      )),
                      SizedBox(
                          height: (MediaQuery.of(context).size.height) / 38),
                      const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /*
                          Image.asset('assets/items/shorts.png',
                              width: (MediaQuery.of(context).size.height) / 10),
                          SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width) / 18.95),
                          Image.asset('assets/items/hoodie.png',
                              width: (MediaQuery.of(context).size.height) / 10),
                          SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width) / 18.95),
                          Image.asset('assets/items/shorts.png',
                              width: (MediaQuery.of(context).size.height) / 10),
                              */
                        ],
                      )),
                      SizedBox(
                          height: (MediaQuery.of(context).size.height) / 38),
                      const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /*
                          Image.asset('assets/items/sneakers.png',
                              width: (MediaQuery.of(context).size.height) / 10),
                          SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width) / 18.95),
                          Image.asset('assets/items/cap.png',
                              width: (MediaQuery.of(context).size.height) / 10),
                          SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width) / 18.95),
                          Image.asset('assets/items/sneakers.png',
                              width: (MediaQuery.of(context).size.height) / 10),
                              */
                        ],
                      )),
                    ])
                  ],
                ),
              )
            ],
          ),
          floatingActionButton: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(
                    Alignment.bottomRight.x, Alignment.bottomRight.y - 0.22),
                child: FloatingActionButton(
                  heroTag: 'brief',
                  onPressed: () {},
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: Image.asset(
                    "asset/home/icon_briefing.png",
                    width: (MediaQuery.of(context).size.width) / 1,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(
                    Alignment.bottomRight.x, Alignment.bottomRight.y - 0.05),
                child: FloatingActionButton(
                  heroTag: 'chat',
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ChatScreen()),
                    // );
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: Image.asset(
                    "asset/home/icon_chatbot.png",
                    width: (MediaQuery.of(context).size.width) / 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
