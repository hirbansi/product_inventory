import 'package:bloc/bloc.dart';
import 'package:incdnc/model_class/add_product_model.dart';
import 'package:incdnc/screens/api_bloc/AddProductImage/event.dart';
import 'package:incdnc/screens/api_bloc/AddProductImage/state.dart';
import 'package:incdnc/service/register_service.dart';

class AddProductImageBloc extends Bloc<AddProductImageEvent,AddProductImageState>{
  AddProductModel? addProductModel;
  AddProductImageBloc() : super(AddProductLoadingState()){
    on<AddProductImageEvent>((event, emit)async{
      if(event is AddImageEvent){
        emit(AddProductIState(image: event.image));
      }
    });
  }

}