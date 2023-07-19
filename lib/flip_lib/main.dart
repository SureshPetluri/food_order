import 'package:flutter/material.dart';
import 'package:food_order/flip_lib/trip_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TripCardCollection(),
    );
  }
}

class TripCardCollection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAE2D5),
      body: TripCard(),
    );
  }
}
