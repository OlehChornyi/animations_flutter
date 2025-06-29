import 'package:animations_flutter/layout_animations/widgets/3d_button.dart';
import 'package:animations_flutter/layout_animations/widgets/animated_button.dart';
import 'package:animations_flutter/layout_animations/widgets/animated_gradient_button.dart';
import 'package:animations_flutter/layout_animations/widgets/floating_menu.dart';
import 'package:animations_flutter/layout_animations/widgets/radial_gauge.dart';
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
            const SizedBox(height: 48),
            AnimatedGradientButton(
              leftColor: const Color.fromARGB(255, 93, 216, 5),
              rightColor: const Color.fromARGB(255, 4, 129, 164),
              duration: const Duration(milliseconds: 800),
              textStyle: TextStyle(color: Colors.white),
              text: "Login",
              ontap: () {
                print("Hello World!");
              },
            ),
            const SizedBox(height: 48),
            const ThreeDButton(),
            MyCustomRadialGauge(),
          ],
        ),
      ),
      floatingActionButton: FloatingMenu(
        speedDialChildren: [
          SpeedDialChild(child: Icon(Icons.phone), onPressed: () {}),
          SpeedDialChild(child: Icon(Icons.apple), onPressed: () {}),
          SpeedDialChild(child: Icon(Icons.travel_explore), onPressed: () {}),
          SpeedDialChild(child: Icon(Icons.toys), onPressed: () {}),
        ],
        type: FloatingBtnType.top,
      ),
    );
  }
}
