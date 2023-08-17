import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_order/learning/flip_lib/constant.dart';
import 'package:food_order/learning/flip_lib/cover_screen.dart';
import 'package:food_order/learning/flip_lib/image_screen.dart';
import 'package:food_order/learning/flip_lib/inside_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Get dy Value Example'),
        ),
        body: Center(child: TripCard()),
      ),
    );
  }
}
class TripCard extends StatefulWidget {
  @override
  _TripCardState createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Animation _animationNum;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation =
    Tween<Offset>(begin: Offset(0, 0), end: Offset(100, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
      setState(() {});
    });

    _animationNum = Tween(begin: 0.0, end: 1.0).animate(_controller)
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          dyValue = details.delta.dy;
          if (!isForward) {
            _animation = Tween(begin: 0.0, end: (pi * 2) * dyValue / 100)
                .animate(_controller);
            _controller.forward();// Update the Tween's end value
            isForward = true;
          }else{
            _animation = Tween(begin: (pi * 2) * dyValue / 100, end: 0.0)
                .animate(_controller);
            _controller.reverse();
            isForward = false;
          }
        });

      },
      onVerticalDragDown: (details){
        setState(() {
          dyValue = details.localPosition.dy;
          if (!isForward) {
            _animation = Tween(begin: 0.0, end: (pi * 2) * dyValue / 100)
                .animate(_controller);
            _controller.forward();// Update the Tween's end value
            isForward = true;
          }else{
            _animation = Tween(begin: (pi * 2) * dyValue / 100, end: 0.0)
                .animate(_controller);
            _controller.reverse();
            isForward = false;
          }
        });
      },
      // onHover: (value) {
      //
      // },
      child: Stack(
        // alignment: Alignment.center,
        children: <Widget>[
          GestureDetector(
            onVerticalDragUpdate: (details){
              _animation = Tween(begin: (pi * 2) * dyValue / 100, end: 0.0)
                  .animate(_controller);
              _controller.reverse();
              isForward = false;
            },
            child: InsideScreen(
              title: 'For urban lovers',
              information:
              'As cities never sleep, there are always something going on, no matter what time!',
            ),
          ),
          Transform(
              transform: Matrix4.rotationX(pi * _animationNum.value),
              child: _animationNum.value < 0.5 ?Container(
                decoration: containerDecoration.copyWith(
                  color: const Color(0xffff62b2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 200,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_city,
                            color: Colors.white,
                            size: 32.0,
                          ),
                          Text(
                            'City Break',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'From 29€',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xffffffff),
                            ),
                          )
                        ],
                      ),
                    ),
                    ClipPath(
                      clipper: TriangleClipper(),
                      child: Container(
                        color: const Color(0xffffffff),
                        height: 50,
                        width: 200,
                        child: const Center(
                          child: Text(
                            'View me',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffff62b2),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ):GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    dyValue = details.delta.dy;
                    _animation = Tween(begin:1 , end: 0.0)
                        .animate(_controller);
                    _controller.reverse();
                    isForward = false;
                  });

                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: containerDecoration,
                  child: !kIsWeb ? ClipPath(
                    clipper: RightCornerClipper(),
                    child:Image(
                      image: AssetImage('assest/images/image.jpg'),
                    ),
                  ): ClipPath(
                      clipper: RightCornerClipper(),
                      child: Image(
                        image: AssetImage('assest/images/image.jpg'),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
