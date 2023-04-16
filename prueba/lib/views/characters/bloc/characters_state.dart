part of 'characters_bloc.dart';

enum CharactersStatus { initial, loading, success, failure }

class CharactersState extends Equatable {
  final CharactersStatus status;
  final List<Character> characters;

  const CharactersState({
    this.status = CharactersStatus.initial,
    this.characters = const <Character>[],
  });

  static CharactersState empty = const CharactersState(
    status: CharactersStatus.initial,
    characters: <Character>[],
  );

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
  }) =>
      CharactersState(
        status: status ?? this.status,
        characters: characters ?? this.characters,
      );

  @override
  List<Object> get props => [status, characters];
}
