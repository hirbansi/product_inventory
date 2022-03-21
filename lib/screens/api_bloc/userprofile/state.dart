import 'package:equatable/equatable.dart';
import 'package:incdnc/model_class/user_profile_model.dart';

abstract class UserProfileState extends Equatable{
  @override
  List<Object> get props => [];
}
class UserInitState extends UserProfileState {}
class UserProfileLoading extends UserProfileState {
  final String load;
  UserProfileLoading(this.load);

}
class UserProfileLoaded extends UserProfileState {
  final UserProfileModel? userProfileModel;
  @override
  List<Object> get props => [userProfileModel!];
  UserProfileLoaded({required this.userProfileModel});
}
class UserProfileError extends UserProfileState {
  final error;
  UserProfileError({this.error});
}
