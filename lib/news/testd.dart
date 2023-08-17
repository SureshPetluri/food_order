import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageTransitionSwipe(),
    );
  }
}

class PageTransitionSwipe extends StatefulWidget {
  @override
  _PageTransitionSwipeState createState() => _PageTransitionSwipeState();
}

class _PageTransitionSwipeState extends State<PageTransitionSwipe>
    with TickerProviderStateMixin {
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
      appBar: AppBar(
        title: Text('Page Transition Swipe'),
      ),
      body: Stack(
        children: [
          buildPage(color: Colors.green, text: 'Page 2'),
          buildPage(color: Colors.orange, text: 'Page 3'),
          Visibility(
            visible: removePage1,
            child: Column(
              children: [
                buildPage(color: Colors.blue, text: 'Page 1'),
                Transform(
                  transform: Matrix4.rotationX(pi * _animation.value),
                  child: GestureDetector(
                      // Wrap your widget with GestureDetector to handle touch events
                      onVerticalDragUpdate: (details) {
                        if (isForward) {
                          _controller.forward().whenComplete(() {
                            isForward = true;
                            removePage1 = false;
                            setState(() {});
                          });
                        } else {
                          _controller.forward().whenComplete(() {
                            isForward = false;
                          });
                        }
                        // onVerticalDragUpdate provides DragUpdateDetails
                        setState(() {
                          dyValue = details.delta.dy;
                          // if (dyValue < 0) {
                            _animation = Tween(
                                    begin: 0.0, end: (pi) * dyValue / 100)
                                .animate(
                                    _controller); // Update the Tween's end value
                            _controller.forward();
                          // }
// Get the dy value from DragUpdateDetails
                        });
                      },
                      child: buildPage(color: Colors.blue, text: 'Page 1')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({required Color color, required String text}) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.4,
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
