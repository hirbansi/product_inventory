import 'package:equatable/equatable.dart';
import 'package:incdnc/model_class/add_product_model.dart';
import 'package:incdnc/model_class/list_product.dart';
import 'package:incdnc/screens/product_list.dart';

abstract class ProductListState extends Equatable{}
class ListInitState extends ProductListState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ListLoadingState extends ProductListState{
  String? loading;
  ListLoadingState({this.loading});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class ListLoadedState extends ProductListState{
  ProductListModel? productListModel;
  int? page;
  ListLoadedState({this.page,this.productListModel});
  @override
  // TODO: implement props
  List<Object?> get props => [productListModel];
}
class AddLoadedState extends ProductListState{
  AddProductModel? addProductModel;
  AddLoadedState({this.addProductModel});
  @override
  // TODO: implement props
  List<Object?> get props =>[addProductModel];
}
class DeleteState extends ProductListState{
  List<Datum>? allData;
  DeleteState({this.allData});
  @override
  List<Object?> get props => [allData];

}
class DataAddedState extends ProductListState{
  Datum? lastData ;
  DataAddedState({this.lastData});
  @override
  // TODO: implement props
  List<Object?> get props => [lastData];
}
class FavUnfavState extends ProductListState{
  bool? fav;
  FavUnfavState({this.fav});
  @override
  // TODO: implement props
  List<Object?> get props => [fav];

}