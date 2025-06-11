import 'package:animations_flutter/explicit_animations/10_physics_card_drag.dart';
import 'package:animations_flutter/explicit_animations/11_gradient_transition.dart';
import 'package:animations_flutter/explicit_animations/12_registration_form.dart';
import 'package:animations_flutter/explicit_animations/1_explicit_animation.dart';
import 'package:animations_flutter/explicit_animations/2_staggered_animation.dart';
import 'package:animations_flutter/explicit_animations/3_hero_animation.dart';
import 'package:animations_flutter/explicit_animations/4_repeating_animation.dart';
import 'package:animations_flutter/explicit_animations/5_list_animation.dart';
import 'package:animations_flutter/explicit_animations/6_card_swipe.dart';
import 'package:animations_flutter/explicit_animations/7_carousel.dart';
import 'package:animations_flutter/explicit_animations/8_curved_animation.dart';
import 'package:animations_flutter/explicit_animations/9_expand_card.dart';
import 'package:flutter/material.dart';

class ExplicitAnimations extends StatefulWidget {
  const ExplicitAnimations({super.key});

  @override
  State<ExplicitAnimations> createState() => _ExplicitAnimationsState();
}

class _ExplicitAnimationsState extends State<ExplicitAnimations> {
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
              onPressed: () => navigator(context, const ExplicitAnimation()),
              child: Text('Explitit Animation'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, StaggerDemo()),
              child: Text('Staggered Animation'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, HeroAnimation()),
              child: Text('Hero Animation'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, RepeatingAnimationDemo()),
              child: Text('Repeating Animation'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, AnimatedListDemo()),
              child: Text('List Animation'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, CardSwipeDemo()),
              child: Text('Card Swipe'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, CarouselDemo()),
              child: Text('Carousel'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, CurvedAnimationDemo()),
              child: Text('Curved Animation'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, ExpandCardDemo()),
              child: Text('Expand Card'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, PhysicsCardDragDemo()),
              child: Text('Physics Card Drag'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, GradientTransition()),
              child: Text('Gradient Transition'),
            ),
            ElevatedButton(
              onPressed: () => navigator(context, RegistrationForm()),
              child: Text('Registration Form'),
            ),
          ],
        ),
      ),
    );
  }
}
