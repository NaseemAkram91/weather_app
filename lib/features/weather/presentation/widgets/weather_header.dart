import 'package:flutter/material.dart';

import '../../domain/entities/weather.dart';

class WeatherHeader extends StatelessWidget {
  final Weather weather;

  const WeatherHeader({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          weather.city,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            height: 1.0,
          ),
        ),
        Text(
          '${weather.current.temperatureC.toStringAsFixed(0)}°',
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w300,
            color: Colors.white,
            height: 1.0,
          ),
        ),
        Text(
          weather.current.condition,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xadbaaeae),
            height: 1.0,
          ),
        ),
        Text(
          'H:${weather.current.highC.toStringAsFixed(0)}° L:${weather.current.lowC.toStringAsFixed(0)}°',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
