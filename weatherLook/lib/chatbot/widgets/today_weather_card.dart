import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';


class TodayWeatherCard extends StatelessWidget {
  final List<List<WeatherData>> groupedWeatherDataList;
  TodayWeatherCard({required this.groupedWeatherDataList});


  Widget mainImage(String mainWeather) {
    if(mainWeather=="Clouds"){
      return Image.asset("assets/clouds.png",width: 30,height: 30,);
    }else if(mainWeather=="Rain"){
      return Image.asset("assets/rainy.png",width: 30,height: 30,);
    }else if(mainWeather=="Snow"){
      return Image.asset("assets/snow.png",width: 30,height: 30,);
    }else if(mainWeather=="Clear"){
      return Image.asset("assets/sun.png",width: 30,height: 30,);
    }
    return Image.asset("assets/cloud_sun.png",width: 30,height: 30,);
  }

  late String? dd="";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      //color: Color(0xffD9D9D9),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: groupedWeatherDataList.length,
        itemBuilder: (context, index) {
          final weatherDataList = groupedWeatherDataList[index];
          return Row(
            children: [
              ...weatherDataList.map((weatherData) {
                String mainWeather = weatherData.main;
                String formattedDate = weatherData.time.toString().split(' ')[0];
                String formattedTime = weatherData.time.toString().split(' ')[1];
                //print(formattedDate);
                //print(formattedTime);
                List<String> dateParts = formattedDate.split('-');
                List<String> timeParts = formattedTime.split(':');
                String finalDate = '${dateParts[0]}-${dateParts[1]}-${dateParts[2]}';
                String finalTime = '${timeParts[0]}:${timeParts[1]}';

                dd = dd! + "날짜 및 시간: $finalDate $finalTime, 날씨: $mainWeather, 최고 온도: ${weatherData.maxTemperature.toStringAsFixed(1)}°C, 최저 온도: ${weatherData.minTemperature.toStringAsFixed(1)}°C, 강수 확률: ${(weatherData.pop*100).toInt()}%, 습도: ${weatherData.humidity.toInt()}% \n";
                print(dd);

                return Container(
                  width: 150,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    color: Color(0xffD9D9D9),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mainImage(mainWeather),
                          Text('\n$finalDate $finalTime\n'),
                          Text('최고 온도: ${weatherData.maxTemperature.toStringAsFixed(1)}°C'),
                          Text('최저 온도: ${weatherData.minTemperature.toStringAsFixed(1)}°C'),
                          Text('강수 확률: ${(weatherData.pop*100).toInt()}%'),
                          Text('습도: ${weatherData.humidity.toInt()}%'),
                          // 추가적인 날씨 정보나 스타일링을 원하는 경우 여기에 추가
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}

