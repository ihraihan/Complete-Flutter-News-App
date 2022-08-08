import 'package:flutter/material.dart';

import '../services/weather.dart';

class WeatherData with ChangeNotifier {
  WeatherModel weather = WeatherModel();

  int _temperature = 404;
  String _weatherIcon = "";

  int get temperature => _temperature;
  String get weatherIcon => _weatherIcon;

  void setWeatherData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    if (weatherData == null) {
      _temperature = 0;
      _weatherIcon = 'Error';

      return;
    }
    double temp = weatherData['main']['temp'];
    _temperature = temp.toInt();
    var condition = weatherData['weather'][0]['id'];
    _weatherIcon = weather.getWeatherIcon(condition);

    notifyListeners();
  }
}
