import 'package:flutter/material.dart';

import '../custom_page_view.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          // state.page = index;
        },
        children: [
          _page(
              1,
              context,
              "Next",
              "Fresh Food",
              "We make it simple to find the food you crave. Enter your address and let us do the rest",
              "assest/img/onboard-1.png"),
          _page(
              2,
              context,
              "Next",
              "Fast Delivery",
              "When you order Eat Street, we'll hook you up with exclusive coupons, specials and rewards.",
              "assest/img/onboard-2.png"),
          _page(
              3,
              context,
              "Get Started",
              "Easy payments",
              "We make food ordering fast, simple and free - no matter if you order online or cash.",
              "assest/img/onboard-3.png"),
        ],
      ),
    );
  }

  Column _page(int index, BuildContext context, String buttonName, String title,
      String subTitle, String imageUrl) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.normal),
          ),
        ),
        Container(
          // width: 375.w,
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text(
            subTitle,
            style: TextStyle(color: Colors.black),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (index < 3) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.decelerate,
              );

            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductsGrid()));
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 100, left: 25, right: 25),
            // width: 325.w,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(10, 10),
                  )
                ]),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        )
      ],
    );
  }
}
