import 'package:flutter/material.dart';

class HourlyBox extends StatelessWidget {
  final double temp;
  final String icon;
  final DateTime time;

  const HourlyBox({
    required this.temp,
    required this.icon,
    required this.time,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String period = time.hour < 12 ? '오전' : '오후';
    int hour = time.hour % 12 == 0 ? 12 : time.hour % 12;

    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          Text(
            '$period $hour시',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xff6D6D6D),
            ),
          ),
          const SizedBox(height: 8),
          Image.asset(
            'asset/weather/$icon.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 8),
          Text(
            '${temp.toStringAsFixed(0)}°',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xff6D6D6D),
            ),
          ),
        ],
      ),
    );
  }
}
