import 'package:flutter/material.dart';

class DashBoardProvider with ChangeNotifier {

  TextEditingController productSearchController = TextEditingController();



  List<Map<String, dynamic>> offerMap = [
    {
      "discount": "10%",
      "imageUrl": "assest/local_stocks/images/homeAppliclance.png"
    },
    {"discount": "20%", "imageUrl": "assest/local_stocks/images/lap.png"},
    {"discount": "30%", "imageUrl": "assest/local_stocks/images/lap.png"},
  ];
}
