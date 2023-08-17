// States
import '../../news_main.dart';

abstract class NewsState {}

class InitialState extends NewsState {}

class LoadingState extends NewsState {}

class ErrorState extends NewsState {
  final String message;

  ErrorState(this.message);
}

class LoadedState extends NewsState {
  final List<dynamic> articles;

  LoadedState(this.articles);
}
