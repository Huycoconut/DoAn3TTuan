import 'package:flutter/material.dart';

class MyIconButton extends StatefulWidget {
  const MyIconButton({super.key});

  @override
  _MyIconButtonState createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  bool _isFirstSelected = true;
  bool _isSecondSelected = false;
  bool _isThirdSelected = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.circle,
              color: _isFirstSelected ? Colors.blue : Colors.white),
          onPressed: () {
            setState(() {
              _isFirstSelected = !_isFirstSelected;
              _isSecondSelected = true;
              _isThirdSelected = false;
            });
          },
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: Icon(Icons.circle,
              color: _isSecondSelected ? Colors.white : Colors.blue),
          onPressed: () {
            setState(() {
              _isFirstSelected = false;
              _isSecondSelected = !_isSecondSelected;
              _isThirdSelected = false;
            });
          },
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: Icon(Icons.circle,
              color: _isThirdSelected ? Colors.blue : Colors.white),
          onPressed: () {
            setState(() {
              _isThirdSelected = !_isThirdSelected;
              _isFirstSelected = false;
              _isSecondSelected = true;
            });
          },
        ),
      ],
    );
  }
}
