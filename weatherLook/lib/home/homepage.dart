import 'package:flutter/material.dart';
import 'package:homepage/home/page_one.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

<<<<<<< Updated upstream
//import 'search.dart';
//import 'setting.dart';
=======
import 'search.dart';
>>>>>>> Stashed changes

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
      const PageTwo(),
      // AddPage(
      //   addPageCallback: addPage,
      // ),
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
      body: Stack(
        children: [
          Container(
            // 그라데이션 배경화면
            decoration: const BoxDecoration(
                /*
              image: DecorationImage(
                image: AssetImage("assets/home.png"),
                fit: BoxFit.cover, // 화면 자동 맞춤
              ),
              */
                ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  // 여기에 페이지가 나타난다
                  height: (MediaQuery.of(context).size.height) / 1.025,
                  width: MediaQuery.of(context).size.width,
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
                const Spacer(
                  flex: 2,
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: const JumpingDotEffect(
                    activeDotColor: Colors.black,
                    dotColor: Color(0xffD7D7D7),
                    dotHeight: 10,
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

class PageTwo extends StatelessWidget {
  const PageTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: (MediaQuery.of(context).size.height) / 10.5),
            const Text(
              '지역 추가하기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: (MediaQuery.of(context).size.height) / 30.75),
            const Text(
              '저장하고 싶은 지역을 추가해 보세요',
              style: TextStyle(fontSize: 16, color: Color(0xff5772D3)),
            ),
            SizedBox(height: (MediaQuery.of(context).size.height) / 10),
            Container(
              height: (MediaQuery.of(context).size.height) / 1.8779,
              width: (MediaQuery.of(context).size.width) / 1.54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(217, 213, 252, 0.40)
                        .withOpacity(
                            0.5), // Replace with your desired shadow color
                    spreadRadius: 4,
                    blurRadius: 5,
                    offset: const Offset(0,
                        3), // Adjust the offset to control the position of the shadow
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                  */
                },
                child: Image.asset(
                  'assets/add.png',
                ),
              ),
            )
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
        backgroundColor: Colors.white,
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
