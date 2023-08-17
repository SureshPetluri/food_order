import 'dart:math';

import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestWidget()
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double dyValue = 0;
  bool isForward = false;
  bool removePage1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
            dyValue = details.localPosition.dy;
            _animation = Tween(begin: 0.0, end: (pi) * dyValue / 100)
                .animate(_controller);
            _controller.forward();
            });
          },
          child: Card(
            child: Column(
      children: [
            Container(
              height: MediaQuery.sizeOf(context).height*0.46,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.blue,
            ),
            Transform(
              transform: Matrix4.rotationX(pi * _animation.value),
              child: Container(
                height: MediaQuery.sizeOf(context).height*0.46,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.blue,
              ),
            ),
      ],
    ),
          ),
        ));
  }
}
