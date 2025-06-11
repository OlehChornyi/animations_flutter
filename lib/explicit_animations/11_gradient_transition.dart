import 'package:flutter/material.dart';

class GradientTransition extends StatefulWidget {
  const GradientTransition({Key? key}) : super(key: key);

  @override
  _GradientTransitionState createState() => _GradientTransitionState();
}

class _GradientTransitionState extends State<GradientTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [Colors.purple, Colors.pink, Colors.yellow],
                stops: [0, _controller.value, 1],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}