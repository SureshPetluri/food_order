import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode _buttonFocusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _buttonFocusNode.addListener(() {
      if (_buttonFocusNode.hasFocus) {
        showOverlay();
      } else {
        removeOverlay();
      }
    });
  }

  void showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 100,
          left: 100,
          child: Container(
            width: 150,
            height: 50,
            color: Colors.blue,
            child: Center(
              child: Text('Overlay'),
            ),
          ),
        );
      },
    );
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overlay Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              focusNode: _buttonFocusNode,
              onPressed: () {},
              child: Text("Toggle Overlay"),
            )
          ],
        ),
      ),
    );
  }
}
