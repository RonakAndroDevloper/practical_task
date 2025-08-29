abstract class UserDetailEvent {}

class LoadUserDetail extends UserDetailEvent {
  final String userId;
  LoadUserDetail(this.userId);
}