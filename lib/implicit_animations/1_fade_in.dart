import 'package:flutter/material.dart';

//ANIMATED OPACITY

const owlUrl =
    'https://raw.githubusercontent.com/flutter/website/main/src/content/assets/images/docs/owl.jpg';

class FadeIn extends StatefulWidget {
  const FadeIn({super.key});

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Image.network(owlUrl),
          TextButton(
            child: const Text(
              'Show Details',
              style: TextStyle(color: Colors.blueAccent),
            ),
            onPressed:
                () => setState(() {
                  if (opacity == 1) {
                    opacity = 0;
                  } else {
                    opacity = 1;
                  }
                }),
          ),
          const Column(
            children: [
              Text('Type: Owl'),
              Text('Age: 39'),
              Text('Employment: None'),
            ],
          ),
          AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: opacity,
            child: const Column(
              children: [
                Text('Type: Owl'),
                Text('Age: 39'),
                Text('Employment: None'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
