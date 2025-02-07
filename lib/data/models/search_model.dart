import 'movie_model.dart';

class SearchModel {
  final int? page;
  final List<MovieModel>? movies;
  final int? totalPages;
  final int? totalResults;

  SearchModel({
    this.page,
    this.movies,
    this.totalPages,
    this.totalResults,
  });

  SearchModel copyWith({
    int? page,
    List<MovieModel>? movies,
    int? totalPages,
    int? totalResults,
  }) {
    return SearchModel(
      page: page ?? this.page,
      movies: movies ?? this.movies,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      page: json['page'] is int ? json['page'] as int : 0,
      movies: json['results'] is List
          ? (json['results'] as List)
              .map((e) =>
                  e is Map<String, dynamic> ? MovieModel.fromJson(e) : [])
              .whereType<MovieModel>()
              .toList()
          : [],
      totalPages: json['total_pages'] is int ? json['total_pages'] as int : 0,
      totalResults:
          json['total_results'] is int ? json['total_results'] as int : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': movies?.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}
