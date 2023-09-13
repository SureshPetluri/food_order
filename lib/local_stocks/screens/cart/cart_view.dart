import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_product.dart';
import 'cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<CartProvider>(context, listen: false).convertingCartModel();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, controller, _) {
        return Scaffold(
          body: buildBodyContainer(context, controller),
          bottomNavigationBar: MediaQuery.sizeOf(context).width < 750
              ? buildPlaceOrderContainer(context, controller)
              : const SizedBox(),
        );
      },
    );
  }

  Container buildBodyContainer(BuildContext context, CartProvider controller) {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.sizeOf(context).width > 750
            ? MediaQuery.sizeOf(context).width * 0.07
            : MediaQuery.sizeOf(context).width * 0.03,
        right: MediaQuery.sizeOf(context).width > 750
            ? MediaQuery.sizeOf(context).width * 0.07
            : MediaQuery.sizeOf(context).width * 0.03,
      ),
      child: MediaQuery.sizeOf(context).width < 750
          ? SingleChildScrollView(
              child: buildSizedBoxCart(context, controller),
            )
          : buildSizedBoxCart(context, controller),
    );
  }

  SizedBox buildSizedBoxCart(BuildContext context, CartProvider controller) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Wrap(
        direction: MediaQuery.sizeOf(context).width > 750
            ? Axis.horizontal
            : Axis.vertical,
        crossAxisAlignment: MediaQuery.sizeOf(context).width > 750
            ? WrapCrossAlignment.start
            : WrapCrossAlignment.center,
        children: [
          MediaQuery.sizeOf(context).width > 750
              ? SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: LIstCartItems(
                      listCart: controller.listCart,
                      text: "cart",
                    ),
                  ),
                )
              : SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: LIstCartItems(
                    listCart: controller.listCart,
                    text: "cart",
                  ),
                ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            margin: MediaQuery.sizeOf(context).width > 750
                ? const EdgeInsets.only(left: 20, top: 15)
                : const EdgeInsets.only(top: 10.0),
            width: MediaQuery.sizeOf(context).width > 750
                ? MediaQuery.sizeOf(context).width * 0.30
                : MediaQuery.sizeOf(context).width * 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Theme.of(context).colorScheme.copyWith().primary,
                  ),
                  height: 50,
                  width: MediaQuery.sizeOf(context).width > 750
                      ? MediaQuery.sizeOf(context).width * 0.30
                      : MediaQuery.sizeOf(context).width * 0.9,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.local_offer),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Check For Coupons",
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .copyWith()
                                .onTertiaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.keyboard_arrow_right_sharp),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Theme.of(context).colorScheme.copyWith().primary,
                  ),
                  width: MediaQuery.sizeOf(context).width > 750
                      ? MediaQuery.sizeOf(context).width * 0.30
                      : MediaQuery.sizeOf(context).width * 0.9,
                  child: Column(
                    children: [
                      buildRow(
                          context,
                          controller,
                          "Bag Total",
                          "\$ ${controller.bagTotalPrice()}",
                          FontWeight.w600,
                          16.0,
                          Theme.of(context)
                              .colorScheme
                              .copyWith()
                              .onTertiaryContainer),
                      buildRow(
                          context,
                          controller,
                          "Shipping Charge ",
                          "Free",
                          FontWeight.w500,
                          14.0,
                          Theme.of(context).colorScheme.copyWith().tertiary),
                      buildRow(
                          context,
                          controller,
                          "Bag Subtotal ",
                          "\$400",
                          FontWeight.w500,
                          14.0,
                          Theme.of(context).colorScheme.copyWith().tertiary),
                      buildRow(
                          context,
                          controller,
                          "Product Discount(s) ",
                          "- \$100",
                          FontWeight.w500,
                          14.0,
                          Theme.of(context).colorScheme.copyWith().tertiary),
                      buildRow(
                          context,
                          controller,
                          "Total Payable ",
                          "\$ ${controller.bagTotalPrice()}",
                          FontWeight.w600,
                          16.0,
                          Theme.of(context)
                              .colorScheme
                              .copyWith()
                              .onTertiaryContainer),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "You will save \$100 on this order",
                          style: buildTextStyle(
                              context,
                              14.0,
                              FontWeight.w500,
                              Theme.of(context)
                                  .colorScheme
                                  .copyWith()
                                  .tertiary),
                        ),
                      ),
                      MediaQuery.sizeOf(context).width > 750
                          ? buildPlaceOrderContainer(context, controller)
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Container buildPlaceOrderContainer(
      BuildContext context, CartProvider controller) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.85,
        // margin: MediaQuery.sizeOf(context).width > 750
        //     ? const EdgeInsets.only(top: 20)
        //     : EdgeInsets.only(
        //         right: MediaQuery.sizeOf(context).width * 0.07,
        //         left: MediaQuery.sizeOf(context).width * 0.07),
        color: Colors.black,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.015,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total \$ ${controller.bagTotalPrice()}",
                style: buildTextStyle(
                    context,
                    20.0,
                    FontWeight.bold,
                    Theme.of(context)
                        .colorScheme
                        .copyWith()
                        .onTertiaryContainer)),
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.0275,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color:
                      Theme.of(context).colorScheme.copyWith().primaryContainer,
                ),
                child: TextButton(
                  child: Text("Checkout",
                      style: buildTextStyle(
                          context,
                          16.0,
                          FontWeight.bold,
                          Theme.of(context)
                              .colorScheme
                              .copyWith()
                              .onTertiaryContainer)),
                  onPressed: () {
                    // controller.checkOutMethod();
                  },
                )),
          ],
        ));
  }

  TextStyle buildTextStyle(BuildContext context, double fontSize,
      FontWeight fontWeight, Color color) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  Container buildRow(BuildContext context, CartProvider controller, String text,
      String colorName, FontWeight fontWeight, double fontSize, Color color) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      margin: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: buildTextStyle(context, fontSize, fontWeight,
                Theme.of(context).colorScheme.copyWith().onTertiaryContainer),
          ),
          Text(
            colorName,
            style: buildTextStyle(context, fontSize, fontWeight, color),
          ),
        ],
      ),
    );
  }
}
