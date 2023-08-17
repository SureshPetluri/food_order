// Example usage
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../news_main.dart';
import '../provider.dart';
import 'bloc_manage/news_bloc.dart';
import 'bloc_manage/news_event.dart';
import 'bloc_manage/news_state.dart';

class NewsAppUsingSWipeBloc extends StatefulWidget {
  const NewsAppUsingSWipeBloc({Key? key}) : super(key: key);

  @override
  State<NewsAppUsingSWipeBloc> createState() => _NewsAppUsingSWipeBlocState();
}

class _NewsAppUsingSWipeBlocState extends State<NewsAppUsingSWipeBloc>
    with TickerProviderStateMixin {
  final NewsBloc _newsBloc = NewsBloc();
  PageController pageController = PageController(viewportFraction: 0.99);
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;

  @override
  void initState() {
    super.initState();
    _newsBloc.mapEventToState(FetchNewsEvent("in", "health"));
  }

  @override
  void dispose() {
    _newsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<NewsState>(
        stream: _newsBloc.newsStream,
        // initialData: InitialState(),
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is InitialState) {
            return const Center(child: Text("InitialState"));
            // Show initial state UI
          } else if (state is LoadingState) {
            return const Center(child: Text("LoadingState"));
            // Show loading state UI
          } else if (state is ErrorState) {
            return const Center(child: Text("ErrorState"));
            // Show error state UI
          } else if (state is LoadedState) {
            final articles = state.articles;
            // Show loaded state UI
            return Stack(children: [
              SwipeCards(
                matchEngine: _matchEngine!,
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
                    _swipeItems.add(
                      SwipeItem(
                        content: Content(
                          imageUrl: data["image_url"] ?? "",
                          title: data['title'] ?? "",
                          content: data['content'] ?? "",
                          description: data['description'] ?? "",
                          updatedDate: data['pubDate'] ?? "",
                          like: false,
                          unLike: false,
                        ),
                      ),
                    );
                  }
                  _matchEngine = MatchEngine(swipeItems: _swipeItems);
                  setState(() {});
                },
              )
            ]);
          }

          // Return appropriate UI based on the state
          return Container();
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
              Text("  ${(time / 60).ceil()}:${(time % 60)..ceil()}min ago/ "),
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
            : buildLikeBelowRow()
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
        SizedBox(
          width: 5,
        ),
        Text("data"),
        SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              content.unLike = true;
            });
          },
          icon: Icon(Icons.thumb_down),
          color: (content.unLike ?? false) ? Colors.blue : Colors.grey,
        ),
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
}
