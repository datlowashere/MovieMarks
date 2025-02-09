import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:movie_marks/data/models/user_model.dart';

enum UserProfileStatus {
  initial,
  processing,
  success,
  editUserSuccess,
  failure,
}

final class UserProfileState extends Equatable {
  final UserProfileStatus? status;
  final UserModel? user;
  final File? imageFile;
  final String? inputUsername, inputFullName, inputEmail;
  final String? messageInputUsername, messageInputFullName;
  final bool isShowUsernameMessage, isShowFullNameMessage, isEnabled;

  const UserProfileState({
    this.status,
    this.user,
    this.imageFile,
    this.inputUsername,
    this.inputFullName,
    this.inputEmail,
    this.messageInputUsername,
    this.messageInputFullName,
    this.isShowUsernameMessage = false,
    this.isShowFullNameMessage = false,
    this.isEnabled = false,
  });

  static UserProfileState initial() => const UserProfileState(
        status: UserProfileStatus.initial,
      );

  UserProfileState copyWith(
      {UserProfileStatus? status,
      UserModel? user,
      File? imageFile,
      String? inputUsername,
      String? inputFullName,
      String? inputEmail,
      String? messageInputUsername,
      String? messageInputFullName,
      bool? isShowUsernameMessage,
      bool? isShowFullNameMessage,
      bool? isEnabled}) {
    return UserProfileState(
        status: status ?? this.status,
        user: user ?? this.user,
        imageFile: imageFile ?? this.imageFile,
        inputUsername: inputUsername ?? this.inputUsername,
        inputFullName: inputFullName ?? this.inputFullName,
        inputEmail: inputEmail ?? this.inputEmail,
        messageInputFullName: messageInputFullName ?? this.messageInputFullName,
        messageInputUsername: messageInputUsername ?? this.messageInputUsername,
        isShowUsernameMessage:
            isShowUsernameMessage ?? this.isShowUsernameMessage,
        isShowFullNameMessage:
            isShowFullNameMessage ?? this.isShowFullNameMessage,
        isEnabled: isEnabled ?? this.isEnabled);
  }

  @override
  List<Object?> get props => [
        status,
        user,
        imageFile,
        inputUsername,
        inputFullName,
        inputEmail,
        messageInputUsername,
        messageInputFullName,
        isShowUsernameMessage,
        isShowFullNameMessage,
        isEnabled
      ];
}
