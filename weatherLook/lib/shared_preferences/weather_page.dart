import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_summary/pages/home/weather_book.dart';
import 'package:weather_summary/pages/search.dart';

import '../chatbot/screens/chat_screen.dart';

class WeatherPage extends StatefulWidget {
  final String id;

  const WeatherPage({super.key, required this.id});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  double? latitude;
  double? longitude;
  String? city;

  @override
  void initState() {
    super.initState();
    loadLocation();
    loadCity();
  }

  Future<void> deleteCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('${widget.id}_city');
    await prefs.remove('${widget.id}_city');
    setState(() {
      city = null;
    });
  }

  Future<void> saveCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('${widget.id}_city', city);
    setState(() {
      this.city = city;
    });
  }

  Future<void> loadCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loadedCity = prefs.getString('${widget.id}_city');
    setState(() {
      this.city = loadedCity;
    });
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
    return Stack(
      children: [

        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        if ((latitude != null && longitude != null) == check)
                          WeatherBook(
                            id: widget.id,
                            latitude: latitude!,
                            longitude: longitude!,
                            city: city!,
                          )
                        else
                          _defaultPage()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Stack(
            children: <Widget>[
              Align(
                alignment:
                Alignment(Alignment.bottomRight.x, Alignment.bottomRight.y),
                child: FloatingActionButton(
                  heroTag: 'chat',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen()),
                    );
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: Image.asset(
                    "assets/toggle/Button_chatbot.png",
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
                'assets/icon/plus.png',
                scale: 4,
              ),
          ),
        ),
      ],
    );
  }
}
