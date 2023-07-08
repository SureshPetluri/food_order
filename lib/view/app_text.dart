import 'package:flutter/cupertino.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  double size;
  TextWidget({Key? key,
    required this.text,
    required this.color,
    this.size=12
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color:color,
        fontSize:size,
      ),
    );
  }
}
