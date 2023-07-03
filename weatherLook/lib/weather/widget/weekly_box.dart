import 'package:flutter/material.dart';
import 'package:homepage/weather/weather_model.dart';

class WeeklyBox extends StatelessWidget {
  final Weather weather;

  const WeeklyBox({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(weather.daily_max_temp);
    //print(weather.daily_min_temp);
    //print(weather.daily_pop);
    return Container(
      margin: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 22,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '5일 간의 날씨',
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xff656565),
                ),
              ),
              Row(
                children: [
                  Text(
                    '최고',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff656565),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '최저',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff656565),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              int hourlyIndex = index * 8;

              if (hourlyIndex >= weather.hourly_dt.length) {
                // Handle out-of-bounds index
                return const SizedBox();
              }
              DateTime dateTime = weather.hourly_dt[index * 8];

              double minTemp = weather.daily_min_temp[hourlyIndex];
              double maxTemp = weather.daily_max_temp[hourlyIndex];

              double pop = weather.daily_pop[index];
              String icon = weather.daily_most_occuring_icons[index];

              String dayOfWeek = '';

              if (index == 0) {
                dayOfWeek = '오늘';
              } else {
                List<String> daysOfWeek = [
                  '  일  ',
                  '  월  ',
                  '  화  ',
                  '  수  ',
                  '  목  ',
                  '  금  ',
                  '  토  '
                ];
                int weekDayIndex = dateTime.weekday % 7;
                dayOfWeek = daysOfWeek[weekDayIndex];
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          dayOfWeek,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Image.asset(
                          'assets/weather/$icon.png',
                          width: 35,
                          height: 35,
                        ),
                        Text(
                          '${(pop * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${maxTemp.toStringAsFixed(0)}°',
                          style: const TextStyle(
                            color: Color(0xffDD5441),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          '${minTemp.toStringAsFixed(0)}°',
                          style: const TextStyle(
                            color: Color(0xff2C83D1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
