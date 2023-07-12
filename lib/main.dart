import 'package:flutter/material.dart';
import 'package:food_order/view/custom_page_view.dart';
import 'package:food_order/view/on_boarding/on_board_screen.dart';
import 'package:nominatim_geocoding/nominatim_geocoding.dart';

Future<void> main() async {
  await NominatimGeocoding.init(reqCacheNum: 20);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home:  OnBoardScreen()
    );
  }
}
