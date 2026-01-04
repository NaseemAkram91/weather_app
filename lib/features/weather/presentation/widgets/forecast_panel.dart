import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/bottom_nav_bar.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../domain/entities/hourly_weather.dart';
import 'custom_divider.dart';
import 'forecast_type_text.dart';
import 'hourly_card.dart';

class ForecastPanel extends StatelessWidget {
  final List<HourlyWeather> hourly;

  const ForecastPanel({super.key, required this.hourly});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xff2E335A).withOpacity(0.7),
                const Color(0xff1C1B33).withOpacity(0.8),
              ],
            ),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    ForecastTypeText(lbl: "Hourly Forecast"),
                    ForecastTypeText(lbl: "Weekly Forecast"),
                  ],
                ),
              ),
              CustomDivider(color: const Color(0xFFD079F8).withOpacity(0.5)),
              const CustomDivider(color: Color(0x4D000000)),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: hourly.length >= 10 ? 10 : hourly.length,
                    separatorBuilder: (context, _) =>
                        const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final item = hourly[index];
                      final label = index == 0
                          ? 'Now'
                          : _formatTime(item.time);
                      return HourlyCard(
                        label: label,
                        temp: item.temperatureC.toStringAsFixed(0),
                        icon: _iconForCondition(item.condition),
                        highlighted: index == 0,
                      );
                    },
                  ),
                ),
              ),
              BottomNavBar()
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '$displayHour $period';
  }

  String _iconForCondition(String condition) {
    final lower = condition.toLowerCase();
    if (lower.contains('rain') || lower.contains('drizzle')) {
      return 'assets/icons/rainy.png';
    }
    if (lower.contains('storm') || lower.contains('thunder')) {
      return 'assets/icons/stormy.png';
    }
    if (lower.contains('snow')) {
      return 'assets/icons/snowy.png';
    }
    if (lower.contains('cloud')) {
      return 'assets/icons/cloudy.png';
    }
    if (lower.contains('clear') && lower.contains('night')) {
      return 'assets/icons/clear.png';
    }
    if (lower.contains('sun') || lower.contains('clear')) {
      return 'assets/icons/sunny.png';
    }
    if (lower.contains('partly')) {
      return 'assets/icons/partly_cloudy.png';
    }
    return 'assets/icons/partly_cloudy.png';
  }
}
