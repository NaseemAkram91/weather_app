import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Inner curve container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: InnerCurveClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff3A3A6A), Color(0xff25244C)],
                  ),
                ),
                height: 100,
                width: double.infinity,
              ),
            ),
          ),

          // The Solid Background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF48319D), Color(0xFF2E3269)],
                  ),
                ),
                height: 115,
                width: double.infinity,
              ),
            ),
          ),
          // The Decorative Stroke (Layered on top)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CustomPaint(
                    size: Size(constraints.maxWidth, 115),
                    painter: CurvePainter(),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Map.svg",
                    ),
                    SvgPicture.asset(
                      "assets/icons/Symbol.svg",
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/plus_button.svg",
                placeholderBuilder: (BuildContext context) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InnerCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();

    // Start top-left
    path.moveTo(0, 0);

    // Top inner curve (dip downward)
    path.quadraticBezierTo(
      w / 2, // center X
      h * .8, // DEPTH (increase for deeper curve)
      w, // end at top-right
      0,
    );

    // Complete rectangle
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    final height = size.height;
    final width = size.width;

    // Start from the bottom left
    path.moveTo(0, height);

    // Initial line to start the curve
    path.lineTo(width * 0.1, height);

    // Left flare curve (concave)
    path.quadraticBezierTo(width * 0.25, height, width * 0.30, height * 0.4);

    // Left shoulder curve (convex)
    path.quadraticBezierTo(width * 0.35, 0, width * 0.45, 0);

    // Flat top
    path.lineTo(width * 0.55, 0);

    // Right shoulder curve (convex)
    path.quadraticBezierTo(width * 0.65, 0, width * 0.70, height * 0.4);

    // Right flare curve (concave)
    path.quadraticBezierTo(width * 0.75, height, width * 0.9, height);

    // Line to the bottom right
    path.lineTo(width, height);

    // Line to close the bottom
    path.lineTo(0, height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7582F4).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path();
    final height = size.height;
    final width = size.width;

    path.moveTo(0, height);
    path.lineTo(width * 0.1, height);
    path.quadraticBezierTo(width * 0.25, height, width * 0.30, height * 0.4);
    path.quadraticBezierTo(width * 0.35, 0, width * 0.45, 0);
    path.lineTo(width * 0.55, 0);
    path.quadraticBezierTo(width * 0.65, 0, width * 0.70, height * 0.4);
    path.quadraticBezierTo(width * 0.75, height, width * 0.9, height);
    path.lineTo(width, height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
