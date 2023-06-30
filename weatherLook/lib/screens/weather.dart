// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:homepage/api/weather_api.dart';
import 'package:homepage/model/weather_model.dart';
import 'package:homepage/widget/hourly_box.dart';
import 'package:homepage/widget/weather_box.dart';
import 'package:homepage/widget/weekly_box.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? _weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot != null) {
                    _weather = snapshot.data;
                    if (_weather == null) {
                      return const Text("Loading weather...");
                    } else {
                      return Column(
                        children: [
                          weatherBox(_weather!),
                          const SizedBox(
                            height: 30,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                8,
                                (index) => HourlyBox(
                                  temp: _weather!.hourly_temp[index],
                                  icon: _weather!.hourly_icon[index],
                                  time: _weather!.hourly_dt[index],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          WeeklyBox(weather: _weather!),
                        ],
                      );
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                future: getCurrentWeather(),
              ),
            ],
          ),
        ));
  }
}
