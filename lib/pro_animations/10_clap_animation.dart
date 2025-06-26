import 'dart:async';

import 'package:flutter/material.dart';

class ClapAnimation extends StatefulWidget {
  const ClapAnimation({super.key});

  @override
  _ClapAnimationState createState() => _ClapAnimationState();
}

enum ScoreWidgetStatus { HIDDEN, BECOMING_VISIBLE, VISIBLE, BECOMING_INVISIBLE }

class _ClapAnimationState extends State<ClapAnimation>
    with TickerProviderStateMixin {
  int _counter = 0;
  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
  final duration = Duration(milliseconds: 300);
  late Timer holdTimer, scoreOutETA;
  late AnimationController scoreInAnimationController,
      scoreOutAnimationController,
      scoreSizeAnimationController;
  late Animation scoreOutPositionAnimation;

  initState() {
    super.initState();
    scoreInAnimationController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    scoreInAnimationController.addListener(() {
      setState(() {}); // Calls render function
    });

    scoreOutAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    scoreOutPositionAnimation = Tween(begin: 100.0, end: 150.0).animate(
      CurvedAnimation(
        parent: scoreOutAnimationController,
        curve: Curves.easeOut,
      ),
    );
    scoreOutPositionAnimation.addListener(() {
      setState(() {});
    });
    scoreOutAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
      }
    });

    scoreSizeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    scoreSizeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        scoreSizeAnimationController.reverse();
      }
    });
    scoreSizeAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    super.dispose();
    scoreInAnimationController.dispose();
    scoreOutAnimationController.dispose();
    holdTimer.cancel();
  }

  void increment(Timer t) {
    scoreSizeAnimationController.forward(from: 0.0);
    setState(() {
      _counter++;
    });
    scoreOutETA = Timer(Duration(seconds: 0), () {
      scoreOutAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_INVISIBLE;
    });    
  }

  void onTapDown(TapDownDetails tap) {
    // User pressed the button. This can be a tap or a hold.
    if (scoreOutETA != null) {
      scoreOutETA.cancel(); // We do not want the score to vanish!
    }
    if (_scoreWidgetStatus == ScoreWidgetStatus.BECOMING_INVISIBLE) {
      // We tapped down while the widget was flying up. Need to cancel that animation.
      scoreOutAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.VISIBLE;
    } else if (_scoreWidgetStatus == ScoreWidgetStatus.HIDDEN) {
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
      scoreInAnimationController.forward(from: 0.0);
    }
    increment(Timer(Duration(seconds: 0), () {})); // Take care of tap
    holdTimer = Timer.periodic(duration, increment); // Takes care of hold
  }

  void onTapUp(TapUpDetails tap) {
    holdTimer.cancel();
  }

  Widget getScoreButton() {
    var scorePosition = 0.0;
    var scoreOpacity = 0.0;
    var extraSize = 0.0;
    switch (_scoreWidgetStatus) {
      case ScoreWidgetStatus.HIDDEN:
        break;
      case ScoreWidgetStatus.BECOMING_VISIBLE:
      case ScoreWidgetStatus.VISIBLE:
        scorePosition = scoreInAnimationController.value ;
        scoreOpacity = scoreInAnimationController.value;
        extraSize = scoreSizeAnimationController.value * 10;
        break;
      case ScoreWidgetStatus.BECOMING_INVISIBLE:
        scorePosition = scoreOutPositionAnimation.value;
        scoreOpacity = 1.0 - scoreOutAnimationController.value;
    }
    return Positioned(
      bottom: scorePosition,
      right: 0,
      child: Opacity(
        opacity: scoreOpacity,
        child: Container(
          height: 50.0 + extraSize,
          width: 50.0 + extraSize,
          decoration: ShapeDecoration(
            shape: CircleBorder(side: BorderSide.none),
            color: Colors.pink,
          ),
          child: Center(
            child: Text(
              "+" + _counter.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getClapButton() {
    var extraSize = 0.0;
    if (_scoreWidgetStatus == ScoreWidgetStatus.VISIBLE ||
        _scoreWidgetStatus == ScoreWidgetStatus.BECOMING_VISIBLE) {
      extraSize = scoreSizeAnimationController.value * 10;
    }
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: Container(
          height: 60.0 + extraSize,
          width: 60.0 + extraSize,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink, width: 1.0),
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.pink, blurRadius: 8.0)],
          ),
          child: Icon(Icons.back_hand, color: Colors.pink, size: 40.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clap Animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: SizedBox(
          height: 200,
          child: Stack(
            // alignment: FractionalOffset.center,
            children: <Widget>[getScoreButton(), getClapButton()],
          ),
        ),
      ),
    );
  }
}
