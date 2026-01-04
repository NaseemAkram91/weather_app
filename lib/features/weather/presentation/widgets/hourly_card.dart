import 'package:flutter/material.dart';

class HourlyCard extends StatelessWidget {
  final String label;
  final String temp;
  final String icon;
  final bool highlighted;

  const HourlyCard({
    super.key,
    required this.label,
    required this.temp,
    required this.icon,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      height: 150,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0x33FFFFFF)),
        color: const Color(0x3348319D),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textAlign: TextAlign.center,
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Image.asset(icon, height: 32, width: 32),
            Text(
              '$temp°',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
