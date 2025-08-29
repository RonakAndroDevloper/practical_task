import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/screens/user_detail_screen.dart';

import '../bloc/user_detail_bloc/user_detail_bloc.dart';
import '../bloc/user_detail_bloc/user_detail_event.dart';
import '../bloc/user_list_bloc/user_list_bloc.dart';
import '../bloc/user_list_bloc/user_list_event.dart';
import '../bloc/user_list_bloc/user_list_state.dart';
import '../repository/user_repository.dart';
import '../utils/comman.dart';
import '../widgets/user_card.dart';



class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserListBloc(UserRepository())..add(LoadUsers()),
      child: Scaffold(backgroundColor: color216231238,
        appBar: AppBar(leading: Icon(Icons.menu,color: Colors.white,),
          backgroundColor: Colors.blue[900],
          title: const Text("User List",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),centerTitle: true,
        ),
        body: BlocBuilder<UserListBloc, UserListState>(
          builder: (context, state) {
            if (state is UserListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserListLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return UserCard(
                    user: user,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) =>
                            UserDetailBloc(UserRepository())..add(LoadUserDetail(user.id!)),
                            child: UserDetailScreen(),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is UserListError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}