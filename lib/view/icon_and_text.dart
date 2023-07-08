import 'package:flutter/cupertino.dart';

import 'app_text.dart';


class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;
  const IconAndTextWidget({Key? key,
    required this.text,
    this.color=const Color(0xFF76c5bb),
    this.iconColor= const Color(0xFF93ddd4),
    required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color:iconColor),
        const SizedBox(width: 5,),
        TextWidget(text: text, color: color)
      ],
    );
  }
}
