part of 'episodes_bloc.dart';

@immutable
abstract class EpisodesEvent {}

class LoadEpisodes extends EpisodesEvent {
  final int? page;

  LoadEpisodes({this.page = 1});
}

class LoadMoreEpisodes extends EpisodesEvent {
  final int? page;

  LoadMoreEpisodes({this.page});
}
