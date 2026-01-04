import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../domain/entities/weather.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../widgets/widgets.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBody: true,
      extendBodyBehindAppBar: true,
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading || state is WeatherInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WeatherFailure) {
            return _ErrorView(message: state.message);
          }
          if (state is WeatherLoaded) {
            return Stack(
              children: [
                 WeatherBackground(),
                _WeatherView(weather: state.weather),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _WeatherView extends StatelessWidget {
  final Weather weather;

  const _WeatherView({required this.weather});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // House illustration - centered
            Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * .8,
                child: HouseIllustration(
                  condition: weather.current.condition,
                  height: MediaQuery.sizeOf(context).height * 0.35,
                ),
              ),
            ),
            // Weather header - top center
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.topCenter,
                child: WeatherHeader(weather: weather),
              ),
            ),
            // Bottom sheet with forecast and nav bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ForecastPanel(hourly: weather.hourly),
               
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSizes.md),
            ElevatedButton(
              onPressed: () {
                context.read<WeatherBloc>().add(const WeatherRequested());
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
