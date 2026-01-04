import 'package:flutter/material.dart';

class ForecastTypeText extends StatelessWidget {
  final String lbl;
  const ForecastTypeText({
    super.key,
    required this.lbl,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      lbl,
      style: const TextStyle(
        fontSize: 16,
        color: Color(0x98e8d5e0),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
