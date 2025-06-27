import 'package:flutter/material.dart';

class PulsingMessage extends StatelessWidget {
  const PulsingMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pulsing Message')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MessageIconWithDot(),
            const SizedBox(height: 48),
            MessageIconWithJumpingDot(),
          ],
        ),
      ),
    );
  }
}

class MessageIconWithDot extends StatefulWidget {
  const MessageIconWithDot({super.key});

  @override
  State<MessageIconWithDot> createState() => _MessageIconWithDotState();
}

class _MessageIconWithDotState extends State<MessageIconWithDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.message, size: 40, color: Colors.black),
            Positioned(
              top: -2,
              right: -2,
              child: AnimatedBuilder(
                animation: _scale,
                builder: (context, child) {
                  return Transform.scale(scale: _scale.value, child: child);
                },
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text('Message', style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

class MessageIconWithJumpingDot extends StatefulWidget {
  const MessageIconWithJumpingDot({super.key});

  @override
  State<MessageIconWithJumpingDot> createState() =>
      _MessageIconWithJumpingDotState();
}

class _MessageIconWithJumpingDotState extends State<MessageIconWithJumpingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _jumpAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Half the jump time
    )..repeat(reverse: true); // Jump up and down every 1 sec

    _jumpAnimation = Tween<double>(
      begin: 0.0,
      end: -4.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.message, size: 40, color: Colors.black),
            Positioned(
              top: -2,
              right: -2,
              child: AnimatedBuilder(
                animation: _jumpAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _jumpAnimation.value),
                    child: child,
                  );
                },
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text('Message', style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
