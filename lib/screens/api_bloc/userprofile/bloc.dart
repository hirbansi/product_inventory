import 'package:bloc/bloc.dart';
import 'package:incdnc/model_class/user_profile_model.dart';
import 'package:incdnc/screens/api_bloc/userprofile/event.dart';
import 'package:incdnc/screens/api_bloc/userprofile/state.dart';
import 'package:incdnc/screens/changeImage/ImageChangeState.dart';
import 'package:incdnc/service/register_service.dart';

class UserProfileBloc extends Bloc<UserProfileEvent,UserProfileState>{
   AlbumService? albumService;
  UserProfileModel? userProfileModel;
  String? message;
  String? error;
   UserProfileBloc({ this.albumService}) : super(UserInitState()){
    on<UserProfileEvent>((event, emit)async{
      if(event is ProfileFetchEvent){
        userProfileModel = await RegisterApi().userProfile();
        emit(UserProfileLoaded(userProfileModel: userProfileModel));
      }
    });
  }

}
