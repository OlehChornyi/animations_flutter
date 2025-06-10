import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({super.key, required this.controller})
    : opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.100, curve: Curves.ease),
        ),
      ),

      width = Tween<double>(begin: 50.0, end: 150.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.125, 0.250, curve: Curves.ease),
        ),
      ),

      height = Tween<double>(begin: 50.0, end: 150.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.250, 0.375, curve: Curves.ease),
        ),
      ),

      padding = EdgeInsetsTween(
        begin: EdgeInsets.all(10.0),
        end: EdgeInsets.all(80),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.250, 0.375, curve: Curves.ease),
        ),
      ),

      borderRadius = BorderRadiusTween(
        begin: BorderRadius.circular(4),
        end: BorderRadius.circular(75),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.375, 0.500, curve: Curves.ease),
        ),
      ),

      color = ColorTween(
        begin: Color.fromARGB(255, 59, 7, 230),
        end: Color.fromARGB(255, 226, 6, 6),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.500, 0.750, curve: Curves.ease),
        ),
      );

  final AnimationController controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> padding;
  final Animation<BorderRadius?> borderRadius;
  final Animation<Color?> color;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
            color: color.value,
            border: Border.all(color: Colors.indigo[300]!, width: 3),
            borderRadius: borderRadius.value,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(builder: _buildAnimation, animation: controller);
  }
}

class StaggerDemo extends StatefulWidget {
  @override
  State<StaggerDemo> createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // The animation got canceled, probably because it was disposed of.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staggered Animation')),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              border: Border.all(color: Colors.black.withValues(alpha: 0.5)),
            ),
            child: StaggerAnimation(controller: _controller),
          ),
        ),
      ),
    );
  }
}
