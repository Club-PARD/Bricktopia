import 'dart:math';

class Weather {
  final double temp;
  final double feelsLike;
  final double temp_min;
  final double temp_max;
  final String description;
  final double pop;
  final String icon;
  final List<double> hourly_temp;
  final List<String> hourly_icon;
  final List<DateTime> hourly_dt;
  final List<double> daily_min_temp;
  final List<double> daily_max_temp;
  final List<double> daily_pop;
  final List<String> daily_icon;

  Weather({
    required this.temp,
    required this.feelsLike,
    required this.temp_min,
    required this.temp_max,
    required this.description,
    required this.pop,
    required this.icon,
    required this.hourly_temp,
    required this.hourly_icon,
    required this.hourly_dt,
    required this.daily_min_temp,
    required this.daily_max_temp,
    required this.daily_pop,
    required this.daily_icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
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

      hListTemp.add(temperature);
      hListIcon.add(weatherIcon);
      hListDt.add(dateTime);
      hListPop.add(pop);
    }
    print(hListDt);
    List<DateTime> distinctDates = hListDt.toSet().toList();
    List<double> dMinTemp = [];
    List<double> dMaxTemp = [];
    List<double> dAvgPop = [];
    List<String> dIcon = ['', '', '', '', ''];

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
      //print(hListIcon);
      dMinTemp.add(temperatures.reduce((min)));
      dMaxTemp.add(temperatures.reduce((max)));
      double avgPop = pops.reduce((a, b) => a + b) / pops.length;

      if (!dAvgPop.contains(avgPop)) {
        dAvgPop.add(avgPop);
      }
    }

    return Weather(
      temp: json['list'][0]['main']['temp'].toDouble(),
      feelsLike: json['list'][0]['main']['feels_like'].toDouble(),
      temp_min: json['list'][0]['main']['temp_min'].toDouble(),
      temp_max: json['list'][0]['main']['temp_max'].toDouble(),
      description: json['list'][0]['weather'][0]['description'],
      pop: json['list'][0]['pop'].toDouble(),
      icon: json['list'][0]['weather'][0]['icon'],
      hourly_dt: hListDt,
      hourly_icon: hListIcon,
      hourly_temp: hListTemp,
      daily_min_temp: dMinTemp,
      daily_max_temp: dMaxTemp,
      daily_pop: dAvgPop,
      daily_icon: dIcon,
    );
  }
}
