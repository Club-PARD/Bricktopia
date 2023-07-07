import 'package:flutter/material.dart';

Widget fiveDayImage(String avgWeather) {
  if (avgWeather == "Clouds") {
    return Image.asset("assets/weather_mini/mini_clouds.png", width: 32);
  } else if (avgWeather == "Rain") {
    return Image.asset("assets/weather_mini/mini_rain.png", width: 32);
  } else if (avgWeather == "FewClouds") {
    return Image.asset("assets/weather_mini/mini_cloud_sun.png", width: 32);
  } else if (avgWeather == "Snow") {
    return Image.asset("assets/weather_mini/mini_snow.png", width: 32);
  } else if (avgWeather == "Clear") {
    return Image.asset("assets/weather_mini/mini_sun.png", width: 32);
  } else if (avgWeather == "Thunderstorm") {
    return Image.asset("assets/weather_mini/mini_thunder.png", width: 32);
  }
  // else if (avgWeather == "Night") {
  //   return Image.asset("assets/weather_mini/mini_night.png", width: 32);
  // }
  return Image.asset("assets/cloud_sun.png", width: 32);
}
