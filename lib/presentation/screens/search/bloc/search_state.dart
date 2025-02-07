import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/search_model.dart';

enum SearchStatus {
  initial,
  processing,
  success,
  failure,
}

final class SearchState extends Equatable {
  final SearchStatus? status;
  final String? searchValue;
  final SearchModel? searchModel;
  final bool isLoadingMore;

  const SearchState(
      {this.status,
      this.searchValue,
      this.searchModel,
      this.isLoadingMore = false});

  static SearchState initial() => const SearchState(
        status: SearchStatus.initial,
      );

  SearchState copyWith(
      {SearchStatus? status,
      String? searchValue,
      SearchModel? searchModel,
      bool? isLoadingMore}) {
    return SearchState(
        status: status ?? this.status,
        searchValue: searchValue ?? this.searchValue,
        searchModel: searchModel ?? this.searchModel,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore);
  }

  @override
  List<Object?> get props => [status, searchValue, searchModel, isLoadingMore];
}
