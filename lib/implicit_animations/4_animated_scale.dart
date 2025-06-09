import 'package:flutter/material.dart';

class LogoScale extends StatefulWidget {
  const LogoScale({super.key});

  @override
  State<LogoScale> createState() => LogoScaleState();
}

class LogoScaleState extends State<LogoScale> {
  double scale = 1.0;

  void _changeScale() {
    setState(() => scale = scale == 1.0 ? 3.0 : 1.0);
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
              onPressed: _changeScale,
              child: const Text('Scale Logo'),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: AnimatedScale(
                scale: scale,
                duration: const Duration(seconds: 2),
                child: const FlutterLogo(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}