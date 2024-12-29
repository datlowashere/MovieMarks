import 'package:equatable/equatable.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();
}

final class MainInitialEvent extends MainEvent {
  final bool isLoadingPage;

  const MainInitialEvent({required this.isLoadingPage});

  @override
  List<Object?> get props => [];
}
