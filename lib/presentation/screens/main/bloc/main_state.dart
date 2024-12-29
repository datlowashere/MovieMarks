import 'package:equatable/equatable.dart';

enum MainStatus {
  initial,
  processing,
  success,
  failure,
}

final class MainState extends Equatable {
  final MainStatus? status;
  final bool isLoadingPage;


  const MainState({
    this.status,
    this.isLoadingPage = false,
  });

  static MainState initial() =>
      const MainState(
        status: MainStatus.initial,
      );

  MainState copyWith({
    MainStatus? status,
    bool? isLoadingPage,
  }) {
    return MainState(
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
