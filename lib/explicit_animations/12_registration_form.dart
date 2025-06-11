import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _formController;
  late AnimationController _welcomeController;
  late Animation<double> _formFadeAnimation;
  late Animation<Offset> _formSlideAnimation;
  late Animation<Offset> _welcomeOffsetAnimation;
  late Animation<double> _welcomeFadeAnimation;
  String _name = '';
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _formController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _formFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _formController, curve: Curves.easeInOutBack),
    );

    _formSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.0, -10.0),
    ).animate(
      CurvedAnimation(parent: _formController, curve: Curves.elasticIn),
    );

    _welcomeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _welcomeOffsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _welcomeController, curve: Curves.easeInOutBack),
    );

    _welcomeFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _welcomeController, curve: Curves.elasticOut),
    );
  }

  void _submitForm() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _name = _controller.text;
      });
      _formController.forward().then((_) {
        _welcomeController.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _formController.dispose();
    _welcomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _formController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _formFadeAnimation,
                child: SlideTransition(
                  position: _formSlideAnimation,
                  child: child,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      labelText: 'Enter your name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                    _focusNode.unfocus();
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _welcomeController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _welcomeFadeAnimation,
                child: SlideTransition(
                  position: _welcomeOffsetAnimation,
                  child: child,
                ),
              );
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: 80, color: Colors.green),
                  SizedBox(height: 20),
                  Text(
                    'Welcome, $_name!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We're glad to have you on board.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
