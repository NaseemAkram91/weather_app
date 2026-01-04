import 'package:equatable/equatable.dart';

class DailyWeather extends Equatable {
  final DateTime date;
  final double highC;
  final double lowC;
  final String condition;

  const DailyWeather({
    required this.date,
    required this.highC,
    required this.lowC,
    required this.condition,
  });

  @override
  List<Object?> get props => [date, highC, lowC, condition];
}
