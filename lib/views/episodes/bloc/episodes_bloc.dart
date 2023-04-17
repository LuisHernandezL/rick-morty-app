import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prueba/models/episodes.dart';
import 'package:prueba/repositories/episodes_repository.dart';
import 'package:equatable/equatable.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final EpisodeRepository episodesRepository;

  EpisodesBloc()
      : episodesRepository = EpisodeRepository(),
        super(EpisodesState.empy) {
    on<LoadEpisodes>(_handleEpisodesEvent);
    on<LoadMoreEpisodes>(_handleLoadMoreEpisodes);
  }

  Future<void> _handleEpisodesEvent(
    EpisodesEvent event,
    Emitter<EpisodesState> emit,
  ) async {
    emit(state.copyWith(status: EpisodesStatus.loading));
    try {
      final episodes = await episodesRepository.getEpisodes(1);
      emit(state.copyWith(
        status: EpisodesStatus.success,
        episodes: episodes.results,
      ));
    } catch (e) {
      emit(state.copyWith(status: EpisodesStatus.failure));
    }
  }

  Future<void> _handleLoadMoreEpisodes(
    LoadMoreEpisodes event,
    Emitter<EpisodesState> emit,
  ) async {
    emit(state.copyWith(status: EpisodesStatus.loading));
    try {
      final episodes = await episodesRepository.getEpisodes(event.page);
      if (episodes.info!.next != null) {
        emit(state.copyWith(
          status: EpisodesStatus.success,
          episodes: [...state.episodes, ...episodes.results!],
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: EpisodesStatus.failure));
    }
  }
}
