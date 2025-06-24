import 'package:flutter/material.dart';

class MyTooltip extends StatefulWidget {
  final GlobalKey targetKey; // The widget the tooltip will point to
  final String message; // The text inside the tooltip

  const MyTooltip({required this.targetKey, required this.message, Key? key})
    : super(key: key);

  @override
  _MyTooltipState createState() => _MyTooltipState();
}

class _MyTooltipState extends State<MyTooltip>
    with SingleTickerProviderStateMixin {
  late OverlayEntry _overlayEntry;
  late AnimationController _animationController;
  bool fitsAbove = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );


  }

  @override
void dispose() {
  _animationController.dispose();
  _overlayEntry.remove();
  super.dispose();
}

  void _showTooltip() {
    // Position tooltip above the target
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: 100.0, // Simplified for now
            left: 50.0, // Simplified for now
            child: Column(
              children: [
                if (!fitsAbove) ArrowWidget(isUpward: true),
                ScaleTransition(
                  scale: CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeOutBack,
                  ),
                  child: FadeTransition(
                    opacity: _animationController,
                    child: Material(
                      color: Colors.blue.withAlpha(50),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                if (fitsAbove) ArrowWidget(isUpward: false),
              ],
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry);
    _animationController.forward();
  }

  void _updateTooltipPosition() {
    final RenderBox targetBox =
        widget.targetKey.currentContext!.findRenderObject() as RenderBox;
    final Size targetSize = targetBox.size;
    final Offset targetPosition = targetBox.localToGlobal(Offset.zero);

    final bool fitsAbove = targetPosition.dy >= 100; // Tooltip height
    final bool fitsBelow =
        MediaQuery.of(context).size.height -
            (targetPosition.dy + targetSize.height) >=
        100;

    double topPosition =
        fitsAbove
            ? targetPosition.dy -
                100 // Above the target
            : fitsBelow
            ? targetPosition.dy +
                targetSize
                    .height // Below the target
            : MediaQuery.of(context).size.height /
                2; // Default to the center if neither fits
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _showTooltip,
          child: Container(key: widget.targetKey, child: Icon(Icons.info)),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  final bool isUpward; // Whether the arrow points upward or downward
  final Color color;

  ArrowPainter({required this.isUpward, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final path = Path();
    if (isUpward) {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ArrowWidget extends StatelessWidget {
  final bool isUpward;
  const ArrowWidget({Key? key, this.isUpward = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(20, 10),
      painter: ArrowPainter(isUpward: isUpward, color: Colors.blue),
    );
  }
}
