import 'package:equatable/equatable.dart';

enum HomeStatus {
  initial,
  processing,
  success,
  failure,
}

final class HomeState extends Equatable {
  final HomeStatus? status;
  final bool isLoadingPage;


  const HomeState({
    this.status,
    this.isLoadingPage = false,
  });

  static HomeState initial() =>
      const HomeState(
        status: HomeStatus.initial,
      );

  HomeState copyWith({
    HomeStatus? status,
    bool? isLoadingPage,
  }) {
    return HomeState(
        status: status ?? this.status,
        isLoadingPage: isLoadingPage ?? this.isLoadingPage
    );
  }

  @override
  List<Object?> get props =>
      [
        status,
        isLoadingPage
      ];
}
