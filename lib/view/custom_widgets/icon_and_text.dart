import 'package:flutter/material.dart';

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
        Icon(icon, color: iconColor),
        const SizedBox(
          width: 5,
        ),
        TextWidget(text: text, color: color)
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key,  required this.biryani}) : super(key: key);
 final String biryani;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.sizeOf(context).width > 400 ? 18.0 : 10, bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(biryani),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width > 300 ? 20 : 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 3.0, bottom: 3),
                    child: Text("Cumin Barbecue",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      "Cumin Barbecue",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.orange,
                          ),
                          SizedBox(
                            width:
                                MediaQuery.sizeOf(context).width > 400 ? 10 : 5,
                          ),
                          const Text("Normal"),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width > 400 ? 20 : 10,
                      ),
                      const IconAndTextWidget(
                        text: '1.7 Km',
                        icon: Icons.location_on,
                        color: Colors.grey,
                      ),
                      SizedBox(
                          width:
                              MediaQuery.sizeOf(context).width > 400 ? 20 : 10),
                      const IconAndTextWidget(
                        text: '32 min',
                        icon: Icons.timer_outlined,
                        color: Colors.grey,
                        iconColor: Colors.orange,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
