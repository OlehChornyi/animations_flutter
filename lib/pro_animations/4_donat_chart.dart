import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class DataItem {
  final double value;
  final String label;
  final Color color;
  DataItem(this.value, this.label, this.color);
}

const pal = [0xFFF2387C, 0xFF05C7F2, 0xFF04D9C4, 0xFFF2B705, 0xFFF26241];

class DonatChart extends StatelessWidget {
  final List<DataItem> dataset = [
    DataItem(0.2, "Comedy", Color(pal[0])),
    DataItem(0.25, "Action", Color(pal[1])),
    DataItem(0.3, "Romance", Color(pal[2])),
    DataItem(0.05, "Drama", Color(pal[3])),
    DataItem(0.2, "SciFi", Color(pal[4])),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: DonutChartWidget(dataset)),
    );
  }
}

class DonutChartWidget extends StatefulWidget {
  final List<DataItem> dataset;
  DonutChartWidget(this.dataset);
  @override
  _DonutChartWidgetState createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> {
  late Timer timer;
  double fullAngle = 0.0;
  double secondsToComplete = 3.0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1000 ~/ 60), (timer) {
      setState(() {
        fullAngle += 360.0 / (secondsToComplete * 1000 ~/ 60);
        if (fullAngle >= 360.0) {
          fullAngle = 360.0;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Container(),
        painter: DonutChartPainter(widget.dataset, fullAngle),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final List<DataItem> dataset;
  final double foolAngle;
  DonutChartPainter(this.dataset, this.foolAngle);
  Paint midPaint = Paint();
  TextStyle textFieldTextBigStyle = TextStyle(fontSize: 24);
  TextStyle labelStyle = TextStyle(fontSize: 12);

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2.0, size.height / 2.0);
    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);
    final fullAngle = this.foolAngle;
    var startAngle = 0.0;

    //draw sectors
    dataset.forEach((di) {
      final sweepAngle = di.value * fullAngle * pi / 180.0;
      drawSector(canvas, di, rect, startAngle, sweepAngle);
      drawLabels(canvas, c, radius, startAngle, sweepAngle, di.label);
      startAngle += sweepAngle;
    });

    // draw the middle
    canvas.drawCircle(c, radius * 0.3, midPaint);

    // draw title
    drawTextCentered(
      canvas,
      c,
      "Favourite\nMovie\nGenres",
      textFieldTextBigStyle,
      radius * 0.6,
      (Size sz) {},
    );
  }

  void drawSector(
    Canvas canvas,
    DataItem di,
    Rect rect,
    double startAngle,
    double sweepAngle,
  ) {
    final paint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = di.color;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

  TextPainter measureText(
    String s,
    TextStyle style,
    double maxWidth,
    TextAlign align,
  ) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(
      text: span,
      textAlign: align,
      textDirection: TextDirection.ltr,
    );
    // ellipsis: "...");
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  Size drawTextCentered(
    Canvas canvas,
    Offset position,
    String text,
    TextStyle style,
    double maxWidth,
    Function(Size sz) bgCb,
  ) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);
    bgCb(tp.size);
    tp.paint(canvas, pos);
    return tp.size;
  }

  void drawLabels(
    Canvas canvas,
    Offset c,
    double radius,
    double startAngle,
    double sweepAngle,
    String label,
  ) {
    final r = radius * 0.4;
    final dx = r * cos(startAngle + sweepAngle / 2.0);
    final dy = r * sin(startAngle + sweepAngle / 2.0);
    final position = c + Offset(dx, dy);
    drawTextCentered(canvas, position, label, labelStyle, 100.0, (Size sz) {
      final rect = Rect.fromCenter(
        center: position,
        width: sz.width + 5,
        height: sz.height + 5,
      );
      final rrect = RRect.fromRectAndRadius(rect, Radius.circular(5));
      canvas.drawRRect(rrect, midPaint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
