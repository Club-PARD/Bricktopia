import 'dart:math';

class Weather {
  final String city;
  final double temp;
  final double feelsLike;
  final double temp_min;
  final double temp_max;
  final String description;
  final double pop;
  final String icon;

  final String weather;
  final int humidity;
  final double lat;
  final double lon;

  final List<double> hourly_temp;
  final List<String> hourly_icon;
  final List<DateTime> hourly_dt;
  final List<double> daily_min_temp;
  final List<double> daily_max_temp;
  final List<double> daily_pop;
  final List<String> daily_most_occuring_icons;

  Weather({
    required this.city,
    required this.temp,
    required this.feelsLike,
    required this.temp_min,
    required this.temp_max,
    required this.description,
    required this.pop,
    required this.icon,
    required this.weather,
    required this.humidity,
    required this.lat,
    required this.lon,
    required this.hourly_temp,
    required this.hourly_icon,
    required this.hourly_dt,
    required this.daily_min_temp,
    required this.daily_max_temp,
    required this.daily_pop,
    required this.daily_most_occuring_icons,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    Map<String, List<double>> tempByDate = {};
    Map<String, List<double>> popByDate = {};
    Map<String, List<String>> iconByDate = {};
    List<dynamic> list = json['list'];
    List<double> hListTemp = [];
    List<String> hListIcon = [];
    List<DateTime> hListDt = [];
    List<double> hListPop = [];

    for (int i = 0; i < list.length; i++) {
      double temperature = list[i]['main']['temp'].toDouble();
      String weatherIcon = list[i]['weather'][0]['icon'];
      double pop = list[i]['pop'].toDouble();
      int timestamp = list[i]['dt'];
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      String date = dateTime.toString().split(' ')[0];

      if (tempByDate.containsKey(date)) {
        tempByDate[date]!.add(temperature);
        popByDate[date]!.add(pop);
        iconByDate[date]!.add(weatherIcon);
      } else {
        tempByDate[date] = [temperature];
        popByDate[date] = [pop];
        iconByDate[date] = [weatherIcon];
      }
      hListTemp.add(temperature);
      hListIcon.add(weatherIcon);
      hListDt.add(dateTime);
      hListPop.add(pop);
    }
    List<DateTime> distinctDates = hListDt.toSet().toList();
    List<double> dMinTemp = [];
    List<double> dMaxTemp = [];
    List<double> dAvgPop = [];
    List<String> dMostOccurringIcons = [];

    for (DateTime date in distinctDates) {
      List<double> temperatures = [];
      List<double> pops = [];
      List<String> icons = [];

      for (int i = 0; i < hListDt.length; i++) {
        if (hListDt[i].year == date.year &&
            hListDt[i].month == date.month &&
            hListDt[i].day == date.day) {
          temperatures.add(hListTemp[i]);
          pops.add(hListPop[i]);
          icons.add(hListIcon[i]);
        }
      }

      dMinTemp.add(temperatures.reduce(min));
      dMaxTemp.add(temperatures.reduce(max));
      double avgPop = pops.reduce((a, b) => a + b) / pops.length;
      dAvgPop.add(avgPop);

      // Find the most occurring icon
      Map<String, int> iconCounts = {};
      for (String icon in icons) {
        iconCounts[icon] = (iconCounts[icon] ?? 0) + 1;
      }
      int maxCount = 0;
      String mostOccurringIcon = '';
      for (String icon in iconCounts.keys) {
        if (iconCounts[icon]! > maxCount) {
          maxCount = iconCounts[icon]!;
          mostOccurringIcon = icon;
        }
      }
      dMostOccurringIcons.add(mostOccurringIcon);
    }

    return Weather(
      city: json['city']['name'],
      temp: json['list'][0]['main']['temp'].toDouble(),
      feelsLike: json['list'][0]['main']['feels_like'].toDouble(),
      temp_min: json['list'][0]['main']['temp_min'].toDouble(),
      temp_max: json['list'][0]['main']['temp_max'].toDouble(),
      description: json['list'][0]['weather'][0]['description'],
      pop: json['list'][0]['pop'].toDouble(),
      icon: json['list'][0]['weather'][0]['icon'],
      weather: json['list'][0]['weather'][0]['main'],
      humidity: json['list'][0]['main']['humidity'],
      lat: json['city']['coord']['lat'].toDouble(),
      lon: json['city']['coord']['lon'].toDouble(),
      hourly_dt: hListDt,
      hourly_icon: hListIcon,
      hourly_temp: hListTemp,
      daily_min_temp: dMinTemp,
      daily_max_temp: dMaxTemp,
      daily_pop: dAvgPop,
      daily_most_occuring_icons: dMostOccurringIcons,
    );
  }
}
