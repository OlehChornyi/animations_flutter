import 'package:animations_flutter/layout_animations/appbar_search.dart';
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
          ],
        ),
      ),
    );
  }
}
