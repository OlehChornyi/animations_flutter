import 'package:flutter/material.dart';

//ANIMATED CROSS FADE

class AnimatedCrossFadeExample extends StatefulWidget {
  const AnimatedCrossFadeExample({super.key});

  @override
  State<AnimatedCrossFadeExample> createState() =>
      _AnimatedCrossFadeExampleState();
}

class _AnimatedCrossFadeExampleState extends State<AnimatedCrossFadeExample> {
  bool _first = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          AnimatedCrossFade(
            duration: const Duration(seconds: 3),
            firstChild: const FlutterLogo(
              style: FlutterLogoStyle.horizontal,
              size: 100.0,
            ),
            secondChild: const FlutterLogo(
              style: FlutterLogoStyle.stacked,
              size: 100.0,
            ),
            crossFadeState:
                _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
          ElevatedButton(
            child: const Text('Change padding'),
            onPressed: () {
              setState(() {
                _first = !_first;
              });
            },
          ),
        ],
      ),
    );
  }
}
