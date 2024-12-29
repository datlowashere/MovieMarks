class MovieModel {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final bool isSaved;
  final bool isRating;

  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.isSaved = false,
    this.isRating = false,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'] is bool ? json['adult'] as bool : false,
      backdropPath: json['backdrop_path'] is String
          ? json['backdrop_path'] as String
          : "",
      genreIds: json['genre_ids'] != null
          ? (json['genre_ids'] as List<dynamic>)
              .map((item) => item is int ? item : 0)
              .toList()
          : [],
      id: json['id'] is int ? json['id'] as int : 0,
      originalLanguage: json['original_language'] is String
          ? json['original_language'] as String
          : "",
      originalTitle: json['original_title'] is String
          ? json['original_title'] as String
          : "",
      overview: json['overview'] is String ? json['overview'] as String : "",
      popularity:
          json['popularity'] is double ? json['popularity'] as double : 0.0,
      posterPath:
          json['poster_path'] is String ? json['poster_path'] as String : "",
      releaseDate:
          json['release_date'] is String ? json['release_date'] as String : "",
      title: json['title'] is String ? json['title'] as String : "",
      video: json['video'] is bool ? json['video'] as bool : false,
      voteAverage:
          json['vote_average'] is double ? json['vote_average'] as double : 0.0,
      voteCount: json['vote_count'] is int ? json['vote_count'] as int : 0,
    );
  }

  MovieModel copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
    bool? isSaved,
    bool? isRating,
  }) {
    return MovieModel(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        isRating: isRating ?? this.isRating,
        isSaved: isSaved ?? this.isSaved);
  }
}
