import 'package:animations_flutter/layout_animations/widgets/animated_button.dart';
import 'package:flutter/material.dart';

class AnimatedWidgets extends StatelessWidget {
  const AnimatedWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedButton(
              text: "Click Me",
              onPressed: () => print("Button Pressed"),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
