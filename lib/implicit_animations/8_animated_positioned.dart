import 'package:flutter/material.dart';

//ANIMATED POSITIONED 

class AnimatedPositionedExample extends StatefulWidget {
  const AnimatedPositionedExample({super.key});

  @override
  State<AnimatedPositionedExample> createState() => _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
  bool selected = false;
  Duration duration = Duration(seconds: 2);
  Curve curve = Curves.fastOutSlowIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: 200,
        height: 350,
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              width: selected ? 200.0 : 50.0,
              height: selected ? 50.0 : 200.0,
              top: selected ? 50.0 : 150.0,
              duration: duration,
              curve: curve,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = !selected;
                  });
                },
                child: const ColoredBox(color: Colors.blue, child: Center(child: Text('Tap me'))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}