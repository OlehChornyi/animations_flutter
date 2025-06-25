import 'package:animations_flutter/pro_animations/1_pro_navbar.dart';
import 'package:animations_flutter/pro_animations/2_intro_screen.dart';
import 'package:animations_flutter/pro_animations/3_hero_widget.dart';
import 'package:animations_flutter/pro_animations/4_donat_chart.dart';
import 'package:animations_flutter/pro_animations/5_tooltip_animation.dart';
import 'package:animations_flutter/pro_animations/6_card_flip.dart';
import 'package:animations_flutter/pro_animations/7_card_flip_2.dart';
import 'package:animations_flutter/pro_animations/8_card_swiper.dart';
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
            ElevatedButton(
              onPressed: () => navigator(context, DonatChart()),
              child: Text('Donat Chart Animation'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(
                    context,
                    MyTooltip(
                      targetKey: GlobalKey(),
                      message: 'Flutter Rullez!',
                    ),
                  ),
              child: Text('Tooltip Animation'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, CardFlip()),
              child: Text('Card Flip Animation'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, CardFlipTwo()),
              child: Text('Card Flip 2 Animation'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, CardSwiper()),
              child: Text('Card Swiper Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
