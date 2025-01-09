class CastModel {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;

  CastModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      adult: json['adult'] is bool ? json['adult'] as bool : false,
      gender: json['gender'] is int ? json['gender'] as int : 0,
      id: json['id'] is int ? json['id'] as int : 0,
      knownForDepartment: json['known_for_department'] is String
          ? json['known_for_department'] as String
          : "",
      name: json['name'] is String ? json['name'] as String : "",
      originalName: json['original_name'] is String
          ? json['original_name'] as String
          : "",
      popularity:
          json['popularity'] is double ? json['popularity'] as double : 0.0,
      profilePath:
          json['profile_path'] is String ? json['profile_path'] as String : "",
      castId: json['cast_id'] is int ? json['cast_id'] as int : 0,
      character: json['character'] is String ? json['character'] as String : "",
      creditId: json['credit_id'] is String ? json['credit_id'] as String : "",
      order: json['order'] is int ? json['order'] as int : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'gender': gender,
      'id': id,
      'known_for_department': knownForDepartment,
      'name': name,
      'original_name': originalName,
      'popularity': popularity,
      'profile_path': profilePath,
      'cast_id': castId,
      'character': character,
      'credit_id': creditId,
      'order': order,
    };
  }

  CastModel copyWith({
    bool? adult,
    int? gender,
    int? id,
    String? knownForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    int? castId,
    String? character,
    String? creditId,
    int? order,
  }) {
    return CastModel(
      adult: adult ?? this.adult,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      popularity: popularity ?? this.popularity,
      profilePath: profilePath ?? this.profilePath,
      castId: castId ?? this.castId,
      character: character ?? this.character,
      creditId: creditId ?? this.creditId,
      order: order ?? this.order,
    );
  }
}
