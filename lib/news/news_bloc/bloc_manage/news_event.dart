

// Events
abstract class NewsEvent {}

class FetchNewsEvent extends NewsEvent {
  final String country;
  final String category;

  FetchNewsEvent(this.country, this.category);
}

class LoadMoreNewsEvent extends NewsEvent {
  final String country;
  final String category;

  LoadMoreNewsEvent(this.country, this.category);
}