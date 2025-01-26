import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/movie_model.dart';

enum WatchListStatus {
  initial,
  processing,
  success,
  failure,
}

class WatchListState extends Equatable {
  final WatchListStatus? status;
  final List<MovieModel>? listMovies;

  const WatchListState({
    this.status,
    this.listMovies,
  });

  static WatchListState initial() => const WatchListState(
    status: WatchListStatus.initial,
  );

  WatchListState copyWith({
    WatchListStatus? status,
    List<MovieModel>? listMovies,
  }) {
    return WatchListState(
      status: status ?? this.status,
      listMovies: listMovies ?? this.listMovies,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listMovies,
      ];
}
