import 'package:flutter/material.dart';

class HomeWeather extends StatelessWidget {
  const HomeWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8), // 그림자 색상
            spreadRadius: 2, // 그림자의 퍼지는 정도
            blurRadius: 5, // 그림자의 흐림 정도
            offset: const Offset(0, 3), // 그림자의 위치 (수평, 수직)
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 70,
                child: InkWell(
                  radius: 70,
                  onTap: () {
                    Navigator.pushNamed(context, '/weather');
                  },
                  child: Image.asset(
                    "icon/icon_cloud_sun.png",
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "24°",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 5,
              ),
              Image.asset(
                "assets/rain.png",
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "30%",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "어제보다 쌀쌀할 예정",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
