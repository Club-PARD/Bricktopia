import 'package:flutter/material.dart';
import '../weather_model.dart';

Widget weatherBox(Weather weather) {
  double pop = weather.pop * 100;

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/weather/${weather.icon}.png',
                  width: 120,
                  height: 120,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/rain.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${pop.toInt()}%',
                      style: const TextStyle(
                        color: Color(0xffD2E7FB),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  weather.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff626262),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "${weather.temp.toStringAsFixed(0)}°",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Color(0xff626262),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      '${weather.daily_max_temp[0].toStringAsFixed(0)}°',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xffDD5441),
                      ),
                    ),
                    Image.asset(
                      'assets/line.png',
                      height: 26,
                    ),
                    Text(
                      '${weather.daily_min_temp[0].toStringAsFixed(0)}°',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff2C83D1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}