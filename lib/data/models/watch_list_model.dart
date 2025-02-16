import 'package:movie_marks/data/models/movie_model.dart';

class WatchListModel {
  final String message;
  final List<MovieModel> movieModel;
  final Pagination pagination;

  WatchListModel({
    required this.message,
    required this.movieModel,
    required this.pagination,
  });

  factory WatchListModel.fromJson(Map<String, dynamic> json) {
    return WatchListModel(
      message: json["message"] is String ? json["message"] as String : "",
      movieModel: json["bookmarks"] is List
          ? (json["bookmarks"] as List)
              .whereType<Map<String, dynamic>>()
              .map((item) => MovieModel.fromJson(item))
              .toList()
          : [],
      pagination: json["pagination"] is Map<String, dynamic>
          ? Pagination.fromJson(json["pagination"] as Map<String, dynamic>)
          : Pagination.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "bookmarks": movieModel.map((e) => e.toJson()).toList(),
      "pagination": pagination.toJson(),
    };
  }

  WatchListModel copyWith({
    String? message,
    List<MovieModel>? movieModel,
    Pagination? pagination,
  }) {
    return WatchListModel(
      message: message ?? this.message,
      movieModel: movieModel ?? this.movieModel,
      pagination: pagination ?? this.pagination,
    );
  }
}

class Pagination {
  final int totalBookmarks;
  final int totalPages;
  final int currentPage;
  final int pageSize;

  Pagination({
    required this.totalBookmarks,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalBookmarks: json["totalBookmarks"] is num
          ? (json["totalBookmarks"] as num).toInt()
          : 0,
      totalPages:
          json["totalPages"] is num ? (json["totalPages"] as num).toInt() : 0,
      currentPage:
          json["currentPage"] is num ? (json["currentPage"] as num).toInt() : 0,
      pageSize: json["pageSize"] is num ? (json["pageSize"] as num).toInt() : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalBookmarks": totalBookmarks,
      "totalPages": totalPages,
      "currentPage": currentPage,
      "pageSize": pageSize,
    };
  }

  Pagination copyWith({
    int? totalBookmarks,
    int? totalPages,
    int? currentPage,
    int? pageSize,
  }) {
    return Pagination(
      totalBookmarks: totalBookmarks ?? this.totalBookmarks,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  factory Pagination.empty() {
    return Pagination(
      totalBookmarks: 0,
      totalPages: 0,
      currentPage: 0,
      pageSize: 0,
    );
  }
}
