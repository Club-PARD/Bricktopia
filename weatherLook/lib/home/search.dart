import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:translator/translator.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../chatbot/models/weather_model.dart';
import 'add_show_location.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  Map<String, dynamic>? _selectedLocation;

  get selectedLocation => _selectedLocation;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final translator = GoogleTranslator();
  List<List<WeatherData>> groupedWeatherDataList = [];
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '122344';
  List<dynamic>? _placesList = [];
  Map<String, dynamic>? _selectedLocation;

  get selectedLocation => _selectedLocation;
  bool _isDisposed = false; // dispose()가 호출되었는지 여부를 확인하기 위한 변수
  //String? city;

  @override
  void dispose() {
    _isDisposed = true; // dispose()가 호출된 상태로 변경
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggesion(_controller.text);
  }

  void getSuggesion(String input) async {
    if (_isDisposed) return; // dispose()가 호출된 경우, setState() 호출을 피합니다.

    // 이하 코드는 동일합니다.
    String kPLACES_API_KEY = "AIzaSyACJPYK1YH-CGunm0fAR84vYuMgw2QFSa8";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();

    print(response.body.toString());
    if (response.statusCode == 200) {
      if (_isDisposed) return; // dispose()가 호출된 경우, setState() 호출을 피합니다.

      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Fail to load data');
    }
  }

  void onLocationSelected(Location location, String placeName) {
    if (_isDisposed) return; // dispose()가 호출된 경우, setState() 호출을 피합니다.

    setState(() {
      _selectedLocation = {
        'placeName': placeName,
        'latitude': location.latitude,
        'longitude': location.longitude,
      };
    });
  }

  Future<bool> _onBackPressed() {
    if (_selectedLocation != null) {
      Navigator.pop(context, _selectedLocation);
    }
    return Future.value(true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: (MediaQuery.of(context).size.height) / 10),
            Container(
              width: (MediaQuery.of(context).size.width) / 1.184,
              height: (MediaQuery.of(context).size.height) / 18.18,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffD9D5FC).withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffD9D5FC))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffD9D5FC))),
                  hintText: '지역 검색',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.black, size: 30),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placesList!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      List<Location> locations = await locationFromAddress(
                          _placesList![index]['description']);
                      String placeName = _placesList![index]['description'];
                      onLocationSelected(locations.last, placeName);
                    },
                    title: Text(_placesList![index]['description']),
                    trailing: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () async {
                        List<Location> locations = await locationFromAddress(
                            _placesList![index]['description']);
                        String placeName = _placesList![index]['description'];
                        onLocationSelected(locations.last, placeName);

                        double? longitude = locations.last.longitude;
                        double? latitude = locations.last.latitude;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddShowLocation(
                              longitude: longitude,
                              latitude: latitude,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
