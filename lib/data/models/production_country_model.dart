class ProductionCountryModel {
  final String? iso31661;
  final String? name;

  ProductionCountryModel({
    this.iso31661,
    this.name,
  });

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) {
    return ProductionCountryModel(
      iso31661:
          json['iso_3166_1'] is String ? json['iso_3166_1'] as String : "",
      name: json['name'] is String ? json['name'] as String : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_3166_1': iso31661,
      'name': name,
    };
  }

  ProductionCountryModel copyWith({
    String? iso31661,
    String? name,
  }) {
    return ProductionCountryModel(
      iso31661: iso31661 ?? this.iso31661,
      name: name ?? this.name,
    );
  }
}
