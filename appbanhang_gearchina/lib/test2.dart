import 'package:flutter/material.dart';

class test2 extends StatefulWidget {
  const test2({super.key});

  @override
  State<test2> createState() => _test2State();
}

class _test2State extends State<test2> {
  bool _isButtonVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx < -10) {
                    setState(() {
                      _isButtonVisible = true;
                    });
                  } else if (details.delta.dx > 10) {
                    setState(() {
                      _isButtonVisible = false;
                    });
                  }
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: AnimatedOpacity(
                    opacity: _isButtonVisible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Button'),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
