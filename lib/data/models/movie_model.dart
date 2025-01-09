import 'package:movie_marks/data/models/belongs_to_collection_model.dart';
import 'package:movie_marks/data/models/genre_model.dart';
import 'package:movie_marks/data/models/production_company_model.dart';
import 'package:movie_marks/data/models/production_country_model.dart';
import 'package:movie_marks/data/models/spoken_language_model.dart';

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
  final BelongsToCollectionModel? belongsToCollection;
  final int? budget;
  final List<GenreModel>? genres;
  final String? homepage;
  final String? imdbId;
  final List<String>? originCountry;
  final List<ProductionCompanyModel>? productionCompanies;
  final List<ProductionCountryModel>? productionCountries;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguageModel>? spokenLanguages;
  final String? status;
  final String? tagline;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.isSaved = false,
    this.isRating = false,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.imdbId,
    this.originCountry,
    this.productionCompanies,
    this.productionCountries,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'] is bool ? json['adult'] as bool : false,
      backdropPath: json['backdrop_path'] is String
          ? json['backdrop_path'] as String
          : "",
      genreIds: json['genre_ids'] is List
          ? (json['genre_ids'] as List).map((item) => item as int).toList()
          : [],
      id: json['id'] is int ? json['id'] as int : 0,
      originalLanguage: json['original_language'] is String
          ? json['original_language'] as String
          : "",
      originalTitle: json['original_title'] is String
          ? json['original_title'] as String
          : "",
      overview: json['overview'] is String ? json['overview'] as String : "",
      popularity: json['popularity'] is num
          ? (json['popularity'] as num).toDouble()
          : 0.0,
      posterPath:
          json['poster_path'] is String ? json['poster_path'] as String : "",
      releaseDate:
          json['release_date'] is String ? json['release_date'] as String : "",
      title: json['title'] is String ? json['title'] as String : "",
      video: json['video'] is bool ? json['video'] as bool : false,
      voteAverage: json['vote_average'] is num
          ? (json['vote_average'] as num).toDouble()
          : 0.0,
      voteCount: json['vote_count'] is int ? json['vote_count'] as int : 0,
      belongsToCollection: json['belongs_to_collection'] is Map<String, dynamic>
          ? BelongsToCollectionModel.fromJson(
              json['belongs_to_collection'] as Map<String, dynamic>)
          : null,
      budget: json['budget'] is int ? json['budget'] as int : 0,
      genres: json['genres'] is List
          ? (json['genres'] as List)
              .map((item) => GenreModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : [],
      homepage: json['homepage'] is String ? json['homepage'] as String : "",
      imdbId: json['imdb_id'] is String ? json['imdb_id'] as String : "",
      originCountry: json['origin_country'] is List
          ? (json['origin_country'] as List)
              .map((item) => item as String)
              .toList()
          : [],
      productionCompanies: json['production_companies'] is List
          ? (json['production_companies'] as List)
              .map((item) =>
                  ProductionCompanyModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : [],
      productionCountries: json['production_countries'] is List
          ? (json['production_countries'] as List)
              .map((item) =>
                  ProductionCountryModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : [],
      revenue: json['revenue'] is int ? json['revenue'] as int : 0,
      runtime: json['runtime'] is int ? json['runtime'] as int : 0,
      spokenLanguages: json['spoken_languages'] is List
          ? (json['spoken_languages'] as List)
              .map((item) =>
                  SpokenLanguageModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : [],
      status: json['status'] is String ? json['status'] as String : "",
      tagline: json['tagline'] is String ? json['tagline'] as String : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'belongs_to_collection': belongsToCollection?.toJson(),
      'budget': budget,
      'genres': genres?.map((genre) => genre.toJson()).toList(),
      'homepage': homepage,
      'imdb_id': imdbId,
      'origin_country': originCountry,
      'production_companies':
          productionCompanies?.map((company) => company.toJson()).toList(),
      'production_countries':
          productionCountries?.map((country) => country.toJson()).toList(),
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages':
          spokenLanguages?.map((language) => language.toJson()).toList(),
      'status': status,
      'tagline': tagline,
    };
  }
}
