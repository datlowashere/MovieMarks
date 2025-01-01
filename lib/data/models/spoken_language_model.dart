class SpokenLanguageModel {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguageModel({
    this.englishName,
    this.iso6391,
    this.name,
  });

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) {
    return SpokenLanguageModel(
      englishName:
          json['english_name'] is String ? json['english_name'] as String : "",
      iso6391: json['iso_639_1'] is String ? json['iso_639_1'] as String : "",
      name: json['name'] is String ? json['name'] as String : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'english_name': englishName,
      'iso_639_1': iso6391,
      'name': name,
    };
  }

  SpokenLanguageModel copyWith({
    String? englishName,
    String? iso6391,
    String? name,
  }) {
    return SpokenLanguageModel(
      englishName: englishName ?? this.englishName,
      iso6391: iso6391 ?? this.iso6391,
      name: name ?? this.name,
    );
  }
}
