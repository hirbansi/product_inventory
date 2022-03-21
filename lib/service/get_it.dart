import 'package:get_it/get_it.dart';
import 'package:incdnc/screens/api_bloc/AddProductImage/bloc.dart';
import 'package:incdnc/screens/api_bloc/product_list/bloc.dart';
import 'package:incdnc/screens/api_bloc/update_user_profile/update_bloc.dart';
import 'package:incdnc/screens/api_bloc/userprofile/bloc.dart';
import 'package:incdnc/screens/changeImage/image_bloc.dart';
import 'package:incdnc/service/register_service.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<ImageBloC>(() => ImageBloC());
  sl.registerLazySingleton<UserProfileBloc>(() =>UserProfileBloc());
  sl.registerLazySingleton<ListBloc>(() =>ListBloc());
  sl.registerLazySingleton<UpdateUserBloc>(() => UpdateUserBloc());
  sl.registerLazySingleton<AddProductImageBloc>(() => AddProductImageBloc());
  print("registered");
}
