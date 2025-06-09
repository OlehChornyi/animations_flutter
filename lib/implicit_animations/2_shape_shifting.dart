import 'dart:math';

import 'package:flutter/material.dart';

//ANIMATED CONTAINER

double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class ShapeShifting extends StatefulWidget {
  const ShapeShifting({super.key});

  @override
  State<ShapeShifting> createState() => _ShapeShiftingState();
}

class _ShapeShiftingState extends State<ShapeShifting> {
  late Color color;
  late double borderRadius;
  late double margin;

  @override
  void initState() {
    super.initState();
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();
  }

  void change() {
    setState(() {
      color = randomColor();
      borderRadius = randomBorderRadius();
      margin = randomMargin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Change'),
              onPressed: () => change(),
            ),
            SizedBox(
              width: 128,
              height: 128,
              child: Container(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: EdgeInsets.all(margin),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
