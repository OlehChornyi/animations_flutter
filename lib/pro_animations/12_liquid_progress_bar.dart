import 'dart:math';
import 'package:flutter/material.dart';

class LiquidProgress extends StatelessWidget {
  const LiquidProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pulsing Message')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LiquidProgressBar(progress: 0.65),
          ],
        ),
      ),
    );
  }
}

class LiquidProgressBar extends StatefulWidget {
  final double progress; // value between 0.0 - 1.0
  final double width;
  final double height;

  const LiquidProgressBar({
    super.key,
    required this.progress,
    this.width = 200,
    this.height = 100,
  });

  @override
  State<LiquidProgressBar> createState() => _LiquidProgressBarState();
}

class _LiquidProgressBarState extends State<LiquidProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _waveController,
        builder: (context, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomPaint(
              painter: _LiquidPainter(
                progress: widget.progress,
                wavePhase: _waveController.value,
              ),
              child: Container(),
            ),
          );
        },
      ),
    );
  }
}

class _LiquidPainter extends CustomPainter {
  final double progress;
  final double wavePhase;

  _LiquidPainter({
    required this.progress,
    required this.wavePhase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent.withAlpha(100)
      ..style = PaintingStyle.fill;

    final path = Path();

    final waveHeight = 10.0;
    final waveLength = size.width;
    final baseHeight = size.height * (1 - progress);

    path.moveTo(0, baseHeight);

    for (double x = 0; x <= size.width; x++) {
      double y = waveHeight * sin(2 * pi * (x / waveLength) + 2 * pi * wavePhase) + baseHeight;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Optional: Draw a border
    final borderPaint = Paint()
      ..color = Colors.blue.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final borderRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(16),
    );

    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _LiquidPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.wavePhase != wavePhase;
  }
}