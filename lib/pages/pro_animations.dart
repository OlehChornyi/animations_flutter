import 'package:animations_flutter/pro_animations/1_pro_navbar.dart';
import 'package:animations_flutter/pro_animations/2_intro_screen.dart';
import 'package:animations_flutter/pro_animations/3_hero_widget.dart';
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
              child: Text('Pro NavBar'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, const IntroScreen1()),
              child: Text('Intro Screen'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, const HeroFrom()),
              child: Text('Hero Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
