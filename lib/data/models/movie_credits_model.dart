import 'cast_model.dart';
import 'crew_model.dart';

class MovieCreditsModel {
  final List<CastModel> cast;
  final List<CrewModel> crew;

  MovieCreditsModel({
    required this.cast,
    required this.crew,
  });

  factory MovieCreditsModel.fromJson(Map<String, dynamic> json) {
    return MovieCreditsModel(
      cast: (json['cast'] is List)
          ? (json['cast'] as List)
              .map((item) => CastModel.fromJson(item))
              .toList()
          : [],
      crew: (json['crew'] is List)
          ? (json['crew'] as List)
              .map((item) => CrewModel.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cast': cast.map((e) => e.toJson()).toList(),
      'crew': crew.map((e) => e.toJson()).toList(),
    };
  }

  MovieCreditsModel copyWith({
    List<CastModel>? cast,
    List<CrewModel>? crew,
  }) {
    return MovieCreditsModel(
      cast: cast ?? this.cast,
      crew: crew ?? this.crew,
    );
  }
}
