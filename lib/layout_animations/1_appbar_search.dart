import 'package:flutter/material.dart';

class AppbarSearch extends StatefulWidget {
  const AppbarSearch({super.key});

  @override
  _AppbarSearchState createState() => _AppbarSearchState();
}

class _AppbarSearchState extends State<AppbarSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: DefaultAppBar());
  }
}

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  _DefaultAppBarState createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar>
    with SingleTickerProviderStateMixin {
  double? rippleStartX, rippleStartY;
  late AnimationController _controller;
  late Animation _animation;
  bool isInSearchMode = false;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener(animationStatusListener);
  }

  animationStatusListener(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      setState(() {
        isInSearchMode = true;
      });
    }
  }

  cancelSearch() {
    setState(() {
      isInSearchMode = false;
    });
    onSearchQueryChange('');
    _controller.reverse();
  }

  onSearchQueryChange(String query) {
    print('search $query');
  }

  render() {
    return Stack(
      children: [
        // default app bar
        AppBar(
          backgroundColor: Colors.blue,
          title: Text("AppBarSearch"),
          actions: <Widget>[
            GestureDetector(
              onTapUp: (TapUpDetails details) {
                onSearchTapUp(details);
              },
              child: Icon(Icons.search, color: Colors.white),
            ),

            Icon(Icons.more_vert),
          ],
        ),
        // animated builder which handles ripple animation
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: MyPainter(
                containerHeight: widget.preferredSize.height,
                center: Offset(rippleStartX ?? 0, rippleStartY ?? 0),
                radius: _animation.value * MediaQuery.of(context).size.width,
                context: context,
              ),
            );
          },
        ),
        isInSearchMode
            ? (SearchBar(
              onCancelSearch: cancelSearch,
              onSearchQueryChanged: onSearchQueryChange,
            ))
            : (Container()),
      ],
    );
  }

  GestureTapUpCallback? onSearchTapUp(TapUpDetails details) {
    setState(() {
      rippleStartX = details.globalPosition.dx;
      rippleStartY = details.globalPosition.dy;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return render();
  }
}

class MyPainter extends CustomPainter {
  final Offset center;
  final double radius, containerHeight;
  final BuildContext context;

  late Color color;
  late double statusBarHeight, screenWidth;

  MyPainter({
    required this.context,
    required this.containerHeight,
    required this.center,
    required this.radius,
  }) {
    ThemeData theme = Theme.of(context);

    color = theme.primaryColor;
    statusBarHeight = MediaQuery.of(context).padding.top;
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePainter = Paint();

    circlePainter.color = color;
    canvas.clipRect(
      Rect.fromLTWH(0, 0, screenWidth, containerHeight + statusBarHeight),
    );
    canvas.drawCircle(center, radius, circlePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  SearchBar({
    super.key,
    required this.onCancelSearch,
    required this.onSearchQueryChanged,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  final VoidCallback onCancelSearch;
  final Function(String) onSearchQueryChanged;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  String searchQuery = '';
  TextEditingController _searchFieldController = TextEditingController();

  clearSearchQuery() {
    _searchFieldController.clear();
    widget.onSearchQueryChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: widget.onCancelSearch,
                ),
                Expanded(
                  child: TextField(
                    controller: _searchFieldController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white),
                      suffixIcon: InkWell(
                        child: Icon(Icons.close, color: Colors.white),
                        onTap: clearSearchQuery,
                      ),
                    ),
                    onChanged: widget.onSearchQueryChanged,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
