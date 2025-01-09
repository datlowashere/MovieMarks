class CrewModel {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;

  CrewModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
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
      profilePath: json['profile_path'] is String
          ? json['profile_path'] as String
          : null,
      creditId: json['credit_id'] is String ? json['credit_id'] as String : "",
      department:
          json['department'] is String ? json['department'] as String : "",
      job: json['job'] is String ? json['job'] as String : "",
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
      'credit_id': creditId,
      'department': department,
      'job': job,
    };
  }

  CrewModel copyWith({
    bool? adult,
    int? gender,
    int? id,
    String? knownForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    String? creditId,
    String? department,
    String? job,
  }) {
    return CrewModel(
      adult: adult ?? this.adult,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      popularity: popularity ?? this.popularity,
      profilePath: profilePath ?? this.profilePath,
      creditId: creditId ?? this.creditId,
      department: department ?? this.department,
      job: job ?? this.job,
    );
  }
}
