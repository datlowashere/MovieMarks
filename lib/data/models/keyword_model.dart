class KeywordModel {
  final int? id;
  final String? name;
  final bool isSelected;

  KeywordModel({this.id, this.name, this.isSelected = false});

  factory KeywordModel.fromJson(Map<String, dynamic> json) {
    return KeywordModel(
        id: json['id'] is int ? json['id'] as int : 0,
        name: json['name'] is String ? json['name'] as String : "");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  KeywordModel copyWith({
    int? id,
    String? name,
    bool? isSelected,
  }) {
    return KeywordModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
