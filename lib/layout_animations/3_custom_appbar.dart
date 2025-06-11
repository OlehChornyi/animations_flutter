import 'package:flutter/material.dart';

class StackedAppBar extends StatefulWidget {
  const StackedAppBar({super.key});

  @override
  State<StackedAppBar> createState() => _StackedAppBarState();
}

class _StackedAppBarState extends State<StackedAppBar> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  ),
                ),
                backgroundColor: Color(0xff1b303e),
                expandedHeight: size.height * 0.38,
              ),
              const SliverPadding(padding: EdgeInsets.all(30)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(title: Text('$index')),
                ),
              ),
            ],
          ),
          _CustomAppBar(scrollController: _scrollController),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final ScrollController scrollController;

  const _CustomAppBar({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double defaulMargin = 560;
    const double defaulStart = 530;
    const double defaultEnd = defaulStart / 2;
    double opacity = 1.0;
    double offset = scrollController.offset;

    //SET THE MARGINS FOR TRIGGER THE OPACITY ACCORDING TO THE SCROLLING
    //this values can change according to your needs
    if (offset < defaulMargin - defaulStart) {
      opacity = 1.0;
    } else if (offset < defaulStart - defaultEnd) {
      opacity = (defaulMargin - defaultEnd - offset) / defaultEnd;
    } else {
      opacity = 0.0;
    }
    return Stack(
      children: [
        Positioned(
          top: offset > 0 ? size.height * 0.375 - offset : size.height * 0.375,
          left: size.width * 0.51,
          child: Opacity(
            opacity: opacity,
            child: FloatingActionButton(
              onPressed: () {},
              child: Container(
                width: size.width * 0.6,
                height: size.height * 0.6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xff60c2b5), Color(0xff28a7b8)],
                  ),
                ),
                child: const Icon(Icons.play_arrow, size: 40),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
