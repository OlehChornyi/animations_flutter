import 'package:flutter/material.dart';

enum FloatingBtnType {
  right,
  top,
}

class FloatingMenu extends StatefulWidget {
  const FloatingMenu({
    super.key,
    required this.speedDialChildren,
    this.labelsStyle,
    this.labelsBackgroundColor,
    this.controller,
    this.closedForegroundColor,
    this.openForegroundColor,
    this.closedBackgroundColor,
    this.openBackgroundColor,
    required this.type,
  });

  final FloatingBtnType type;
  final List<SpeedDialChild> speedDialChildren;
  final TextStyle? labelsStyle;
  final Color? labelsBackgroundColor;
  final AnimationController? controller;
  final Color? closedForegroundColor;
  final Color? openForegroundColor;
  final Color? closedBackgroundColor;
  final Color? openBackgroundColor;

  @override
  State<StatefulWidget> createState() {
    return _FloatingMenuState();
  }
}

class _FloatingMenuState extends State<FloatingMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _foregroundColorAnimation;
  final List<Animation<double>> _speedDialChildAnimations =
      <Animation<double>>[];

  @override
  void initState() {
    _animationController = widget.controller ??
        AnimationController(
            vsync: this, duration: const Duration(milliseconds: 450));
    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _backgroundColorAnimation = ColorTween(
      begin: widget.closedBackgroundColor,
      end: widget.openBackgroundColor,
    ).animate(_animationController);

    _foregroundColorAnimation = ColorTween(
      begin: widget.closedForegroundColor,
      end: widget.openForegroundColor,
    ).animate(_animationController);

    final double fractionOfOneSpeedDialChild =
        1.0 / widget.speedDialChildren.length;
    for (int speedDialChildIndex = 0;
        speedDialChildIndex < widget.speedDialChildren.length;
        ++speedDialChildIndex) {
      final List<TweenSequenceItem<double>> tweenSequenceItems =
          <TweenSequenceItem<double>>[];

      final double firstWeight =
          fractionOfOneSpeedDialChild * speedDialChildIndex;
      if (firstWeight > 0.0) {
        tweenSequenceItems.add(TweenSequenceItem<double>(
          tween: ConstantTween<double>(0.0),
          weight: firstWeight,
        ));
      }

      tweenSequenceItems.add(TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: fractionOfOneSpeedDialChild,
      ));

      final double lastWeight = fractionOfOneSpeedDialChild *
          (widget.speedDialChildren.length - 1 - speedDialChildIndex);
      if (lastWeight > 0.0) {
        tweenSequenceItems.add(TweenSequenceItem<double>(
            tween: ConstantTween<double>(1.0), weight: lastWeight));
      }

      _speedDialChildAnimations.insert(
          0,
          TweenSequence<double>(tweenSequenceItems)
              .animate(_animationController));
    }

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int speedDialChildAnimationIndex = 0;
    return widget.type == FloatingBtnType.right
        ? Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  foregroundColor: _foregroundColorAnimation.value,
                  backgroundColor: _backgroundColorAnimation.value,
                  onPressed: () {
                    if (_animationController.isDismissed) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                  },
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) => RotationTransition(
                            turns: child.key == const ValueKey('icon1')
                                ? Tween<double>(begin: 1, end: 0.75)
                                    .animate(anim)
                                : Tween<double>(begin: 0.75, end: 1)
                                    .animate(anim),
                            child: FadeTransition(opacity: anim, child: child),
                          ),
                      child: !_animationController.isDismissed
                          ? const Icon(
                              Icons.close,
                              key: ValueKey('icon1'),
                              color: Colors.white,
                            )
                          : const Icon(Icons.menu)),
                ),
              ),
              if (!_animationController.isDismissed)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: widget.speedDialChildren
                      .map<Widget>((SpeedDialChild speedDialChild) {
                    final Widget speedDialChildWidget = Opacity(
                      opacity: _speedDialChildAnimations.reversed
                          .toList()[speedDialChildAnimationIndex]
                          .value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: ScaleTransition(
                              scale: _speedDialChildAnimations.reversed
                                  .toList()[speedDialChildAnimationIndex],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: FloatingActionButton(
                                  heroTag: speedDialChildAnimationIndex,
                                  mini: true,
                                  foregroundColor:
                                      speedDialChild.foregroundColor,
                                  backgroundColor:
                                      speedDialChild.backgroundColor,
                                  onPressed: () => _onTap(speedDialChild),
                                  child: speedDialChild.child,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    speedDialChildAnimationIndex++;
                    return speedDialChildWidget;
                  }).toList(),
                ),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (!_animationController.isDismissed)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.speedDialChildren
                      .map<Widget>((SpeedDialChild speedDialChild) {
                    final Widget speedDialChildWidget = Opacity(
                      opacity: _speedDialChildAnimations[
                              widget.speedDialChildren.indexOf(speedDialChild)]
                          .value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: ScaleTransition(
                              scale: _speedDialChildAnimations[
                                  speedDialChildAnimationIndex],
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: FloatingActionButton(
                                  heroTag: speedDialChildAnimationIndex,
                                  mini: true,
                                  foregroundColor:
                                      speedDialChild.foregroundColor,
                                  backgroundColor:
                                      speedDialChild.backgroundColor,
                                  onPressed: () => _onTap(speedDialChild),
                                  child: speedDialChild.child,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    speedDialChildAnimationIndex++;
                    return speedDialChildWidget;
                  }).toList(),
                ),
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  foregroundColor: _foregroundColorAnimation.value,
                  backgroundColor: _backgroundColorAnimation.value,
                  onPressed: () {
                    if (_animationController.isDismissed) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                  },
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) => RotationTransition(
                            turns: child.key == const ValueKey('icon1')
                                ? Tween<double>(begin: 1, end: 0.75)
                                    .animate(anim)
                                : Tween<double>(begin: 0.75, end: 1)
                                    .animate(anim),
                            child: FadeTransition(opacity: anim, child: child),
                          ),
                      child: !_animationController.isDismissed
                          ? const Icon(
                              Icons.close,
                              key: ValueKey('icon1'),
                              color: Colors.white,
                            )
                          : const Icon(Icons.menu)),
                ),
              ),
            ],
          );
  }

  void _onTap(SpeedDialChild speedDialChild) {
    if (speedDialChild.closeSpeedDialOnPressed) {
      _animationController.reverse();
    }
    speedDialChild.onPressed.call();
  }
}

class SpeedDialChild {
  const SpeedDialChild({
    required this.child,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.closeSpeedDialOnPressed = true,
  });

  final Widget child;
  final Function onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool closeSpeedDialOnPressed;
}