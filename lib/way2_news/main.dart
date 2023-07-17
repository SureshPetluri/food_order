import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsAppUsingPageView(),
    );
  }
}

class NewsAppUsingPageView extends StatefulWidget {
  const NewsAppUsingPageView({Key? key}) : super(key: key);

  @override
  State<NewsAppUsingPageView> createState() => _NewsAppUsingPageViewState();
}

class _NewsAppUsingPageViewState extends State<NewsAppUsingPageView> {
  PageController pageController = PageController(viewportFraction: 0.99);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: pageController,
          itemCount: imageList.length,
          itemBuilder: (BuildContext context, int index) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      imageList[index],
                      height: MediaQuery.sizeOf(context).height * 0.4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "djhfgieuhvjd bdshvieudvldkjv baedu   duygfsdjb lsdfyvosb  bg b "),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,bottom: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.grey,
                          size: 20,
                        ),
                        Text("14 min ago / "),
                        Text("$index of ${imageList.length} "),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.grey,
                    indent: 10,
                    endIndent: 10,
                  ),
                  MediaQuery.sizeOf(context).width>300 ?
                  buildLikeRow():buildLikeBelowRow()
                ],
              )),
    );
  }

  Row buildLikeRow() {
    return Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.thumb_up_sharp)),
                    SizedBox(
                      width: 5,
                    ),
                    Text("data"),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.thumb_down)),
                    SizedBox(
                      width: 5,
                    ),
                    Text("data"),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.comment_bank_outlined)),
                    SizedBox(
                      width: 5,
                    ),
                    Text("data"),
                    SizedBox(
                      width: 10,
                    ),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                  ],
                );
  }
  Row buildLikeBelowRow() {
    return Row(
      children: [
        buildColumn(Icons.thumb_up_sharp),
        SizedBox(
          width: 5,
        ),
        buildColumn(Icons.thumb_down),
        SizedBox(
          width: 10,
        ),
        buildColumn(Icons.comment_bank_outlined),
        SizedBox(
          width: 10,
        ),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        SizedBox(
          width: 10,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
      ],
    );
  }

  Column buildColumn(IconData icon) {
    return Column(

        children: [
          IconButton(
            padding: EdgeInsets.zero,
              onPressed: () {}, icon: Icon(icon)),
          Text("data"),
        ],
      );
  }
  List<String> imageList = [
    "assest/images/desserts/01-lemon-cheesecake.png",
    "assest/images/desserts/01-lemon-cheesecake.png",
    "assest/images/desserts/01-lemon-cheesecake.png",
    "assest/images/desserts/01-lemon-cheesecake-bg.png",
    "assest/images/desserts/01-lemon-cheesecake-bg.png",
    "assest/images/desserts/01-lemon-cheesecake-bg.png",
    "assest/images/desserts/01-lemon-cheesecake-bg-lg.png",
    "assest/images/desserts/01-lemon-cheesecake-bg-lg.png",
    "assest/images/desserts/01-lemon-cheesecake-bg-lg.png",
    "assest/images/desserts/02-chocolate-cake-1.png",
    "assest/images/desserts/03-chocolate-donuts.png",
    "assest/images/desserts/04-fluffy-cake.png",
    "assest/images/desserts/04-fluffy-cake.png",
    "assest/images/desserts/04-fluffy-cake.png",
    "assest/images/desserts/05-macaroons.png",
    "assest/images/desserts/06-white-cream-cake.png",
    "assest/images/desserts/07-honey-cake.png",
    "assest/images/desserts/07-honey-cake.png",
    "assest/images/desserts/07-honey-cake.png",
    "assest/images/desserts/08-cream-cupcakes.png",
    "assest/images/desserts/09-fruit-plate.png",
    "assest/images/desserts/09-fruit-plate.png",
    "assest/images/desserts/09-fruit-plate.png",
    "assest/images/desserts/10-strawberries.png",
    "assest/images/desserts/11-powdered-cake.png",
    "assest/images/desserts/11-powdered-cake.png",
    "assest/images/desserts/11-powdered-cake.png",
    "assest/images/desserts/12-chocolate-cake-2.png",
    "assest/images/desserts/13-strawberry-powdered-cake.png",
    "assest/images/desserts/13-strawberry-powdered-cake.png",
    "assest/images/desserts/13-strawberry-powdered-cake.png",
    "assest/images/desserts/14-fruit-pie.png",
    "assest/images/desserts/15-apple-pie.png",
    "assest/images/desserts/15-apple-pie.png",
    "assest/images/desserts/15-apple-pie.png",
  ];
}
