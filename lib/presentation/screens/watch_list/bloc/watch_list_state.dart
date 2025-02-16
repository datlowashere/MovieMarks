import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/watch_list_model.dart';

enum WatchListStatus {
  initial,
  processing,
  success,
  failure,
}

class WatchListState extends Equatable {
  final WatchListStatus status;
  final WatchListModel? watchListModel;

  const WatchListState({
    required this.status,
    this.watchListModel,
  });

  static WatchListState initial() => const WatchListState(
    status: WatchListStatus.initial,
  );

  WatchListState copyWith({
    WatchListStatus? status,
    WatchListModel? watchListModel,
  }) {
    return WatchListState(
      status: status ?? this.status,
      watchListModel: watchListModel ?? this.watchListModel,
    );
  }

  @override
  List<Object?> get props => [status, watchListModel];
}
