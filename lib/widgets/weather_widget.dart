import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../providers/weather_provider.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<ThemeProvider>(context).darkTheme;
    int temperature = Provider.of<WeatherData>(context).temperature;
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        key: const Key("weatherDataState"),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            Provider.of<WeatherData>(context).weatherIcon,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 300 ? 18 : 22,
                color: isDarkTheme ? Colors.white : Colors.black),
          ),
          const SizedBox(width: 2),
          Text(
            temperature != 404 ? "$temperature°C" : "",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 300 ? 14 : 16,
                color: isDarkTheme ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
