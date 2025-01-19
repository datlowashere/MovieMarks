import 'package:movie_marks/data/models/user_model.dart';

class ReviewModel {
  final String? id;
  final String? userId;
  final String? movieId;
  final UserModel? user;
  final String? content;
  final num? ratingPoint;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ReviewModel({
    this.id,
    this.userId,
    this.movieId,
    this.user,
    this.content,
    this.ratingPoint,
    this.createdAt,
    this.updatedAt,
  });

  ReviewModel copyWith({
    String? id,
    String? userId,
    String? movieId,
    UserModel? user,
    String? content,
    num? ratingPoint,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      movieId: movieId ?? this.movieId,
      user: user ?? this.user,
      content: content ?? this.content,
      ratingPoint: ratingPoint ?? this.ratingPoint,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] is String ? json['_id'] as String : "",
      movieId: json['id'] is String ? json['id'] as String : "",
      user: json['userId'] != null
          ? (json['userId'] is Map<String, dynamic>
              ? UserModel.fromJson(json['userId'] as Map<String, dynamic>)
              : null)
          : null,
      content: json['content'] is String ? json['content'] as String : "",
      ratingPoint:
          json['ratingPoint'] is num ? json['ratingPoint'] as num : null,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is String
              ? DateTime.tryParse(json['createdAt'] as String)
              : null)
          : null,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is String
              ? DateTime.tryParse(json['updatedAt'] as String)
              : null)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': user?.toJson(),
      'content': content,
      'ratingPoint': ratingPoint,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> postToJson() {
    return {
      'userId': userId,
      'id': movieId,
      'content': content ?? "",
      'ratingPoint': ratingPoint ?? 0,
    };
  }
}
