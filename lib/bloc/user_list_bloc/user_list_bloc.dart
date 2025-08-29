import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/bloc/user_list_bloc/user_list_event.dart';
import 'package:practical_task/bloc/user_list_bloc/user_list_state.dart';

import '../../repository/user_repository.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository repository;

  UserListBloc(this.repository) : super(UserListLoading()) {
    on<LoadUsers>((event, emit) async {
      try {
        final users = await repository.fetchUsers();
        emit(UserListLoaded(users));
      } catch (e) {
        emit(UserListError("Failed to load users"));
      }
    });
  }
}