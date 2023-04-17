part of 'episodes_bloc.dart';

enum EpisodesStatus { initial, loading, success, failure }

class EpisodesState extends Equatable {
  final EpisodesStatus status;
  final List<Episode> episodes;

  const EpisodesState({
    this.status = EpisodesStatus.initial,
    this.episodes = const <Episode>[],
  });

  static EpisodesState empy = const EpisodesState(
    status: EpisodesStatus.initial,
    episodes: <Episode>[],
  );

  EpisodesState copyWith({
    EpisodesStatus? status,
    List<Episode>? episodes,
  }) =>
      EpisodesState(
        status: status ?? this.status,
        episodes: episodes ?? this.episodes,
      );

  @override
  List<Object?> get props => [status, episodes];
}
