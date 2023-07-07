String getAvgTempString(double minTemp, double maxTemp) {
  String avgRange = '';
  double avgTemp = (maxTemp + minTemp) / 2;
  if (avgTemp < 5) {
    avgRange = '0_to_4';
  } else if (avgTemp >= 5 && avgTemp < 9) {
    avgRange = '5_to_8';
  } else if (avgTemp >= 9 && avgTemp < 12) {
    avgRange = '9_to_11';
  } else if (avgTemp >= 12 && avgTemp < 17) {
    avgRange = '12_to_16';
  } else if (avgTemp >= 17 && avgTemp < 20) {
    avgRange = '17_to_19';
  } else if (minTemp >= 20 && avgTemp < 23) {
    avgRange = '20_to_22';
  } else if (avgTemp >= 23 && avgTemp < 28) {
    avgRange = '23_to_27';
  } else if (avgTemp >= 28) {
    avgRange = '28_to_30';
  }
  return avgRange;
}
