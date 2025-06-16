import 'package:flutter/material.dart';

class AnimatedFloatingButton extends StatefulWidget {
  const AnimatedFloatingButton({super.key});

  @override
  State<AnimatedFloatingButton> createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  int currentState = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 60.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated Floating button')),
      body: Center(
        child: Container(
          width: 200,
          height: 300,
          child: Stack(
            children: [
              Positioned(
                bottom: animation.value,
                child: FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  onPressed: () {},
                  child: Icon(Icons.cake),
                ),
              ),
              Positioned(
                bottom: 0,

                child: FloatingActionButton(
                  onPressed: () {
                    if (currentState == 0) {
                      animationController.forward();
                      currentState = 1;
                    } else {
                      animationController.reverse();
                      currentState = 0;
                    }
                  },
                  child: Icon(Icons.play_arrow),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
