import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:incdnc/screens/changeImage/ImageChangeState.dart';
import 'package:incdnc/screens/changeImage/image_event.dart';
import 'package:incdnc/service/register_service.dart';

class ImageBloC extends Bloc<ImageChangeEvent,ImageState>{
  final AlbumService? albumService;
 // String img = 'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png' ;
  ImageBloC({ this.albumService}) : super(ImageState()){

    on<ImageEvent>((event, emit) {
      if(event is ImageEvent){

        emit( ImageState(image: event.image));
      }
    });

  }

}
