import 'package:flutter/material.dart';

Widget homeImage(BuildContext context, String mainWeather) {
  if (mainWeather == "Clouds") {
    return Image.asset("assets/home/home_clouds.png", fit: BoxFit.cover);
  } else if (mainWeather == "FewClouds") {
    return Image.asset("assets/home/home_cloud_sun.png", fit: BoxFit.cover);
  } else if (mainWeather == "Rain") {
    return Image.asset("assets/home/home_rain.png", fit: BoxFit.cover);
  } else if (mainWeather == "Snow") {
    return Image.asset("assets/home/home_snow.png", fit: BoxFit.cover);
  } else if (mainWeather == "Clear") {
    return Image.asset("assets/home/home_sun.png", fit: BoxFit.cover);
  } else if (mainWeather == "Thunderstorm") {
    return Image.asset("assets/home/home_thunderstorm.png", fit: BoxFit.cover);
  }
  //  else if (mainWeather == "Night") {
  //   return Image.asset("assets/home/home_night.png", fit: BoxFit.cover);
  // }
  return Image.asset("assets/cloud_sun.png", fit: BoxFit.cover);
}
