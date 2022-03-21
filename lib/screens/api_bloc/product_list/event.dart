import 'package:incdnc/model_class/add_product_model.dart';
import 'package:incdnc/model_class/list_product.dart';
import 'package:incdnc/screens/api_bloc/product_list/state.dart';

abstract class ProductListEvent{}
class ListEvent extends ProductListEvent{}
class LoadingEvent extends ProductListEvent{}
class ProductListAddEvent extends ProductListEvent{
  AddProductModel? addProductModel;
  ProductListAddEvent({this.addProductModel});
}
class DeleteEvent extends ProductListEvent{
  int? id;
  int? index;
  List<Datum>? allData;
  DeleteEvent({this.id,this.allData,this.index});
}
class LikeUnlike extends ProductListEvent{
  bool? fav;
  LikeUnlike({this.fav});
}
class AddEvent extends ProductListEvent{
  AddProductModel? addProductModel;
  AddEvent({this.addProductModel});
}
class DataAddedevent extends ProductListEvent{
  int? lastpage;
  DataAddedevent({this.lastpage});
}
class APEvent extends ProductListEvent{
  AddProductModel? addProductModel;
  int? lastPage;
  APEvent({this.addProductModel,this.lastPage});
}