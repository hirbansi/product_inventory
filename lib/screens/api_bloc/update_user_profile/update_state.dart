import 'package:equatable/equatable.dart';
import 'package:incdnc/model_class/profile_update.dart';

abstract class UpdateUserState extends Equatable{}
class IninitialState extends UpdateUserState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class UpdateLoadingState extends UpdateUserState{
  String? errorMessage;
  UpdateLoadingState({this.errorMessage});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class UserUpdatedState extends UpdateUserState{
  UserUpdateModel? userUpdateModel;
  UserUpdatedState({this.userUpdateModel});
  @override
  // TODO: implement props
  List<Object?> get props => [userUpdateModel];
}
