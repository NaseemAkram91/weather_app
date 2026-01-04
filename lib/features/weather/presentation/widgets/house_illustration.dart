import 'package:flutter/material.dart';

class HouseIllustration extends StatelessWidget {
  final String condition;
  final double height;

  const HouseIllustration({
    super.key,
    required this.condition,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final assetPath = _houseForCondition(condition);

    return Image.asset(
      assetPath,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => SizedBox(
        height: height,
        child: const Center(
          child: Icon(
            Icons.home,
            size: 100,
            color: Colors.white54,
          ),
        ),
      ),
    );
  }

  String _houseForCondition(String condition) {
    final lower = condition.toLowerCase();
    if (lower.contains('rain')) {
      return 'assets/cw/House-2.png';
    }
    if (lower.contains('cloud')) {
      return 'assets/cw/House-1.png';
    }
    return 'assets/cw/House.png';
  }
}
