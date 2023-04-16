import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:prueba/models/characters.dart';
import 'package:prueba/repositories/characters_repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository charactersRepository;

  CharactersBloc()
      : charactersRepository = CharactersRepository(),
        super(CharactersState.empty) {
    on<LoadCharacters>(_handleLoadCharacters);
    on<SearchCharacters>(_handleSearchCharacters);
    on<LoadMoreCharacters>(_handleLoadMoreCharacters);
  }

  Future<void> _handleLoadCharacters(
    LoadCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(state.copyWith(status: CharactersStatus.loading));
    try {
      final characters = await charactersRepository.getCharacters(event.page);
      emit(state.copyWith(
        status: CharactersStatus.success,
        characters: characters.results,
      ));
    } catch (e) {
      emit(state.copyWith(status: CharactersStatus.failure));
    }
  }

  Future<void> _handleSearchCharacters(
    SearchCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(state.copyWith(status: CharactersStatus.loading));
    try {
      final characters = await charactersRepository.searchCharacters(
        event.name!,
        'alive',
      );
      emit(state.copyWith(
        status: CharactersStatus.success,
        characters: characters.results,
      ));
    } catch (e) {
      emit(state.copyWith(status: CharactersStatus.failure));
    }
  }

  Future<void> _handleLoadMoreCharacters(
    LoadMoreCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(state.copyWith(status: CharactersStatus.loading));
    try {
      final characters = await charactersRepository.getCharacters(event.page);
      emit(state.copyWith(
        status: CharactersStatus.success,
        characters: [...state.characters, ...characters.results!],
      ));
    } catch (e) {
      emit(state.copyWith(status: CharactersStatus.failure));
    }
  }
}
