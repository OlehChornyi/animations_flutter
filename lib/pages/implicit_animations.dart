import 'package:animations_flutter/implicit_animations/10_animated_size.dart';
import 'package:animations_flutter/implicit_animations/11_animated_switcher.dart';
import 'package:animations_flutter/implicit_animations/1_fade_in.dart';
import 'package:animations_flutter/implicit_animations/2_shape_shifting.dart';
import 'package:animations_flutter/implicit_animations/3_animated_align.dart';
import 'package:animations_flutter/implicit_animations/4_animated_scale.dart';
import 'package:animations_flutter/implicit_animations/5_animated_rotation.dart';
import 'package:animations_flutter/implicit_animations/6_animated_slide.dart';
import 'package:animations_flutter/implicit_animations/7_animated_padding.dart';
import 'package:animations_flutter/implicit_animations/8_animated_positioned.dart';
import 'package:animations_flutter/implicit_animations/9_animated_cross_fade.dart';
import 'package:flutter/material.dart';

class ImplicitAnimations extends StatefulWidget {
  const ImplicitAnimations({super.key});

  @override
  State<ImplicitAnimations> createState() => _ImplicitAnimationsState();
}

class _ImplicitAnimationsState extends State<ImplicitAnimations> {
  void navigator(BuildContext context, Widget screen) => Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => screen));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Implicit Animations'),
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
            ElevatedButton(
              onPressed:
                  () => navigator(context, const AnimatedSlideExample()),
              child: Text('Animated Slide'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(context, const AnimatedPaddingExample()),
              child: Text('Animated Padding'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(context, const AnimatedPositionedExample()),
              child: Text('Animated Positioned'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(context, const AnimatedCrossFadeExample()),
              child: Text('Animated CrossFade'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(context, const AnimatedSizeExample()),
              child: Text('Animated Size'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(context, const AnimatedSwitcherExample()),
              child: Text('Animated Switcher'),
            ),
          ],
        ),
      ),
    );
  }
}
