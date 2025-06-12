import 'package:animations_flutter/layout_animations/1_appbar_search.dart';
import 'package:animations_flutter/layout_animations/2_scroll_aware_appbar.dart';
import 'package:animations_flutter/layout_animations/3_custom_appbar.dart';
import 'package:flutter/material.dart';

class AnimatedNavbar extends StatefulWidget {
  const AnimatedNavbar({super.key});

  @override
  State<AnimatedNavbar> createState() => _AnimatedNavbarState();
}

class _AnimatedNavbarState extends State<AnimatedNavbar> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isNavBarVisible = false;

  changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page!.toInt() != _currentIndex) {
        changeIndex(_pageController.page!.toInt());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: changeIndex,
                children: const [
                  AppbarSearch(),
                  ScrollAppBarDemo(),
                  StackedAppBar(),
                ],
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                bottom: MediaQuery.sizeOf(context).height * 0.08,
                left: _isNavBarVisible ? 0 : -120,
                child: NavBar(
                  backgroundColor: Colors.grey[200],
                  curentIndex: _currentIndex,
                  onTap: changeIndex,
                  children: [
                    NavBarItem(
                      title: 'Home',
                      icon: Icons.home_outlined,
                    ),
                    NavBarItem(
                      title: 'Favorite',
                      icon: Icons.favorite_border,
                    ),
                    NavBarItem(
                      title: 'Cart',
                      icon: Icons.shopping_cart_outlined,
                    ),
                    NavBarItem(
                      title: 'Profile',
                      icon: Icons.person_outline,
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                bottom: 0,
                left: 0,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
                  ),
                  onPressed: () {
                    setState(() {
                      _isNavBarVisible = !_isNavBarVisible;
                    });
                  },
                  icon: Icon(
                    _isNavBarVisible
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarItem {
  final String title;
  final IconData icon;
  NavBarItem({
    required this.title,
    required this.icon,
  });
}

class NavBar extends StatefulWidget {
  final List<NavBarItem> children;
  int curentIndex;
  final Color? backgroundColor;
  Function(int)? onTap;
  NavBar(
      {super.key,
      required this.children,
      required this.curentIndex,
      this.backgroundColor,
      required this.onTap});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          widget.children.length,
          (index) => NavBarWidget(
            index: index,
            item: widget.children[index],
            selected: widget.curentIndex == index,
            onTap: () {
              setState(() {
                widget.curentIndex = index;
                widget.onTap!(widget.curentIndex);
              });
            },
          ),
        ),
      ),
    );
  }
}

class NavBarWidget extends StatefulWidget {
  final NavBarItem item;
  final int index;
  bool selected;
  final Function onTap;
  final Color? backgroundColor;
  NavBarWidget({
    super.key,
    required this.item,
    this.selected = false,
    required this.onTap,
    this.backgroundColor,
    required this.index,
  });

  @override
  State<NavBarWidget> createState() => _NavBarWidgetstate();
}

class _NavBarWidgetstate extends State<NavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(8),
        duration: const Duration(milliseconds: 300),
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: widget.selected
              ? widget.backgroundColor ?? Colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Offstage(
              offstage: widget.selected,
              child: Icon(
                widget.item.icon,
                color: widget.selected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
            ),
            Offstage(
              offstage: !widget.selected,
              child: Text(
                widget.item.title,
                style: const TextStyle(
                    color: Color.fromRGBO(151, 117, 250, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}