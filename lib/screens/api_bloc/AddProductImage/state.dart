import 'package:equatable/equatable.dart';
import 'package:incdnc/model_class/add_product_model.dart';
import 'package:incdnc/model_class/list_product.dart';

abstract class AddProductImageState extends Equatable{
}
class AddProductLoadingState extends AddProductImageState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class AddProductIState extends AddProductImageState{
  var image;
  AddProductIState({this.image});
  @override
  // TODO: implement props
  List<Object?> get props => [image];
}
class APState extends AddProductImageState{
  AddProductModel? addProductModel;
  APState({ this.addProductModel});
  @override
  // TODO: implement props
  List<Object?> get props => [addProductModel];

}