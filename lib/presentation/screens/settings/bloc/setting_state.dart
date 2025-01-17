import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/user_model.dart';

enum SettingStatus {
  initial,
  processing,
  success,
  failure,
}

final class SettingState extends Equatable {
  final SettingStatus? status;
  final UserModel? user;

  const SettingState({this.status, this.user});

  static SettingState initial() => const SettingState(
        status: SettingStatus.initial,
      );

  SettingState copyWith({
    SettingStatus? status,
    UserModel? user,
  }) {
    return SettingState(status: status ?? this.status, user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status, user];
}
