import 'package:movie_marks/data/models/review_model.dart';

class ReviewDataModel {
  final String averageRating;
  final List<ReviewModel> reviews;

  ReviewDataModel({
    required this.averageRating,
    required this.reviews,
  });

  ReviewDataModel copyWith(
      {String? averageRating, List<ReviewModel>? reviews}) {
    return ReviewDataModel(
        averageRating: averageRating ?? this.averageRating,
        reviews: reviews ?? this.reviews);
  }

  factory ReviewDataModel.fromJson(Map<String, dynamic> json) {
    var reviewsList = json['reviews'] as List;
    List<ReviewModel> reviews = reviewsList
        .map((reviewJson) => ReviewModel.fromJson(reviewJson))
        .toList();

    return ReviewDataModel(
      averageRating: json['averageRating'] is String
          ? json['averageRating'] as String
          : "",
      reviews: reviews,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageRating': averageRating,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}
