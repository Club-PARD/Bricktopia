import 'package:flutter/material.dart';
import 'package:weather_summary/widget/image/main_image_widget.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final double pop;
  final String weatherDescription;
  final String weatherMain;

  const CurrentWeatherWidget({
    super.key,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.pop,
    required this.weatherDescription,
    required this.weatherMain,
  });

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: (MediaQuery.of(context).size.height) / 12,
        ),
        Center(
          child: SizedBox(
              width: 120,
              height: 120,
              child: mainImage(context, widget.weatherMain)), // 날씨 아이콘
        ),
        SizedBox(
          height: (MediaQuery.of(context).size.height) / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width) / 12),
              child: Column(
                children: [
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) / 40,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/rain.png'),
                              SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width) / 64),
                              Text(
                                '${widget.pop.toInt()}%',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff4E5FFF),
                                  fontFamily: 'NanumGothic-Regular',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.height) / 70,
                          ),
                          Text(
                            widget.weatherDescription,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'NanumGothic-Regular',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${widget.temperature.toInt()}°',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontFamily: 'NanumGothic-Light',
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) / 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.minTemperature.toInt()}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff4E5FFF),
                          fontFamily: 'paybooc Medium',
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 126,
                      ),
                      Image.asset('assets/line.png', width: 18),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 126,
                      ),
                      Text(
                        '${widget.maxTemperature.toInt()}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xffDD5441),
                          fontFamily: 'paybooc Medium',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: (MediaQuery.of(context).size.width) / 8,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
