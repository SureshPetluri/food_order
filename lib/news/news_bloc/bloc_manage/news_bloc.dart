// BLoC
import 'dart:async';

import 'package:swipe_cards/swipe_cards.dart';

import '../../news_main.dart';
import '../../provider.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc {
  final StreamController<NewsState> _newsController =
  StreamController<NewsState>.broadcast();

  Stream<NewsState> get newsStream => _newsController.stream;

  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;

  void mapEventToState(NewsEvent event) {
    if (event is FetchNewsEvent) {
      _fetchNews(event.country, event.category);
    } else if (event is LoadMoreNewsEvent) {
      _loadMoreNews(event.country, event.category);
    }
  }

  void _fetchNews(String country, String category) async {
    try {
      _newsController.add(LoadingState());

      final articles = await fetchNews(country, category);
      for (int i = 0; i < (articles.length ?? 0); i++) {
        final article = articles[i];
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
      _newsController.add(LoadedState(articles));
    } catch (e) {
       _newsController.add(ErrorState('Failed to fetch news'));
    }
  }

  void _loadMoreNews(String country, String category) async {
    try {
      _newsController.add(LoadingState());

      final articles = await fetchNews(country, category);
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
      // _newsController.add(LoadedState(_swipeItems[i]));
    } catch (e) {
      _newsController.add(ErrorState('Failed to fetch more news'));
    }
  }

  void dispose() {
    _newsController.close();
  }
}
