import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
import 'cover_screen.dart';
import 'image_screen.dart';

class AnimatedScreen extends StatefulWidget {
  final AnimationController controller;

  AnimatedScreen({required this.controller});

  @override
  _AnimatedScreenState createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  late Animation _animation;

  @override
  void initState() {

    _animation = Tween(begin: 0.0, end: 1.0).animate(widget.controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationX(pi * _animation.value),
      child: _animation.value < 0.5 ?Container(
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
              child: Column(
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
                      color: const Color(0xffffffff),
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
                child: Center(
                  child: Text(
                    'View me',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffff62b2),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ):Container(
        height: 200,
        width: 200,
        decoration: containerDecoration,
        child: kIsWeb ? ClipPath(
          clipper: RightCornerClipper(),
          child: Image(
            image: AssetImage('assest/images/image.jpg'),
          ),
        ): ClipPath(
            clipper: RightCornerClipper(),
            child: Image(
              image: AssetImage('assest/images/image.jpg'),
              fit: BoxFit.cover,
            )
        ),
      )
    );
  }
}
