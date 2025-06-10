import 'package:flutter/material.dart';

//ANIMATED PADDING

class AnimatedPaddingExample extends StatefulWidget {
  const AnimatedPaddingExample({super.key});

  @override
  State<AnimatedPaddingExample> createState() => _AnimatedPaddingExampleState();
}

class _AnimatedPaddingExampleState extends State<AnimatedPaddingExample> {
  double padValue = 0.0;

  void _updatePadding(double value) {
    setState(() {
      padValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedPadding(
            padding: EdgeInsets.all(padValue),
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              color: Colors.blue,
            ),
          ),
          Text('Padding: $padValue'),
          ElevatedButton(
            child: const Text('Change padding'),
            onPressed: () {
              _updatePadding(padValue == 0.0 ? 100.0 : 0.0);
            },
          ),
        ],
      ),
    );
  }
}