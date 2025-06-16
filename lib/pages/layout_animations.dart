import 'package:animations_flutter/layout_animations/1_appbar_search.dart';
import 'package:animations_flutter/layout_animations/2_scroll_aware_appbar.dart';
import 'package:animations_flutter/layout_animations/3_custom_appbar.dart';
import 'package:animations_flutter/layout_animations/4_animated_navbar.dart';
import 'package:animations_flutter/layout_animations/5_slide_navbar.dart';
import 'package:animations_flutter/layout_animations/6_animated_widgets.dart';
import 'package:animations_flutter/layout_animations/7_buttons_with_progress.dart';
import 'package:flutter/material.dart';

class LayoutAnimations extends StatefulWidget {
  const LayoutAnimations({super.key});

  @override
  State<LayoutAnimations> createState() => _LayoutAnimationsState();
}

class _LayoutAnimationsState extends State<LayoutAnimations> {
  void navigator(BuildContext context, Widget screen) => Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (context) => screen));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Explicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => navigator(context, const AppbarSearch()),
              child: Text('AppBar Search'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, const ScrollAppBarDemo()),
              child: Text('Scroll-Aware AppBar'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, const StackedAppBar()),
              child: Text('Custom AppBar'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, const AnimatedNavbar()),
              child: Text('Animated Navbar'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, const SlideNavbar()),
              child: Text('Slide Navbar'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, const AnimatedWidgets()),
              child: Text('Animated Widgets'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, const ButtonsWithProgress()),
              child: Text('Buttons With Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
