import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/genre_model.dart';
import 'package:movie_marks/data/models/movie_model.dart';

enum HomeStatus {
  initial,
  processing,
  success,
  failure,
}

final class HomeState extends Equatable {
  final HomeStatus? status;
  final bool isLoadingPage;
  final List<GenreModel>? listGenres;
  final List<MovieModel>? listMovies;

  const HomeState(
      {this.status,
      this.isLoadingPage = false,
      this.listGenres,
      this.listMovies});

  static HomeState initial() => const HomeState(
        status: HomeStatus.initial,
      );

  HomeState copyWith(
      {HomeStatus? status,
      bool? isLoadingPage,
      List<GenreModel>? listGenres,
      List<MovieModel>? listMovies}) {
    return HomeState(
        status: status ?? this.status,
        isLoadingPage: isLoadingPage ?? this.isLoadingPage,
        listGenres: listGenres ?? this.listGenres,
        listMovies: listMovies ?? this.listMovies);
  }

  @override
  List<Object?> get props => [status, isLoadingPage, listGenres, listMovies];
}
