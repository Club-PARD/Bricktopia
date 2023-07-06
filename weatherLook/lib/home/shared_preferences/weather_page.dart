import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../add_process/search.dart';
import '../screen_pages/weather_book.dart';

class WeatherPage extends StatefulWidget {
  final String id;

  const WeatherPage({super.key, required this.id});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    loadLocation();
  }

  Future<void> saveLocation(double latitude, double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${widget.id}_latitude', latitude);
    await prefs.setDouble('${widget.id}_longitude', longitude);
    setState(() {
      this.latitude = latitude;
      this.longitude = longitude;
    });
  }

  Future<void> deleteLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('${widget.id}_latitude');
    await prefs.remove('${widget.id}_longitude');
    setState(() {
      latitude = null;
      longitude = null;
    });
  }

  Future<void> loadLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? loadedLatitude = prefs.getDouble('${widget.id}_latitude');
    double? loadedLongitude = prefs.getDouble('${widget.id}_longitude');
    setState(() {
      latitude = loadedLatitude;
      longitude = loadedLongitude;
    });
  }

  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 35,),
                    if ((latitude != null && longitude != null) == check)
                      WeatherBook(
                          id: widget.id,
                          latitude: latitude!,
                          longitude: longitude!)
                    else
                      _defaultPage()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _defaultPage() {
    return Column(
      children: [
        SizedBox(height: (MediaQuery.of(context).size.height) / 22),
        const Text(
          '지역 추가하기',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: (MediaQuery.of(context).size.height) / 38),
        const Text(
          '저장하고 싶은 지역을 추가해 보세요',
          style: TextStyle(fontSize: 16, color: Color(0xff5772D3)),
        ),
        SizedBox(height: (MediaQuery.of(context).size.height) / 10),
        Container(
          height: (MediaQuery.of(context).size.height) / 2,
          width: (MediaQuery.of(context).size.width) / 1.54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromRGBO(217, 213, 252, 0.40).withOpacity(0.5),
                spreadRadius: 6,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: GestureDetector(
              onTap: () {
                if (latitude == null || longitude == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(
                              id: widget.id,
                            )),
                  ); // 예시로 위도 37.5, 경도 127.0 저장
                } else {
                  deleteLocation();
                }
              },
              child: Image.asset(
                'assets/add.png',
                width: 280,
                height: 400,
              )),
        ),
      ],
    );
  }
}
