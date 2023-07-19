import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'provider.dart';

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

class _NewsAppUsingPageViewState extends State<NewsAppUsingPageView>
    with TickerProviderStateMixin {
  PageController pageController = PageController(viewportFraction: 0.99);
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //business,entertainment,environment,food,health,politics,science,sports,technology,top,tourism,world
      body: FutureBuilder(
        future: fetchNews("in", "health"),
        builder: (context, snapshot) {
          final articles = snapshot.data;

          for (int i = 0; i < (articles?.length ?? 0); i++) {
            final article = articles?[i];
            _swipeItems.add(SwipeItem(
              content: Content(
                  imageUrl: article["image_url"] ?? "",
                  title: article['title'] ?? "",
                  content: article['content'] ?? "",
                  description: article['description'] ?? "",
                  updatedDate: article['pubDate'] ?? ""),
            ));
          }
          _matchEngine = MatchEngine(swipeItems: _swipeItems);

          if (snapshot.hasData) {
            return Stack(children: [
              SwipeCards(
                matchEngine: _matchEngine!,
                itemBuilder: (BuildContext context, int index) {
                  String date = _swipeItems[index].content.updatedDate;
                  String time = date.split(" ")[1];
                  String contentTime0 = time.split(":")[0];
                  String contentTime1 = time.split(":")[1];

                  String presentDate = DateTime.now().toString();
                  String presentTime = presentDate.split(" ")[1];
                  String presentContentTime0 = presentTime.split(":")[0];
                  String presentContentTime1 = presentTime.split(":")[1];
                  String correctTime =
                      "${int.parse(presentContentTime0) - int.parse(contentTime0)} :${int.parse(presentContentTime1) - int.parse(contentTime1)}";
                  // print("${int.parse(presentContentTime0) -int.parse(contentTime0)}  ${contentTime1} ${presentContentTime1}");
                  return Container(
                    color: Colors.white,
                    child: buildWithOutScrollColumn(
                        index, context, articles, correctTime),
                  );
                },
                onStackFinished: () async {
                  var dataFetch = await fetchNews("in", "business,");
                  for (int i = 0; i < (dataFetch.length); i++) {
                    final data = dataFetch[i];
                    _swipeItems.add(SwipeItem(
                      content: Content(
                          imageUrl: data["image_url"] ?? "",
                          title: data['title'] ?? "",
                          content: data['content'] ?? "",
                          description: data['description'] ?? "",
                          updatedDate: data['pubDate'] ?? ""),
                    ));
                  }
                  _matchEngine = MatchEngine(swipeItems: _swipeItems);
                  setState(() {});
                },
              )
            ]);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to fetch news'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Column buildWithOutScrollColumn(
      int index, BuildContext context, List<dynamic>? articles, String time) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Image.network(
            _swipeItems[index].content.imageUrl,
            errorBuilder: (_, __, ___) {
              return Image.asset("assest/images/norway-1.jpeg");
            },
            height: MediaQuery.sizeOf(context).height * 0.4,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            _swipeItems[index].content.title ?? "",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            (_swipeItems[index].content.description ?? ""),
            overflow: TextOverflow.ellipsis,
            maxLines: 12,
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 5),
          child: Row(
            children: [
              const Icon(
                Icons.access_time,
                color: Colors.grey,
                size: 20,
              ),
              Text("  $time min ago/ "),
              Text("$index of ${articles?.length} "),
            ],
          ),
        ),
        const Divider(
          thickness: 2,
          color: Colors.grey,
          indent: 10,
          endIndent: 10,
        ),
        MediaQuery.sizeOf(context).width > 300
            ? buildLikeRow()
            : buildLikeBelowRow()
      ],
    );
  }

  Row buildLikeRow() {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up_sharp)),
        SizedBox(
          width: 5,
        ),
        Text("data"),
        SizedBox(
          width: 10,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.thumb_down)),
        SizedBox(
          width: 5,
        ),
        Text("data"),
        SizedBox(
          width: 10,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.comment_bank_outlined)),
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
            padding: EdgeInsets.zero, onPressed: () {}, icon: Icon(icon)),
        Text("data"),
      ],
    );
  }
// List<String> imageList = [
//   "assest/images/desserts/01-lemon-cheesecake.png",
//   "assest/images/desserts/01-lemon-cheesecake.png",
//   "assest/images/desserts/01-lemon-cheesecake.png",
//   "assest/images/desserts/01-lemon-cheesecake-bg.png",
//   "assest/images/desserts/01-lemon-cheesecake-bg.png",
//   "assest/images/desserts/01-lemon-cheesecake-bg.png",
//   "assest/images/desserts/01-lemon-cheesecake-bg-lg.png",
//   "assest/images/desserts/01-lemon-cheesecake-bg-lg.png",
//   "assest/images/desserts/01-lemon-cheesecake-bg-lg.png",
//   "assest/images/desserts/02-chocolate-cake-1.png",
//   "assest/images/desserts/03-chocolate-donuts.png",
//   "assest/images/desserts/04-fluffy-cake.png",
//   "assest/images/desserts/04-fluffy-cake.png",
//   "assest/images/desserts/04-fluffy-cake.png",
//   "assest/images/desserts/05-macaroons.png",
//   "assest/images/desserts/06-white-cream-cake.png",
//   "assest/images/desserts/07-honey-cake.png",
//   "assest/images/desserts/07-honey-cake.png",
//   "assest/images/desserts/07-honey-cake.png",
//   "assest/images/desserts/08-cream-cupcakes.png",
//   "assest/images/desserts/09-fruit-plate.png",
//   "assest/images/desserts/09-fruit-plate.png",
//   "assest/images/desserts/09-fruit-plate.png",
//   "assest/images/desserts/10-strawberries.png",
//   "assest/images/desserts/11-powdered-cake.png",
//   "assest/images/desserts/11-powdered-cake.png",
//   "assest/images/desserts/11-powdered-cake.png",
//   "assest/images/desserts/12-chocolate-cake-2.png",
//   "assest/images/desserts/13-strawberry-powdered-cake.png",
//   "assest/images/desserts/13-strawberry-powdered-cake.png",
//   "assest/images/desserts/13-strawberry-powdered-cake.png",
//   "assest/images/desserts/14-fruit-pie.png",
//   "assest/images/desserts/15-apple-pie.png",
//   "assest/images/desserts/15-apple-pie.png",
//   "assest/images/desserts/15-apple-pie.png",
// ];
}

class Content {
  final String? imageUrl;
  final String? title;
  final String? description;
  final String? content;
  final String? updatedDate;

  Content(
      {this.imageUrl,
      this.title,
      this.description,
      this.content,
      this.updatedDate});
}
