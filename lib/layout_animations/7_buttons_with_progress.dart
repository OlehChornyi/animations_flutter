import 'package:flutter/material.dart';

class ButtonsWithProgress extends StatefulWidget {
  const ButtonsWithProgress({super.key});

  @override
  _ButtonsWithProgressState createState() => _ButtonsWithProgressState();
}

class _ButtonsWithProgressState extends State<ButtonsWithProgress> {
  bool _isLoading = false, _isCompleted = false;
  bool _isLoading2 = false, _isCompleted2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buttons With Progress")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              _isLoading,
              _isCompleted,
              Colors.green,
              Icons.check,
              () async {
                setState(() => _isLoading = true);
                await Future.delayed(Duration(seconds: 2));
                setState(() {
                  _isLoading = false;
                  _isCompleted = true;
                });
                await Future.delayed(Duration(seconds: 10));
                setState(() => _isCompleted = false);
              },
            ),
            SizedBox(height: 12),
            _buildButton(
              _isLoading2,
              _isCompleted2,
              Colors.red,
              Icons.dangerous,
              () async {
                setState(() => _isLoading2 = true);
                await Future.delayed(Duration(seconds: 2));
                setState(() {
                  _isLoading2 = false;
                  _isCompleted2 = true;
                });
                await Future.delayed(Duration(seconds: 5));
                setState(() => _isCompleted2 = false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    bool isLoading,
    bool isCompleted,
    Color completedColor,
    IconData icon,
    Function onTap,
  ) {
    return GestureDetector(
      onTap: isLoading || isCompleted ? null : () => onTap(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 60,
        width: isLoading || isCompleted ? 60 : 200,
        decoration: BoxDecoration(
          color: isCompleted ? completedColor : Colors.blue,
          borderRadius: BorderRadius.circular(
            isLoading || isCompleted ? 30 : 50,
          ),
        ),
        child: Center(
          child:
              isLoading
                  ? CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                  : isCompleted
                  ? Icon(icon, color: Colors.white, size: 30)
                  : Text(
                    "Send",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
        ),
      ),
    );
  }
}
