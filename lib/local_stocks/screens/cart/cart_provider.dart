import 'package:flutter/material.dart';

import '../../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double containerHeight = 0.0;
  ScrollController listScrollController = ScrollController();
  double itemTotal = 0;
  double totalPrice = 0;
  List<Map<String, dynamic>> myCartMap = [
    {
      "ProductName": "APPLE iPhone 13 (Midnight, 128 GB)",
      "productImage": "https://mpdev.pages.dev/images/Apple-iPhone-12.png",
      "description": "6.1-inch (15.5 cm diagonal) Super Retina XDR display",
      "Color": "blue",
      "Size": "L",
      "Quantity": 2,
      "Price": 200.0,
      "Seller": "Seller",
    },
    {
      "ProductName": "Apple iPhone 13 Pro (128GB) - Sierra Blue)",
      "productImage": "https://mpdev.pages.dev/images/apple13.png",
      "description": "6.1-inch (15.5 cm diagonal) Super Retina XDR display",
      "Color": "blue",
      "Size": "L",
      "Quantity": 2,
      "Price": 200.0,
      "Seller": "Seller",
    },
    {
      "ProductName": "APPLE iPhone 13 (Midnight, 128 GB)",
      "productImage": "https://mpdev.pages.dev/images/iphoneFront.png",
      "description": "6.1-inch (15.5 cm diagonal) Super Retina XDR display",
      "Color": "blue",
      "Quantity": 2,
      "Price": 200.0,
      "Seller": "Seller",
    },
    {
      "ProductName": "APPLE iPhone 13 (Midnight, 128 GB)",
      "productImage": "https://mpdev.pages.dev/images/Apple-iPhone-12.png",
      "description": "6.1-inch (15.5 cm diagonal) Super Retina XDR display",
      "Color": "blue",
      "Size": "L",
      "Quantity": 2,
      "Price": 200.0,
      "Seller": "Product Seller Name",
    },
    {
      "ProductName": "APPLE iPhone 13 (Midnight, 128 GB)",
      "productImage": "https://mpdev.pages.dev/images/Apple-iPhone-12.png",
      "description": "6.1-inch (15.5 cm diagonal) Super Retina XDR display",
      "Color": "blue",
      "Size": "L",
      "Quantity": 2,
      "Price": 200.0,
      "Seller": "Product Seller Name",
    },
  ];

  List<CartModel> listCart = [];
  List<CartModel> mySaveLaterCartMap = [];
  bool isPlaceOrder = false;
  int quantity = 1;


  addSaveLaterCart(int index) {
    mySaveLaterCartMap.add(listCart[index]);
    notifyListeners();
  }

  void addToCart(int index) {
    listCart.add(mySaveLaterCartMap[index]);
    mySaveLaterCartMap.remove(mySaveLaterCartMap[index]);
    notifyListeners();
  }

  void removeFromCart(int index) {
    listCart.remove(listCart[index]);
    notifyListeners();
  }

  void removeFromSaveLaterCart(int index) {
    mySaveLaterCartMap.remove(mySaveLaterCartMap[index]);
    notifyListeners();
  }

  funcIncrement(int index) {
    listCart[index].quantity = listCart[index].quantity! + 1;
    itemPrice(index);
    notifyListeners();
  }

  funcDecrement(int index) {
    listCart[index].quantity! > 1
        ? listCart[index].quantity = listCart[index].quantity! - 1
        : listCart[index].quantity;
    itemPrice(index);

    notifyListeners();
  }

  bagTotalPrice() {
    double total = 0.0;
    for (int i = 0; i < listCart.length; i++) {
      totalPrice = listCart[i].price! * listCart[i].quantity!;
      total = total + totalPrice;
    }
    return total;
  }

  itemPrice(int index) {
    itemTotal = listCart[index].price! * listCart[index].quantity!;
    return itemTotal;
  }

  convertingCartModel() {
    listCart.addAll(myCartMap.map((e) => CartModel.fromJson(e)));
  }

// checkOutMethod() {
// if ( Get.find<AuthRepository>().getVendorId() != 0 &&
// Get.find<AuthRepository>().getVendorId() != null) {
// Get.toNamed(AppRoutes.orderConformation);
// } else {
// Get.dialog(
// LoginPage(),
// );
// }
// update();
// }
}
