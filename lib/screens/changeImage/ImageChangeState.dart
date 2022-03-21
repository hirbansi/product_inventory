// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:incdnc/model_class/register_modelclass.dart';

abstract class ImageChangeState extends Equatable{}
  class ImageState extends ImageChangeState{
  var image;
  ImageState({this.image});

  @override
  // TODO: implement props
  List<RegisterModel?> get props => [image];
}
class InitState extends ImageChangeState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}