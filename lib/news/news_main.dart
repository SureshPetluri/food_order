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
    return const MaterialApp(
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
  MatchEngine _matchEngine=MatchEngine();
   // List? articles;
  // @override
  // Future<void> initState() async {
  //   super.initState();
  //   articles = await fetchNews("in", "health");
  // }

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
                updatedDate: article['pubDate'] ?? "",
                like: false,
                unLike: false,
              ),
            ));
          }
          _matchEngine = MatchEngine(swipeItems: _swipeItems);

          if (snapshot.hasData) {
            return Stack(children: [
              SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  final content = _swipeItems[index].content;
                  String date = _swipeItems[index].content.updatedDate;
                  String time = date.split(" ")[1];
                  int contentTime = (int.parse(time.split(":")[0]) * 60) +
                      int.parse(time.split(":")[1]);
                  String presentDate = DateTime.now().toString();
                  String presentTime = presentDate.split(" ")[1];
                  int presentContentTime =
                      (int.parse(presentTime.split(":")[0]) * 60) +
                          int.parse(presentTime.split(":")[1]);
                  int correctTime = 0;
                  if (contentTime > presentContentTime) {
                    correctTime = contentTime - presentContentTime;
                  } else {
                    correctTime = presentContentTime - contentTime;
                  }
                  return Container(
                    color: Colors.white,
                    child: buildWithOutScrollColumn(
                        index, context, articles, correctTime, content),
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
                        updatedDate: data['pubDate'] ?? "",
                        like: false,
                        unLike: false,
                      ),
                    ));
                  }
                  setState(() {});
                  _matchEngine = MatchEngine(swipeItems: _swipeItems);
                },
              )
            ]);
          } else if (snapshot.hasError) {
            return const Center(
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

  Column buildWithOutScrollColumn(int index, BuildContext context,
      List<dynamic>? articles, int time, Content content) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Image.network(
            content.imageUrl ?? "",
            errorBuilder: (_, __, ___) {
              return Image.asset("assest/images/norway-1.jpeg");
            },
            height: MediaQuery.sizeOf(context).height * 0.4,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            content.title ?? "",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            (content.description ?? ""),
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
              Text("  ${(time/60).ceil()}:${(time%60)..ceil()}min ago/ "),
              Text("$index of ${_swipeItems.length} "),
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
            ? buildLikeRow(index, content)
            : buildLikeBelowRow(content)
      ],
    );
  }

  Row buildLikeRow(int index, Content content) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
             setState(() {
            content.like = true;
             });
          },
          icon: Icon(Icons.thumb_up_sharp),
          color: (content.like ?? false) ? Colors.blue : Colors.grey,
        ),
        const SizedBox(
          width: 5,
        ),
        const Text("1k"),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {
             setState(() {
            content.unLike = true;
             });
          },
          icon: const Icon(Icons.thumb_down),
          color: (content.unLike ?? false) ? Colors.blue : Colors.grey,
        ),
        const SizedBox(
          width: 5,
        ),
        Text("100"),
        const SizedBox(
          width: 10,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.comment_bank_outlined)),
        const SizedBox(
          width: 5,
        ),
        const Text("20"),
        const SizedBox(
          width: 10,
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        const SizedBox(
          width: 10,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
      ],
    );
  }

  Row buildLikeBelowRow(Content content) {
    return Row(
      children: [
        buildColumn(Icons.thumb_up_sharp, content),
        const SizedBox(
          width: 5,
        ),
        buildColumn(
          Icons.thumb_down,
          content,
        ),
        const SizedBox(
          width: 10,
        ),
        buildColumn(Icons.comment_bank_outlined, content),
        const SizedBox(
          width: 10,
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        const SizedBox(
          width: 10,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
      ],
    );
  }

  Column buildColumn(IconData icon, Content content) {
    return Column(
      children: [
        IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (icon == Icons.thumb_up_sharp) {
                content.like = true;
              } else if (icon == Icons.thumb_down) {
                content.unLike = true;
              }
              setState(() {

              });
            },
            icon: Icon(icon)),
        const Text("100"),
      ],
    );
  }
}

class Content {
  final String? imageUrl;
  final String? title;
  final String? description;
  final String? content;
  final String? updatedDate;
  bool? like;
  bool? unLike;

  Content(
      {this.imageUrl,
      this.title,
      this.description,
      this.content,
      this.like,
      this.unLike,
      this.updatedDate});
}
