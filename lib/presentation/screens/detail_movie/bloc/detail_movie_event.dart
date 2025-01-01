import 'package:equatable/equatable.dart';

sealed class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

final class DetailMovieInitialEvent extends DetailMovieEvent {
  final bool isLoadingPage;
  final int movieId;

  const DetailMovieInitialEvent( {required this.isLoadingPage, required this.movieId,});

  @override
  List<Object?> get props => [];
}

