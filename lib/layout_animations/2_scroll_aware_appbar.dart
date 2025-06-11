import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollAppBarDemo extends StatefulWidget {
  const ScrollAppBarDemo({super.key});

  @override
  State<ScrollAppBarDemo> createState() => _ScrollAppBarDemoState();
}

class _ScrollAppBarDemoState extends State<ScrollAppBarDemo>
    with TickerProviderStateMixin {
  bool isAppBarVisible = true;

  void handleScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      setState(() {
        if (notification.direction == ScrollDirection.reverse) {
          isAppBarVisible = false;
        } else if (notification.direction == ScrollDirection.forward) {
          isAppBarVisible = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          handleScrollNotification(notification);
          return true;
        },
        child: Column(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isAppBarVisible
                  ? const CustomAnimatedAppBar()
                  : const SizedBox.shrink(),
            ),
            const Expanded(child: CustomCardListView()),
          ],
        ),
      ),
    );
  }
}

class CustomCardListView extends StatelessWidget {
  const CustomCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2019/12/31/16/06/yoga-4732209_1280.jpg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Title ${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This is a brief description of the item. You can customize it to include news, blog content, product info, etc.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomAnimatedAppBar extends StatelessWidget {
  const CustomAnimatedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Welcome Back,',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Dr Agarwals Health',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=47',
            ),
          ),
        ],
      ),
    );
  }
}