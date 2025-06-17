import 'package:animations_flutter/layout_animations/1_appbar_search.dart';
import 'package:animations_flutter/layout_animations/2_scroll_aware_appbar.dart';
import 'package:animations_flutter/layout_animations/3_custom_appbar.dart';
import 'package:animations_flutter/layout_animations/4_animated_navbar.dart';
import 'package:animations_flutter/layout_animations/5_slide_navbar.dart';
import 'package:animations_flutter/layout_animations/6_animated_widgets.dart';
import 'package:animations_flutter/layout_animations/7_buttons_with_progress.dart';
import 'package:animations_flutter/layout_animations/8_floationg_button_animation.dart';
import 'package:animations_flutter/pro_animations/pro_navbar.dart';
import 'package:flutter/material.dart';

class ProAnimations extends StatefulWidget {
  const ProAnimations({super.key});

  @override
  State<ProAnimations> createState() => _ProAnimationsState();
}

class _ProAnimationsState extends State<ProAnimations> {
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
              onPressed: () => navigator(context, const IconRowPage()),
              child: Text('Pro NavBart'),
            ),
          ],
        ),
      ),
    );
  }
}
