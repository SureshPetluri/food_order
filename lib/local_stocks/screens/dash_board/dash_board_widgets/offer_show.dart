import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OffersShowBadge extends StatelessWidget {
  final double size;
  final Widget child;
  final String text;
  final double iconSize;
  final Color iconColor;
  final VoidCallback? onTap;

  const OffersShowBadge({super.key,
    required this.size,
    required this.child,
    required this.text,
    this.iconSize = 24,
    this.iconColor = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 1,
          right:1,
          child: CustomPaint(
            painter: TrianglePainter(Color(0xff99EEFF).withOpacity(0.5)),
            size: Size(size, size),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(

              margin: const EdgeInsets.all(10),
              width: MediaQuery.sizeOf(context).width > 750 ? MediaQuery.sizeOf(context).width * 0.1 : MediaQuery.sizeOf(context).width * 0.1,
              // height: MediaQuery.sizeOf(context).height * 0.06,
              child: Text(
                  'resume.new'.tr(args: [text]),//"New Collection $text off",
                style: TextStyle(color: Colors.brown,
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.sizeOf(context).width > 750 ? 18 :9,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}
