class ProductionCompanyModel {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  ProductionCompanyModel({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyModel(
      id: json['id'] is int ? json['id'] as int : 0,
      logoPath: json['logo_path'] is String ? json['logo_path'] as String : "",
      name: json['name'] is String ? json['name'] as String : "",
      originCountry: json['origin_country'] is String
          ? json['origin_country'] as String
          : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }

  ProductionCompanyModel copyWith({
    int? id,
    String? logoPath,
    String? name,
    String? originCountry,
  }) {
    return ProductionCompanyModel(
      id: id ?? this.id,
      logoPath: logoPath ?? this.logoPath,
      name: name ?? this.name,
      originCountry: originCountry ?? this.originCountry,
    );
  }
}
