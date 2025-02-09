import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();
}

final class UserProfileInitialEvent extends UserProfileEvent {
  @override
  List<Object?> get props => [];
}

class UserProfilePickImageEvent extends UserProfileEvent {
  final ImageSource source;

  const UserProfilePickImageEvent(this.source);

  @override
  List<Object?> get props => [source];
}

class UserProfileValueChangedEvent extends UserProfileEvent {
  final String? username, fullName;

  const UserProfileValueChangedEvent({this.username, this.fullName});

  @override
  List<Object?> get props => [username, fullName];
}

class UserProfileSubmitEvent extends UserProfileEvent {
  const UserProfileSubmitEvent();

  @override
  List<Object?> get props => [];
}
