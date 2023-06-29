import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../chatbot/screens/chat_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const PageOne(),
      PageTwo(
        addPageCallback: addPage,
      ),
    ];
  }

  void addPage() {
    setState(() {
      _pages.insert(1, const AddPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.location_on_outlined),
            // SizedBox(
            //   width: 8,
            // ),
            Text(
              "경상북도 포항",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            IconTheme(
              data: IconThemeData(color: Colors.grey),
              // Set the desired color here
              child: Icon(Icons.keyboard_arrow_down),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // 버튼을 클릭했을 때 수행할 작업
            },
            child: Image.asset(
              'icon/icon_search.png',
              width: 22,
              height: 22,
            ),
          ),
          SizedBox(
            width: 17,
          ),
          GestureDetector(
            onTap: () {
              // 버튼을 클릭했을 때 수행할 작업
            },
            child: Image.asset(
              'icon/icon_settings.png',
              width: 22,
              height: 22,
            ),
          ),
          SizedBox(
            width: 28,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              // 여기에 페이지가 나타난다
              height: 650,
              width: 540,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _activePage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index % _pages.length];
                },
              ),
            ),
            Spacer(
              flex: 2,
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: _pages.length,
              effect: JumpingDotEffect(
                verticalOffset: 8,
                activeDotColor: Colors.pinkAccent,
                dotColor: Colors.pinkAccent.withOpacity(0.5),
                dotHeight: 12,
                dotWidth: 12,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.22),
            child: FloatingActionButton(
              heroTag: 'brief',
              onPressed: () {},
              backgroundColor: Colors.white,
              elevation: 8,
              shape: CircleBorder(),
              child: Image.asset(
                "icon/icon_briefing.png",
                width: 35,
                height: 35,
              ),
            ),
          ),
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.05),
            child: FloatingActionButton(
              heroTag: 'chat',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              backgroundColor: Colors.white,
              elevation: 8,
              shape: CircleBorder(),
              child: Image.asset(
                "icon/icon_chatbot.png",
                width: 35,
                height: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              //color: Colors.red,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8), // 그림자 색상
                          spreadRadius: 2, // 그림자의 퍼지는 정도
                          blurRadius: 5, // 그림자의 흐림 정도
                          offset: Offset(0, 3), // 그림자의 위치 (수평, 수직)
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(22),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "icon/icon_cloud_sun.png",
                              width: 120,
                              height: 70,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "24°",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/rain.png",
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "30%",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "어제보다 쌀쌀할 예정",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 350,
                    child: Container(
                      //color: Colors.red,
                      child: Center(
                        child: Text(
                          "AI가 날씨를 요약해주는 부분입니다:)",
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 350,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        padding: EdgeInsets.all(16),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8), // 그림자 색상
                                  spreadRadius: 2, // 그림자의 퍼지는 정도
                                  blurRadius: 5, // 그림자의 흐림 정도
                                  offset: Offset(0, 3), // 그림자의 위치 (수평, 수직)
                                ),
                              ],
                              // 각 아이템의 border를 둥글게 설정
                            ),
                            child: Center(
                              child: Text(
                                'Item ${index + 1}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class PageTwo extends StatelessWidget {
  final VoidCallback? addPageCallback;

  const PageTwo({
    Key? key,
    this.addPageCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addPageCallback, // 콜백 함수 호출
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.yellow,
            ),
          ),
        ));
  }
}
