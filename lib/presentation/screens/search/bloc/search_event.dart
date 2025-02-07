import 'package:equatable/equatable.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
}

final class SearchInitialEvent extends SearchEvent {
  const SearchInitialEvent();

  @override
  List<Object?> get props => [];
}

final class SearchValueChangedEvent extends SearchEvent {
  final String searchValue;

  const SearchValueChangedEvent({required this.searchValue});

  @override
  List<Object?> get props => [searchValue];
}

final class SearchLoadMoreEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}
