import 'package:flutter/material.dart';

class ThreeDButton extends StatefulWidget {
  const ThreeDButton({super.key});

  @override
  _ThreeDButtonState createState() => _ThreeDButtonState();
}

class _ThreeDButtonState extends State<ThreeDButton>
    with SingleTickerProviderStateMixin {
  static const double _shadowHeight = 4;
  double _position = 4;

  @override
  Widget build(BuildContext context) {
    final double _height = 64 - _shadowHeight;
    return GestureDetector(
          onTapUp: (_) {
            setState(() {
              _position = 4;
            });
          },
          onTapDown: (_) {
            setState(() {
              _position = 0;
            });
          },
          onTapCancel: () {
            setState(() {
              _position = 4;
            });
          },
          child: Container(
            height: _height + _shadowHeight,
            width: 200,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: _height,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeIn,
                  bottom: _position,
                  duration: Duration(milliseconds: 70),
                  child: Container(
                    height: _height,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Center(
                      child: Text(
                        'Click me!',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

    );
  }
}
