import 'package:practical_task/models/UserListModel.dart';

abstract class UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<Data> users;
  UserListLoaded(this.users);
}

class UserListError extends UserListState {
  final String message;
  UserListError(this.message);
}