import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text.dart';
import 'icon_and_text.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  PageController pageController = PageController(viewportFraction: 0.85);
  PageController pageListController = PageController(viewportFraction: 0.98);
  int _currPageValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  _buildPageItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 20),
              height: 220,
              width: MediaQuery.of(context).size.width - 20,
              margin: const EdgeInsets.only(right: 5, left: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: index.isEven
                      ? const Color(0xFF69c5df)
                      : const Color(0xFF9294cc),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assest/img/food.png"))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 40, left: 35, right: 35),
                width: double.maxFinite,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                      BoxShadow(color: Colors.white, offset: Offset(5, 0))
                    ]),
                child: Container(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Fruit nutrition meal"),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                                5,
                                (index) => const Icon(Icons.star,
                                    color: AppColors.mainColor, size: 15)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextWidget(text: "4.5", color: Color(0xFFccc7c5)),
                          const SizedBox(
                            width: 10,
                          ),
                          TextWidget(
                              text: "1287 comments", color: Color(0xFFccc7c5))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextWidget(
                            text: "Normal",
                            color: AppColors.textColor,
                            icon: Icons.circle_sharp,
                            iconColor: AppColors.iconColor1,
                          ),
                          IconAndTextWidget(
                            text: "1.7km",
                            color: AppColors.textColor,
                            icon: Icons.location_on,
                            iconColor: AppColors.mainColor,
                          ),
                          IconAndTextWidget(
                            text: "32min",
                            color: AppColors.textColor,
                            icon: Icons.access_time_rounded,
                            iconColor: AppColors.iconColor2,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 70),
        color: Colors.white,
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              height: 320,
              child: PageView.builder(
                controller: pageController,
                physics: const ClampingScrollPhysics(),
                itemCount: 5,
                onPageChanged: (int index) {
                  _currPageValue = index;
                  pageListController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                  setState(() {});
                },
                itemBuilder: (context, position) {
                  return _buildPageItem(position);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
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
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.black,
                          width: 1, // Specify the width of the border
                        ),
                        color: _currPageValue == index
                            ? Colors.green
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /*DotsIndicator(
              onTap: (int index) {
                _currPageValue = index;
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease,
                );
                setState(() {});
              },
              dotsCount: 5,
              position: _currPageValue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),*/
            Flexible(
              child: PageView.builder(
                  controller: pageListController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  onPageChanged: (int index) {
                    _currPageValue = index;
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                    setState(() {});
                  },
                  itemBuilder: (context, position) => ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            height: 50,
                            width: MediaQuery.sizeOf(context).width,
                            color: Colors.blue,
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
