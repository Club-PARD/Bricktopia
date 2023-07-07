import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_summary/widget/image/five_day_image_widget.dart';

class FiveDayBookWeatherWidget extends StatefulWidget {
  final List<Map<String, dynamic>> weatherList;

  const FiveDayBookWeatherWidget({super.key, required this.weatherList});

  @override
  State<FiveDayBookWeatherWidget> createState() =>
      _FiveDayBookWeatherWidgetState();
}

class _FiveDayBookWeatherWidgetState extends State<FiveDayBookWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width / 18.95,
            MediaQuery.of(context).size.height / 40,
            MediaQuery.of(context).size.width / 13,
            MediaQuery.of(context).size.height / 90),
        width: MediaQuery.of(context).size.width / 1.13,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(0.5)),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                '    5일간의 날씨',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'paybooc Medium',
                    color: Color(0xff6D6D6D)),
              ),
              Row(
                children: [
                  const Text('최고',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff6D6D6D),
                          fontFamily: 'paybooc Medium')),
                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                  const Text('최저',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff6D6D6D),
                          fontFamily: 'paybooc Medium')),
                  SizedBox(width: MediaQuery.of(context).size.width / 80),
                ],
              ),
            ]),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.weatherList.length,
              itemBuilder: (context, index) {
                final weather = widget.weatherList[index];

                final date = DateTime.parse(weather['date']);
                final isFutureDate = date
                    .isAfter(DateTime.now().subtract(const Duration(days: 1)));

                if (!isFutureDate) {
                  return const SizedBox(); // Skip data from past days
                }

                final isToday = DateTime.now().day == date.day;
                final dayLabel = isToday
                    ? '오늘'
                    : DateFormat('  EEE  ', 'ko_KR').format(date);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 32,
                              MediaQuery.of(context).size.height / 50,
                              MediaQuery.of(context).size.width / 30,
                              MediaQuery.of(context).size.height / 50,
                            ),
                            child: Text(dayLabel,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'baybooc Medium'))),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 15,
                            height: MediaQuery.of(context).size.width / 15,
                            child: fiveDayImage(
                                weather['avgWeatherMain'])), // 아이콘 바꾸기
                        SizedBox(width: MediaQuery.of(context).size.width / 30),
                        if ('${weather['avgPop'].toInt()}%' != '0%')
                          Text('${weather['avgPop'].toInt()}%',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'NanumGothic-Regular',
                                  color: Color(0xff4E5FFF))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${weather['maxTemperature'].toInt()}°',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xffDD5441),
                                fontFamily: 'paybooc Medium')),
                        SizedBox(width: MediaQuery.of(context).size.width / 16),
                        Text('${weather['minTemperature'].toInt()}°',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xff4E5FFF),
                                fontFamily: 'paybooc Medium')),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
