import 'package:flutter/material.dart';
import 'package:weather_summary/pages/weather.dart';
import 'package:weather_summary/widget/image/main_image_widget.dart';

class HomeWeatherWidget extends StatefulWidget {
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final double pop;
  final String city;
  final String weatherMain;

  const HomeWeatherWidget({
    super.key,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.pop,
    required this.city,
    required this.weatherMain,
  });

  @override
  State<HomeWeatherWidget> createState() => _HomeWeatherWidgetState();
}

class _HomeWeatherWidgetState extends State<HomeWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 140),
                    Text(
                      widget.city,
                      style: const TextStyle(
                          fontFamily: 'paybooc Bold', fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: (MediaQuery.of(context).size.height) / 30),
                Text(
                  '${widget.temperature.toInt()}°',
                  style: const TextStyle(
                      fontFamily: 'NanumGothic_Light', fontSize: 36),
                ),
                SizedBox(height: (MediaQuery.of(context).size.height) / 50),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 126),
                    Text(
                      '${widget.minTemperature.toInt()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'paybooc Medium',
                        color: Color(0xff5772D3),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 126),
                    Image.asset('assets/line.png', width: 18),
                    SizedBox(width: MediaQuery.of(context).size.width / 126),
                    Text(
                      '${widget.maxTemperature.toInt()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'paybooc Medium',
                        color: Color(0xffDD5441),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 15.17),
                    Image.asset('assets/rain.png', height: 12.5),
                    SizedBox(width: MediaQuery.of(context).size.width / 63),
                    Text(
                      '${widget.pop.toInt()}%',
                      style: const TextStyle(
                          fontFamily: 'NanumGotihc-Regular',
                          fontSize: 14,
                          color: Color(0xff5772D3)),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeatherPage(),
                      ),
                    );
                  },
                  child: const Text(
                    '날씨 더보기 >',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4E5FFF),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 55,
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: InkWell(
                    radius: 100,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WeatherPage(),
                        ),
                      );
                    },
                    child: mainImage(context, widget.weatherMain),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
