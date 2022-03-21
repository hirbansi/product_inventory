import 'package:incdnc/model_class/add_product_model.dart';

abstract class AddProductImageEvent {
}
class AddImageEvent extends AddProductImageEvent{
  var image;
  AddImageEvent({this.image});
}
