class GenreModel {
  final int? id;
  final String? title;
  final bool isSelected;

  GenreModel({
    required this.id,
    required this.title,
    this.isSelected = false
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
        id: json['id'] is int ? json['id'] as int : 0,
        title: json['name'] is String ? json['name'] as String : "");
  }

  GenreModel copyWith({
    int? id,
    String? title,
    bool? isSelected,
}){
    return GenreModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
