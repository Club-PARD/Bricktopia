import 'package:flutter/material.dart';

Widget mainImage(BuildContext context, String mainWeather) {
  if (mainWeather == "Clouds") {
    return Image.asset("assets/weather/big_clouds.png");
  } else if (mainWeather == "FewClouds") {
    return Image.asset("assets/weather/big_cloud_sun.png");
  } else if (mainWeather == "Rain") {
    return Image.asset("assets/weather/big_rainy.png");
  } else if (mainWeather == "Snow") {
    return Image.asset("assets/weather/big_snow.png");
  } else if (mainWeather == "Clear") {
    return Image.asset("assets/weather/big_sun.png");
  } else if (mainWeather == "Thunderstorm") {
    return Image.asset("assets/weather/big_thunder.png");
  } else if (mainWeather == "Night") {
    return Image.asset("assets/weather/big_night.png");
  }
  return Image.asset("assets/cloud_sun.png");
}
