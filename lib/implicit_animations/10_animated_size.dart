import 'package:flutter/material.dart';

//ANIMATED SIZE

class AnimatedSizeExample extends StatefulWidget {
  const AnimatedSizeExample({super.key});

  @override
  State<AnimatedSizeExample> createState() => _AnimatedSizeExampleState();
}

class _AnimatedSizeExampleState extends State<AnimatedSizeExample> {
  bool _isSelected = false;
  Duration duration = Duration(seconds: 1);
  Curve curve = Curves.easeIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        child: ColoredBox(
          color: Colors.amberAccent,
          child: AnimatedSize(
            duration: duration,
            curve: curve,
            child: SizedBox.square(
              dimension: _isSelected ? 250.0 : 100.0,
              child: const Center(child: FlutterLogo(size: 75.0)),
            ),
          ),
        ),
      ),
    );
  }
}