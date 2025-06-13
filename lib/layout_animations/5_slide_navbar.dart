import 'package:flutter/material.dart';

class SlideNavbar extends StatefulWidget {
  const SlideNavbar({super.key});

  @override
  _SlideNavbarState createState() => _SlideNavbarState();
}

class _SlideNavbarState extends State<SlideNavbar> with TickerProviderStateMixin {
  bool _showFirstWidget = true;
  bool _showBottomBar = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showFirstWidget = false;
        _showBottomBar = true;
      });
    });
  }

  void _toggleBottomBar() {
    setState(() {
      _showBottomBar = !_showBottomBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide NavBar'),
        actions: [
          IconButton(
            icon:
                Icon(_showBottomBar ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleBottomBar,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _toggleBottomBar,
              child:
                  Text(_showBottomBar ? 'Hide Bottom Bar' : 'Show Bottom Bar'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _showFirstWidget
          ? null
          : SlidingBottomNavBar(
              isVisible: _showBottomBar,
              animationWidget: SingleChildScrollView(
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class SlidingBottomNavBar extends StatefulWidget {
  final Widget animationWidget;
  final bool isVisible;

  const SlidingBottomNavBar({
    super.key,
    required this.animationWidget,
    required this.isVisible,
  });

  @override
  _SlidingBottomNavBarState createState() => _SlidingBottomNavBarState();
}

class _SlidingBottomNavBarState extends State<SlidingBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isVisible) {
      _controller.value = 1.0;
    } else {
      _controller.value = 0.0;
    }
  }

  @override
  void didUpdateWidget(SlidingBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _controller.forward();
    } else if (!widget.isVisible && oldWidget.isVisible) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.animationWidget,
    );
  }
}