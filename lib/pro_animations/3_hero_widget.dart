import 'package:flutter/material.dart';

//ANIMATED OPACITY

class HeroFrom extends StatelessWidget {
  const HeroFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'hero',
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const HeroToWidget()));
              },
              child: Image.network('https://picsum.photos/seed/picsum/300/500'),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroToWidget extends StatelessWidget {
  const HeroToWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'hero',
              child: Image.network(
                'https://picsum.photos/seed/picsum/250/400',
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Smooth transitions are key to delightful user experiences. Flutter’s Hero widget is designed for just that — creating seamless, animated transitions between two screens when a shared visual element is present on both. Whether you’re building image galleries, product previews, or interactive lists, Hero animations can add a polished and intuitive feel to your app.',
            ),
          ],
        ),
      ),
    );
  }
}
