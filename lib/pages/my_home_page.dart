import 'package:animations_flutter/implicit_animations/1_fade_in.dart';
import 'package:animations_flutter/implicit_animations/2_shape_shifting.dart';
import 'package:animations_flutter/implicit_animations/3_animated_align.dart';
import 'package:animations_flutter/implicit_animations/4_animated_scale.dart';
import 'package:animations_flutter/implicit_animations/5_animated_rotation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void navigator(BuildContext context, Widget screen) => Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => screen));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed:
                  () => navigator(context, const FadeIn()),
              child: Text('Animated Opacity'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(context, const ShapeShifting()),
              child: Text('Animated Container'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(context, const AnimatedAlignExample()),
              child: Text('Animated Align'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(context, const LogoScale()),
              child: Text('Animated Scale'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(context, const LogoRotate()),
              child: Text('Animated Rotation'),
            ),
          ],
        ),
      ),
    );
  }
}
