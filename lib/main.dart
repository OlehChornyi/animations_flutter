import 'package:animations_flutter/implicit_animations/2_shape_shifting.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //ANIMATED OPACITY
      // home: const FadeIn(),
      //ANIMATED CONTAINER
      home: const ShapeShifting(),
    );
  }
}
