import 'package:flutter/material.dart';
import 'package:homepage/home/screen_pages/main_page.dart';
import 'package:homepage/home/shared_preferences/weather_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final List<String> pageIds = ['a', 'b', 'c', 'd', 'e'];

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const MainPage(),
      WeatherPage(id: pageIds[1]),
      WeatherPage(id: pageIds[2]),
      WeatherPage(id: pageIds[3]),
      WeatherPage(id: pageIds[4]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  // 여기에 페이지가 나타난다
                  height: (MediaQuery.of(context).size.height) / 1.025,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {});
                    },
                    itemCount: _pages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _pages[index % _pages.length];
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: const JumpingDotEffect(
                    activeDotColor: Colors.black,
                    dotColor: Color(0xffD7D7D7),
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
