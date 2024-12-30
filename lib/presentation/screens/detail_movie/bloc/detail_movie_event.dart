import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/movie_model.dart';

sealed class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

final class DetailMovieInitialEvent extends DetailMovieEvent {
  final bool isLoadingPage;
  final MovieModel movieModel;

  const DetailMovieInitialEvent( {required this.isLoadingPage, required this.movieModel,});

  @override
  List<Object?> get props => [];
}

