part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent {}

class LoadCharacters extends CharactersEvent {
  final int? page;

  LoadCharacters({this.page = 1});
}

class SearchCharacters extends CharactersEvent {
  final String? name;

  SearchCharacters({this.name});
}

class LoadMoreCharacters extends CharactersEvent {
  final int? page;

  LoadMoreCharacters({this.page});
}
