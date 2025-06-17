import 'package:flutter/material.dart';

class IntroItem {
  final IconData icon;
  final String description;
  final Color backgroundColor;
  final Color textColor;

  IntroItem({
    required this.icon,
    required this.description,
    required this.backgroundColor,
    required this.textColor,
  });
}

class IntroScreen1 extends StatefulWidget {
  const IntroScreen1({super.key});
  static List<IntroItem> items = [
        IntroItem(
          icon: Icons.rocket_launch,
          description: 'Blast off into awesomeness!',
          backgroundColor: Color.fromARGB(255, 8, 49, 232),
          textColor: Colors.white,
        ),
        IntroItem(
          icon: Icons.emoji_nature,
          description: 'Unleash your inner unicorn',
          backgroundColor: Colors.pink,
          textColor: Colors.black,
        ),
        IntroItem(
          icon: Icons.brightness_7,
          description: 'Get ready to shine bright',
          backgroundColor: const Color.fromARGB(255, 2, 2, 2),
          textColor: Colors.white,
        ),
        IntroItem(
          icon: Icons.auto_awesome,
          description: 'Become the hero of your story',
          backgroundColor: Color(0xFFFFE5B4),
          textColor: Colors.black,
        ),
        IntroItem(
          icon: Icons.auto_fix_high,
          description: 'Abracadabra! Magic awaits',
          backgroundColor: Colors.orange,
          textColor: Colors.white,
        ),
      ];

  @override
  _IntroScreenState1 createState() => _IntroScreenState1();
}

class _IntroScreenState1 extends State<IntroScreen1>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final int _animationDuration = 500;
  final int _delayDuration = 350;

  late Animation<Offset> _slideOutAnimation;
  late Animation<Offset> _slideInAnimation;
  late Animation<double> _fadeOutAnimation;
  late Animation<double> _fadeInAnimation;

  int _currentIndex = 0;
  int _nextIndex = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationDuration * 2 + _delayDuration),
    );

    _slideOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    ));

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.4, 0.8, curve: Curves.easeIn),
    ));

    _fadeOutAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    ));

    _fadeInAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.4, 0.8, curve: Curves.easeIn),
    ));

    _animationController.addStatusListener(_handleAnimationStatus);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _currentIndex = _nextIndex;
        _isAnimating = false;
      });
      _animationController.reset();
    }
  }

  void _nextPage() {
    if (_isAnimating) return;
    setState(() {
      _isAnimating = true;
      _nextIndex = (_currentIndex + 1) % IntroScreen1.items.length;
    });
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CombinedExpandingCircles3(
              colors: IntroScreen1.items, onNextClick: _nextPage),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _buildContent(IntroScreen1.items[_currentIndex]),
                          if (_isAnimating)
                            _buildContent(IntroScreen1.items[_nextIndex]),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 150), // Empty layout at the bottom
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(IntroItem item) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final isCurrentItem = IntroScreen1.items[_currentIndex] == item;

        return SlideTransition(
          position: _isAnimating
              ? (isCurrentItem ? _slideOutAnimation : _slideInAnimation)
              : AlwaysStoppedAnimation(Offset.zero),
          child: FadeTransition(
            opacity: _isAnimating
                ? (isCurrentItem ? _fadeOutAnimation : _fadeInAnimation)
                : AlwaysStoppedAnimation(1.0),
            child: child,
          ),
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: item.textColor,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              item.description,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: item.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

enum AnimationState { initial, expanding, moving, shrinking, completed }

// Color management
class ColorManager {
  final List<IntroItem> colors;
  int _currentIndex = 0;

  ColorManager(this.colors);

  Color get currentColor => colors[_currentIndex].backgroundColor;
  Color get nextColor =>
      colors[(_currentIndex + 1) % colors.length].backgroundColor;
  Color get previousColor =>
      colors[(_currentIndex - 1 + colors.length) % colors.length]
          .backgroundColor;

  void advance() {
    _currentIndex = (_currentIndex + 1) % colors.length;
  }

  void reverse() {
    _currentIndex = (_currentIndex - 1 + colors.length) % colors.length;
  }
}

class AnimationManager extends ChangeNotifier {
  AnimationState _state = AnimationState.initial;
  AnimationState get state => _state;

  void updateState(AnimationState newState) {
    _state = newState;
    notifyListeners();
  }
}

class CombinedExpandingCircles3 extends StatefulWidget {
  final List<IntroItem> colors;
  final Function onNextClick;
  const CombinedExpandingCircles3(
      {Key? key, required this.colors, required this.onNextClick});

  @override
  _CombinedExpandingCirclesState createState() =>
      _CombinedExpandingCirclesState();
}

class _CombinedExpandingCirclesState extends State<CombinedExpandingCircles3>
    with SingleTickerProviderStateMixin {
  late AnimationManager _animationManager;
  late ColorManager _colorManager;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _moveAnimation;
  late Animation<double> _moveBackAnimation;
  late Animation<double> _shrinkAnimation;
  late Animation<double> _cta_circle_grow_animation;

  // int _currentColorSetIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1700),
      vsync: this,
    );

    _animationManager = AnimationManager();
    _colorManager = ColorManager(widget.colors);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _animationManager.updateState(AnimationState.completed);
        setState(() {
          _colorManager.advance();
        });
      }
    });

    _controller.addListener(() {
      if (_controller.value < 0.5) {
        _animationManager.updateState(AnimationState.expanding);
      } else if (_controller.value < 0.6) {
        _animationManager.updateState(AnimationState.moving);
      } else {
        _animationManager.updateState(AnimationState.shrinking);
      }
    });

    _expandAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.35, curve: Curves.easeInQuart),
      ),
    );

    _moveAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.30, 0.45, curve: Curves.easeOutQuart),
      ),
    );

    _shrinkAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.75, curve: Curves.easeOutQuart),
      ),
    );

    _moveBackAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOutQuart),
      ),
    );

    _cta_circle_grow_animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 0.95, curve: Curves.easeOutQuart),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    _controller.forward();
    widget.onNextClick();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final bottomPadding = MediaQuery.of(context).padding.bottom * 6;
    final bottomPadding = 150.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: _toggleExpansion,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: CombinedCirclePainter(
                expandProgress: _expandAnimation.value,
                moveProgress: _moveAnimation.value,
                moveBackProgress: _moveBackAnimation.value,
                shrinkProgress: _shrinkAnimation.value,
                ctaGrowProgress: _cta_circle_grow_animation.value,
                fullScreenSize: size,
                bottomPadding: bottomPadding,
                animationManager: _animationManager,
                currentColor: _colorManager.currentColor,
                nextColor: _colorManager.nextColor,
                previousColor: _colorManager.previousColor,
              ),
              size: size,
            );
          },
        ),
      ),
    );
  }
}

class CombinedCirclePainter extends CustomPainter {
  static double minRadius = 50.0;

  final double expandProgress;
  final double moveProgress;
  final double moveBackProgress;
  final double shrinkProgress;
  final double ctaGrowProgress;
  final Size fullScreenSize;
  final double bottomPadding;
  final AnimationManager animationManager;
  final Color currentColor;
  final Color nextColor;
  final Color previousColor;

  CombinedCirclePainter({
    required this.expandProgress,
    required this.moveProgress,
    required this.moveBackProgress,
    required this.shrinkProgress,
    required this.ctaGrowProgress,
    required this.fullScreenSize,
    required this.bottomPadding,
    required this.animationManager,
    required this.currentColor,
    required this.nextColor,
    required this.previousColor,
  });

  late final asymmetricPaint = Paint()
    ..color = currentColor
    ..style = PaintingStyle.fill;

  late final endCirclePaint = Paint()
    ..color = previousColor
    ..style = PaintingStyle.fill;

  late final ctaCirclePaint = Paint()
    ..color = nextColor
    ..style = PaintingStyle.fill;

  // function to add expanding pink circle
  void addExpandingCircle(
      Canvas canvas, double minRadius, double maxRadius, double bottomY) {
    final currentRadius = minRadius + (maxRadius - minRadius) * expandProgress;
    final initialCenterX = fullScreenSize.width / 2;
    final leftEdgeX = initialCenterX - minRadius;
    final currentCenterX = leftEdgeX + currentRadius;

    canvas.drawCircle(
      Offset(currentCenterX, bottomY),
      currentRadius,
      asymmetricPaint,
    );
  }

  void addShrinkingCircle(
      Canvas canvas, double minRadius, double maxRadius, double bottomY) {
    final currentRadius = maxRadius - (maxRadius - minRadius) * shrinkProgress;
    var currentCenterX =
        fullScreenSize.width / 2 - currentRadius - (minRadius * moveProgress);

    currentCenterX = currentCenterX + (currentRadius * 2 * moveBackProgress);

    canvas.drawCircle(
        Offset(currentCenterX, bottomY), currentRadius, endCirclePaint);

    if (ctaGrowProgress > 0) {
      canvas.drawCircle(Offset(currentCenterX, bottomY),
          minRadius * ctaGrowProgress, ctaCirclePaint);

      // Draw the icon
      drawIcon(canvas, currentCenterX, bottomY);
    }
  }

  // create a new function to draw the icon in the middle of this circle
  void drawIcon(Canvas canvas, double currentCenterX, double bottomY) {
    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(Icons.arrow_forward.codePoint),
        style: TextStyle(
          fontSize: 30,
          fontFamily: Icons.arrow_forward.fontFamily,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    iconPainter.layout();
    iconPainter.paint(
      canvas,
      Offset(
        currentCenterX - iconPainter.width / 2,
        bottomY - iconPainter.height / 2,
      ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw full screen pink background when expand is complete
    if (expandProgress >= 0.4) {
      canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height), asymmetricPaint);
    } else {
      canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height), endCirclePaint);
    }

    // Constants
    final maxRadius = fullScreenSize.width * 10 + fullScreenSize.height * 10;
    final bottomY = fullScreenSize.height - bottomPadding;

    if (moveProgress >= 0.99) {
      addExpandingCircle(canvas, minRadius, maxRadius, bottomY);
      addShrinkingCircle(canvas, minRadius, maxRadius, bottomY);
    } else {
      addShrinkingCircle(canvas, minRadius, maxRadius, bottomY);
      addExpandingCircle(canvas, minRadius, maxRadius, bottomY);
    }

    // Always draw the icon at the final position
    if (animationManager._state == AnimationState.completed ||
        animationManager._state == AnimationState.initial) {
      final finalCenterX = fullScreenSize.width / 2;
      drawIcon(canvas, finalCenterX, bottomY);
    }
  }

  @override
  bool shouldRepaint(CombinedCirclePainter oldDelegate) =>
      expandProgress != oldDelegate.expandProgress ||
      moveProgress != oldDelegate.moveProgress ||
      moveBackProgress != oldDelegate.moveBackProgress ||
      shrinkProgress != oldDelegate.shrinkProgress ||
      ctaGrowProgress != oldDelegate.ctaGrowProgress;
}