import 'package:animations_flutter/pages/explicit_animations.dart';
import 'package:animations_flutter/pages/implicit_animations.dart';
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
                  () => navigator(context, const ImplicitAnimations()),
              child: Text('Implicit Animations'),
            ),
            ElevatedButton(
              onPressed:
                  () => navigator(context, const ExplicitAnimations()),
              child: Text('Explicit Animations'),
            ),
          ],
        ),
      ),
    );
  }
}
