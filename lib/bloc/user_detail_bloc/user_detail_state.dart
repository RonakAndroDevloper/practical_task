import '../../models/UserProfileModel.dart';

abstract class UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final UserProfileModel user;
  UserDetailLoaded(this.user);
}

class UserDetailError extends UserDetailState {
  final String message;
  UserDetailError(this.message);
}
