import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final Color color;
  const CustomDivider({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, width: double.infinity, color: color);
  }
}
