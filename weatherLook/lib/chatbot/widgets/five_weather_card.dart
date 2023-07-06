import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class FiveWeatherCard extends StatelessWidget {
  final List<WeatherData> weatherDataList;

  const FiveWeatherCard({super.key, required this.weatherDataList});

  Widget mainImage(String mainWeather) {
    if (mainWeather == "Clouds") {
      return Image.asset(
        "assets/clouds.png",
        width: 30,
        height: 30,
      );
    } else if (mainWeather == "Rain") {
      return Image.asset(
        "assets/rainy.png",
        width: 30,
        height: 30,
      );
    } else if (mainWeather == "Snow") {
      return Image.asset(
        "assets/snow.png",
        width: 30,
        height: 30,
      );
    } else if (mainWeather == "Clear") {
      return Image.asset(
        "assets/sun.png",
        width: 30,
        height: 30,
      );
    }
    return Image.asset(
      "assets/cloud_sun.png",
      width: 30,
      height: 30,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataList.length,
        itemExtent: 170,
        itemBuilder: (context, index) {
          final weatherData = weatherDataList[index];
          String mainWeather = weatherData.main;
          String formattedDate = weatherData.time.toString().split(' ')[0];
          List<String> dateParts = formattedDate.split('-');
          String finalDate = '${dateParts[1]}/${dateParts[2]}';

          double humidity = weatherData.humidity;
          int humidityInt = humidity.toInt();

          double pop = weatherData.pop * 100;
          int popInt = pop.toInt();

          return Row(
            children: [
              Container(
                width: 150,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  color: const Color(0xffD9D9D9),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mainImage(mainWeather),
                        Text('\n$finalDate\n'),
                        Text('최고 온도: ${weatherData.maxTemperature}°C'),
                        Text('최저 온도: ${weatherData.minTemperature}°C'),
                        Text('강수 확률: $popInt%'),
                        Text('평균 습도: $humidityInt%'),
                        // 추가적인 날씨 정보나 스타일링을 원하는 경우 여기에 추가
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
