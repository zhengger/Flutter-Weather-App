import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather/provider/weather_provider.dart';
import 'package:weather/screens/detail_screen.dart';
import 'package:weather/widgets/animated_current_weather.dart';
import 'package:weather/widgets/weekly_weather_row.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context).items;
    return PageView(
      scrollDirection: Axis.vertical,
      children: [
        Column(
          children: [
            Expanded(
              flex: 5,
              child: AnimatedCurrentWeather(
                toValue: weatherData[0].current.temp,
              ),
            ),
            Expanded(
              child: WeeklyWeatherRow(),
            )
          ],
        ),
        DetailScreen(),
      ],
    );
  }
}
