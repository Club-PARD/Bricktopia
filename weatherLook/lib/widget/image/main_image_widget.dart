import 'package:flutter/material.dart';

Widget mainImage(BuildContext context, String mainWeather) {
  if (mainWeather == "Clouds") {
    return Image.asset("assets/weather/03d.png",
        width: (MediaQuery.of(context).size.width) / 3.1583, fit: BoxFit.cover);
  } else if (mainWeather == "FewClouds") {
    return Image.asset("assets/weather/02d.png",
        width: (MediaQuery.of(context).size.width) / 3.1583, fit: BoxFit.cover);
  } else if (mainWeather == "Rain") {
    return Image.asset("assets/weather/09d.png",
        width: (MediaQuery.of(context).size.width) / 3.1583, fit: BoxFit.cover);
  } else if (mainWeather == "Snow") {
    return Image.asset("assets/weather/13d.png",
        width: (MediaQuery.of(context).size.width) / 3.1583, fit: BoxFit.cover);
  } else if (mainWeather == "Clear") {
    return Image.asset("assets/weather/01d.png",
        width: (MediaQuery.of(context).size.width) / 3.1583, fit: BoxFit.cover);
  } else if (mainWeather == "Thunderstorm") {
    return Image.asset("assets/sun.png",
        width: (MediaQuery.of(context).size.width) / 3.1583, fit: BoxFit.cover);
  }
  //  else if (mainWeather == "Night") {
  //   return Image.asset("assets/sun.png",
  //       width: (MediaQuery.of(context).size.width) / 3.1583,
  //       fit: BoxFit.cover);
  // }
  return Container();
}
