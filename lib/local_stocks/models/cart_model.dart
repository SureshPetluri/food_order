import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.productName,
    this.productImage,
    this.description,
    this.color,
    this.size,
    this.quantity,
    this.price,
    this.seller,
  });

  String? productName;
  String? productImage;
  String? description;
  String? color;
  String? size;
  int? quantity;
  double? price;
  String? seller;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    productName: json["ProductName"] ?? "",
    productImage: json["productImage"] ?? "",
    description: json["description"] ?? "",
    color: json["Color"] ?? "",
    size:json.containsKey("Size") ? json["Size"] ?? "": "",
    quantity: json["Quantity"] ?? 0,
    price: json["Price"] ?? 0.0,
    seller: json["Seller"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "ProductName": productName,
    "productImage": productImage,
    "description": description,
    "Color": color,
    "Size": size,
    "Quantity": quantity,
    "Price": price,
    "Seller": seller,
  };
}
