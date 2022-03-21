import 'package:bloc/bloc.dart';
import 'package:incdnc/commons/common_widget.dart';
import 'package:incdnc/screens/signup_bloC/event_signup.dart';
import 'package:incdnc/screens/signup_bloC/state_signup.dart';

class SignUpBloC extends Bloc<SignupEvent,SignUpState>{
  SignUpBloC() : super(InitState()){
    on<selectedEvent>((event, emit)=>ChangeState());
  }
}