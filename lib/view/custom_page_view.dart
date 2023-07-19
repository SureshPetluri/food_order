import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'custom_widgets/app_text.dart';
import 'custom_widgets/custom_widgets.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({Key? key,}) : super(key: key);
  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  PageController pageController = PageController(viewportFraction: 0.85);
  PageController pageListController = PageController(viewportFraction: 0.98);
  int _currPageValue = 0;


  @override
  void initState() {
    getAddress();
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
              height: 180,
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
              alignment: const Alignment(0.0, 0.7),
              child: Container(
                margin: const EdgeInsets.only(left: 35, right: 35),
                width: double.maxFinite,
                height: 100,
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
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Fruit nutrition meal"),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                                5,
                                (index) => const Icon(Icons.star,
                                    color: AppColors.mainColor, size: 15)),
                          ),
                           SizedBox(
                            width: MediaQuery.sizeOf(context).width > 380 ? 10 : 4,
                          ),
                          const TextWidget(
                              text: "4.5", color: Color(0xFFccc7c5)),
                          const SizedBox(
                            width: 10,
                          ),
                          const TextWidget(
                              text: "1287 comments",
                              color: Color(0xFFccc7c5))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 30,
          ),
        ),
        elevation: 0.0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<Map>(
                valueListenable: cityNotifier,
                builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value["city"] ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      value["local"] ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.blue,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        color: Colors.white,
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              height: 250,
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
                      itemBuilder: (BuildContext context, int index) => Center(
                          child:
                              CustomCard(biryani: biryanis[_currPageValue])))),
            )
          ],
        ),
      ),
    );
  }

  List<String> biryanis = [
    "assest/img/biryani.webp",
    "assest/img/biryani-1.webp",
    "assest/img/mandi.jpg",
    "assest/img/mandi-1.webp",
    "assest/img/pod_biryani.jpeg"
  ];
}
