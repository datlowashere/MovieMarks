class CastModel {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  CastModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] is int ? json['id'] as int : 0,
      name: json['name'] is String ? json['name'] as String : "",
      character: json['character'] is String ? json['character'] as String : "",
      profilePath: json['profile_path'] is String ? json['profile_path'] as String : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'character': character,
      'profile_path': profilePath,
    };
  }

  CastModel copyWith({
    int? id,
    String? name,
    String? character,
    String? profilePath,
  }) {
    return CastModel(
      id: id ?? this.id,
      name: name ?? this.name,
      character: character ?? this.character,
      profilePath: profilePath ?? this.profilePath,
    );
  }
}
