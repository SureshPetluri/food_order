import 'package:flutter/material.dart';

import '../sign_in/sign_in_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  PageController pageController = PageController(initialPage: 0);
   int _currPageValue = 0;

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
          _currPageValue = index;
          setState(() {

          });
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
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
                (index) => InkWell(
              onTap: () {
                 _currPageValue = index;
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease,
                );
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                  height: 8,
                  width: _currPageValue == index ?20:8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    //     border: Border.all(
                    //       color: Colors.black,
                    //       width: 1, // Specify the width of the border
                    // ),
                    color: _currPageValue == index
                        ? Colors.green
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignInScreen()));
            }, child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Skip"),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  if (index < 3) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.decelerate,
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: CircularProgressIndicator(
                        value: index == 1
                            ? 33 / 100
                            : index == 2
                                ? 66 / 100
                                : 100 / 100,
                        strokeWidth: 3,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.deepPurpleAccent.shade200),
                      ),
                    ),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.deepPurpleAccent.shade200,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(onTap: () {
              if (index < 3) {
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.decelerate,
                );
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignInScreen()));
              }
            }, child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child:Text(index == 3 ? "Done" : "Next"),
            )),

          ],
        ),
        Spacer(),
      ],
    );
  }
}
