import 'package:bloc/bloc.dart';
import 'package:incdnc/model_class/profile_update.dart';
import 'package:incdnc/screens/api_bloc/update_user_profile/update_event.dart';
import 'package:incdnc/screens/api_bloc/update_user_profile/update_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent,UpdateUserState>{
  UserUpdateModel? userUpdateModel;
  UpdateUserBloc() : super(IninitialState()){
    on<UpdateUserEvent>((event, emit) {
      if(event is UpdateLoadingState){
        emit(UpdateLoadingState(errorMessage: "Loading Please wait"));
      }
      if(event is UserUpdatedState){
        emit(UserUpdatedState(userUpdateModel:userUpdateModel ));
      }
    });
  }

}