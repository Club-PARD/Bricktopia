import 'package:flutter/material.dart';
import 'package:weather_summary/get/get_time_format.dart';
import 'package:weather_summary/widget/image/main_image_widget.dart';

class HourlyWeathertWidget extends StatefulWidget {
  final List<Map<String, dynamic>> weatherList;

  const HourlyWeathertWidget({super.key, required this.weatherList});

  @override
  State<HourlyWeathertWidget> createState() => _HourlyWeathertWidgetState();
}

class _HourlyWeathertWidgetState extends State<HourlyWeathertWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.weatherList.map((weather) {
          final List<Map<String, dynamic>> weatherInfoForDate =
              weather['weatherInfoForDate'];
          return Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: (MediaQuery.of(context).size.width) / 21),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: weatherInfoForDate.map((weatherInfo) {
                          return Container(
                            width: 48,
                            margin: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  formatTime(weatherInfo['time']),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff4E5FFF),
                                    fontFamily: 'NanumGothic-Regular',
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                                SizedBox(
                                  width: 35.5,
                                  height: 35.5,
                                  child: mainImage(
                                    context,
                                    weatherInfo['weatherMain'].toString(),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                                Text(
                                  '${weatherInfo['temperature'].toInt()}°',
                                  style: const TextStyle(
                                    fontSize: 13.734,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff6D6D6D),
                                    fontFamily: 'paybooc Bold',
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
