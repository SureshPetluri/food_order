import 'package:flutter/material.dart';

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
        body: GetDyValueExample(),
      ),
    );
  }
}

class GetDyValueExample extends StatefulWidget {
  @override
  _GetDyValueExampleState createState() => _GetDyValueExampleState();
}

class _GetDyValueExampleState extends State<GetDyValueExample> {
  double dyValue = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap your widget with GestureDetector to handle touch events
      onVerticalDragUpdate: (details) {
        // onVerticalDragUpdate provides DragUpdateDetails
        setState(() {
          dyValue = details.delta.dy; // Get the dy value from DragUpdateDetails
        });
      },
      child: Container(
        color: Colors.grey,
        child: Center(
          child: Text(
            'Drag vertically on this area.\n\nDy Value: ${dyValue.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
