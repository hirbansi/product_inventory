


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incdnc/screens/changeImage/ImageChangeState.dart';
import 'package:incdnc/screens/changeImage/image_event.dart';
import 'package:incdnc/service/get_it.dart';

import 'changeImage/image_bloc.dart';

class CameraAndGallary extends StatefulWidget {
  final type;

  CameraAndGallary(this.type);

  @override
  _CameraAndGallaryState createState() => _CameraAndGallaryState();
}

class _CameraAndGallaryState extends State<CameraAndGallary> {
  ImageBloC? imageBloc;
  XFile? _image;
  ImagePicker? imagepicker;
  File? file;

  @override
  void initState() {
    super.initState();
    imageBloc = sl<ImageBloC>();
    imagepicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type == ImageSource.camera
            ? 'Image From Camera'
            : 'Image From Gallary'),
      ),
      body: BlocListener(
        bloc: imageBloc,
        listener: (context, state) {
          if (state is ImageState) {
            _image = state.image;
          }
        },
        child: BlocBuilder(
          bloc: imageBloc,
          builder: (context, state) => Column(
            children: <Widget>[
              SizedBox(
                height: 55,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    var source = (widget.type == ImageSource.camera
                        ? ImageSource.camera
                        : ImageSource.gallery);
                    XFile? image = await imagepicker!.pickImage(
                        source: source,
                        imageQuality: 50,
                        preferredCameraDevice: CameraDevice.front);
                    imageBloc!.add(ImageEvent(image: image));
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.red[200]),
                    child:_image != null
                        ? Image.file(
                            File(_image!.path),
                            width: 200,
                            height: 200,
                            fit: BoxFit.fitHeight,
                          )
                        : Container(
                            decoration: BoxDecoration(color: Colors.red[200]),
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
