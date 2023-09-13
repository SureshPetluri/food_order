import 'package:flutter/material.dart';
import 'package:food_order/local_stocks/screens/cart/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../models/cart_model.dart';

class LIstCartItems extends StatelessWidget {
  const LIstCartItems({required this.listCart, required this.text, Key? key})
      : super(key: key);
  final List<CartModel> listCart;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (BuildContext context, controller, _) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.sizeOf(context).width > 750 ? 50.0 : 10.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: listCart.length,
          itemBuilder: (BuildContext context, int index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MediaQuery.sizeOf(context).width > 750
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 150,
                      width: 150,
                      child: Image.network(
                        listCart[index].productImage ?? "",
                        height: 150,
                        width: 150,
                        frameBuilder: (BuildContext context, Widget child, int? frame, bool? wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded == true || frame != null) {
                            // Image has finished loading, return the child (the image).
                            return child;
                          } else {
                            // Image is still loading, return the loadingBuilder (loading indicator).
                            return const SizedBox(
                              height: 50,
                              width: 50,
                              child: Center(child: CircularProgressIndicator(color: Colors.blue)),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image.asset(
                            "assets/local_stocks/images/placeholder.png",
                            height: 150,
                            width: 150,
                          );
                        },
                      ),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: MediaQuery.sizeOf(context).width <
                                            750
                                        ? MediaQuery.sizeOf(context).width * 0.5
                                        : MediaQuery.sizeOf(context).width >
                                                1200
                                            ? MediaQuery.sizeOf(context).width *
                                                0.1
                                            : MediaQuery.sizeOf(context).width *
                                                0.275,
                                    child: Text(
                                      listCart[index].productName ?? "",
                                      style: buildTextStyle(
                                          16.0,
                                          FontWeight.w600,
                                          Theme.of(context)
                                              .colorScheme
                                              .copyWith()
                                              .onPrimary),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width > 750
                                      ? MediaQuery.sizeOf(context).width * 0.17
                                      : MediaQuery.sizeOf(context).width * 0.50,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    listCart[index].description ?? "",
                                    style: buildTextStyle(
                                        14.0,
                                        FontWeight.w400,
                                        Theme.of(context)
                                            .colorScheme
                                            .copyWith()
                                            .onPrimary),
                                  ),
                                ),
                                buildRow(
                                    controller,
                                    "${controller.itemPrice(index)}",
                                    16.0,
                                    FontWeight.w600,
                                    Theme.of(context)
                                        .colorScheme
                                        .copyWith()
                                        .onPrimary),
                              ],
                            ),
                            MediaQuery.sizeOf(context).width > 1200
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, right: 5.0),
                                    child: buildDeliveryDateRow(context),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        MediaQuery.sizeOf(context).width > 1200
                            ? SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.34,
                                child: buildQtyContainer(
                                    context, index, controller))
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
                MediaQuery.sizeOf(context).width < 1200
                    ? Column(
                        children: [
                          buildDividerContainer(context, controller),
                          buildDeliveryDateRow(context),
                        ],
                      )
                    : const SizedBox(),
                buildDividerContainer(context, controller),
                MediaQuery.sizeOf(context).width < 1200
                    ? SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.93,
                        child: buildQtyContainer(context, index, controller))
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDividerContainer(
      BuildContext context, CartProvider controller) {
    return Container(
      height: 1,
      color: Colors.grey,
      width: MediaQuery.sizeOf(context).width,
    );
  }

  Column buildQtyContainer(
      BuildContext context, int index, CartProvider controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MediaQuery.sizeOf(context).width > 1200
            ? const Divider(
                color: Colors.grey,
                thickness: 1,
              )
            : const SizedBox(),
        Row(
          // crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
              child: Text(
                "Qty : ",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.copyWith().onPrimary),
              ),
            ),
            IconButton(
                padding: EdgeInsets.zero,
                splashRadius: 0.5,
                onPressed: () {
                  controller.funcIncrement(index);
                },
                icon: Icon(Icons.add,
                    color: Theme.of(context).colorScheme.copyWith().onPrimary)),
            Text(
              "${listCart[index].quantity}",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.copyWith().onPrimary),
            ),
            IconButton(
                splashRadius: 0.5,
                onPressed: () {
                  controller.funcDecrement(index);
                },
                icon: Icon(Icons.remove,
                    color: Theme.of(context).colorScheme.copyWith().onPrimary)),
            const Spacer(),
            const Icon(Icons.favorite_outline_rounded),
            buildWishlistPadding(
                context,
                index,
                controller,
                MediaQuery.sizeOf(context).width > 750
                    ? " Save to wishlist "
                    : "Wishlist",
                FontWeight.bold),
            buildWishlistPadding(
                context, index, controller, "Remove", FontWeight.bold),
          ],
        ),
      ],
    );
  }

  Row buildDeliveryDateRow(BuildContext context) {
    return Row(
      children: [
         Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Icon(Icons.local_shipping,color: Theme.of(context).colorScheme.copyWith().onPrimary),
        ),
         Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("Delivery by ",style: TextStyle(color: Theme.of(context).colorScheme.copyWith().onPrimary),),
        ),
         Text("22nd oct",style: TextStyle(color: Theme.of(context).colorScheme.copyWith().onPrimary),),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 10),
          height: 20,
          width: 1,
          color: Theme.of(context).colorScheme.copyWith().surface,
        ),
         Text("Free",style: TextStyle(color: Theme.of(context).colorScheme.copyWith().onPrimary),)
      ],
    );
  }

  Padding buildWishlistPadding(BuildContext context, int index,
      CartProvider controller, String text, FontWeight fontWeight) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      child: InkWell(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14,
              fontWeight: fontWeight,
              color: Theme.of(context).colorScheme.copyWith().onPrimary),
        ),
        onTap: () {
          controller.removeFromCart(index);
        },
      ),
    );
  }
}

Padding buildRow(CartProvider controller, String text1, double fontSize,
    FontWeight fontWeight, Color color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "\$ $text1",
          style: buildTextStyle(fontSize, fontWeight, color),
        ),
      ],
    ),
  );
}

TextStyle buildTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
}
