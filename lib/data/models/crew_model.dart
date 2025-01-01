
class CrewModel {
  final int id;
  final String name;
  final String job;
  final String profilePath;

  CrewModel({
    required this.id,
    required this.name,
    required this.job,
    required this.profilePath,
  });

  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
      id: json['id'] is int ? json['id'] as int : 0,
      name: json['name'] is String ? json['name'] as String : "",
      job: json['job'] is String ? json['job'] as String : "",
      profilePath: json['profile_path'] is String ? json['profile_path'] as String : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'job': job,
      'profile_path': profilePath,
    };
  }

  CrewModel copyWith({
    int? id,
    String? name,
    String? job,
    String? profilePath,
  }) {
    return CrewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      job: job ?? this.job,
      profilePath: profilePath ?? this.profilePath,
    );
  }
}
