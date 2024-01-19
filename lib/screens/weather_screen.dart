// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:weather_app_using_api/model/whather_model.dart';
import 'package:weather_app_using_api/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('2c2b9358bb5f5967a9409f42aea2f975');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // if there are any errors
    catch (e) {
      print(e);
    }
  }
  // weather animations

  // initial state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // city name
          Text(_weather?.cityName ?? 'loading city ...'),

          // temperature
          Text('${_weather?.temperature.round()}°C')
        ],
      ),
    ));
  }
}
