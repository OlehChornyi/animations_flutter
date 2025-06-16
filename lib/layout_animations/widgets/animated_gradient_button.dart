import 'package:flutter/material.dart';

class AnimatedGradientButton extends StatefulWidget {
  final Function() ontap;
  final Color leftColor;
  final Color rightColor;
  final String text;
  final TextStyle textStyle;
  final double height;
  final Duration duration;
  
  const AnimatedGradientButton({
    super.key,
    required this.ontap,
    this.text = "Sign",
    this.height = 50,
    this.duration = const Duration(milliseconds: 300),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontStyle: FontStyle.italic,
    ),
    this.leftColor = const Color.fromRGBO(26, 84, 255, 1),
    this.rightColor = const Color.fromRGBO(215, 2, 251, 1),
  });

  @override
  State<AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton> {
  late Function() ontap;
  late Color leftColor;
  late Color rightColor;
  late String text;
  late TextStyle textStyle;
  late double height;
  late Duration duration;
  bool touched = false;

  @override
  void initState() {
    ontap = widget.ontap;
    leftColor = widget.leftColor;
    rightColor = widget.rightColor;
    text = widget.text;
    textStyle = widget.textStyle;
    height = widget.height;
    duration = widget.duration;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: ontap,
          onTapDown:
              (_) => setState(() {
                touched = true;
              }),
          onTapUp:
              (_) async => Future.delayed(duration, (() {
                touched = false;

                setState(() {});
              })),
          child: AnimatedContainer(
            height: height,
            duration: duration,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient:
                  touched
                      ? LinearGradient(colors: [leftColor, rightColor])
                      : LinearGradient(colors: [rightColor, leftColor]),
            ),
            child: Center(child: Text(text, style: textStyle)),
          ),
        );
      },
    );
  }
}
