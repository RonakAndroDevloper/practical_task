import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/bloc/user_detail_bloc/user_detail_event.dart';
import 'package:practical_task/bloc/user_detail_bloc/user_detail_state.dart';

import '../../repository/user_repository.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserRepository repository;

  UserDetailBloc(this.repository) : super(UserDetailLoading()) {
    on<LoadUserDetail>((event, emit) async {
      try {
        final user = await repository.fetchUserDetail(event.userId);
        emit(UserDetailLoaded(user));
      } catch (e) {
        emit(UserDetailError("Failed to load user detail"));
      }
    });
  }
}