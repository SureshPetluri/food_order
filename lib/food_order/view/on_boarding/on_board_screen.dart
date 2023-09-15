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
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: PageView(
              controller: pageController,
              onPageChanged: (int index) {
                _currPageValue = index;
                setState(() {});
                // state.page = index;
              },
              children: [
                _page(
                    1,
                    context,
                    "Next",
                    "Fresh Food",
                    "We make it simple to find the food you crave. Enter your address and let us do the rest",
                    "assest/img/pod_biryani.jpeg"),
                _page(
                    2,
                    context,
                    "Next",
                    "Fast Delivery",
                    "When you order Eat Street, we'll hook you up with exclusive coupons, specials and rewards.",
                    "assest/img/pod_biryani.jpeg"),
                _page(
                    3,
                    context,
                    "Get Started",
                    "Easy payments",
                    "We make food ordering fast, simple and free - no matter if you order online or cash.",
                    "assest/img/pod_biryani.jpeg"),
              ],
            ),
          ),
          // Spacer(),
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
                    width: _currPageValue == index ? 20 : 8,
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
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Skip"),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    _currPageValue++;
                    setState(() {});
                    if (_currPageValue < 3) {
                      pageController.animateToPage(
                        _currPageValue,
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
                          value: _currPageValue == 0
                              ? 33 / 100
                              : _currPageValue == 1
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
              InkWell(
                  onTap: () {
                    _currPageValue++;
                    if (_currPageValue < 3) {
                      pageController.animateToPage(
                        _currPageValue,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_currPageValue == 2 ? "Done" : "Next"),
                  )),
            ],
          ),
          const Spacer(),
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
        // Spacer(),
        //
        // Spacer(),
      ],
    );
  }
}
