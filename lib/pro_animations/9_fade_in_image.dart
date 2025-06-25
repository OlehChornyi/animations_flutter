import 'package:flutter/material.dart';

class FadeInImg extends StatelessWidget {
  const FadeInImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fade in Image Example')),
      body: Center(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/hero.jpeg', // Loading animation
          image: 'https://picsum.photos/250?image=9', // Real image
        ),
      ),
    );
  }
}
