import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incdnc/commons/common_widget.dart';
import 'package:incdnc/model_class/add_product_model.dart';
import 'package:incdnc/screens/api_bloc/AddProductImage/bloc.dart';
import 'package:incdnc/screens/api_bloc/AddProductImage/state.dart';

import 'package:incdnc/screens/api_bloc/product_list/bloc.dart';
import 'package:incdnc/screens/api_bloc/product_list/event.dart';
import 'package:incdnc/service/get_it.dart';
import 'package:incdnc/validations/validations.dart';

import 'api_bloc/AddProductImage/event.dart';


class AddProducts extends StatefulWidget {
 int? lasPage;
 AddProducts({this.lasPage});
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController sellingController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  AddProductModel? addProductModel;
  ListBloc? listBloc;
  File? _image;
  ImagePicker? imagepicker;
  String? imagepath;
  AddProductImageBloc? addProductImageBloc;

  var image;

  @override
  void initState() {
    listBloc = sl<ListBloc>();
    addProductImageBloc = sl<AddProductImageBloc>();
    imagepicker = ImagePicker();
    super.initState();
  }

  /*Future getImagefromGallery()  async {
  }*/
  Future getImagefromcamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    _image = File(image!.path);
    imagepath = _image!.path;
    imageUrlController.text = imagepath ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
      child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.11,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  color: Colors.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  Text(
                    'Product List',
                    style: GoogleFonts.marmelad(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
            BlocListener<AddProductImageBloc, AddProductImageState>(
              bloc: addProductImageBloc,
              listener: (context, state) {
               if( state is AddProductIState){
                 image  = state.image;
               }
               if(state is APState){
                 addProductModel = state.addProductModel!;
               }
              },
              child: BlocBuilder<AddProductImageBloc, AddProductImageState>(
                bloc: addProductImageBloc,
                builder: (context, state) {
                  return SingleChildScrollView(
                    reverse: true,
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textFormField(
                              controller: productNameController,
                              validator: (value) =>
                                  NewValidations().isnotEmptyValidation(value),
                              labelText: "Enter Product Name")!,
                          SizedBox(
                            height: 10,
                          ),
                          textFormField(
                              controller: sellingController,
                              validator: (value) =>
                                  NewValidations().isnotEmptyValidation(value),
                              labelText: "Enter Price")!,
                          SizedBox(
                            height: 10,
                          ),
                          textFormField(
                              controller: mrpController,
                              validator: (value) =>
                                  NewValidations().isnotEmptyValidation(value),
                              labelText: "Enter MRP:")!,
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      elevatedButton(
                                          buttonName: "Select From Gallery",
                                          color: Colors.lightBlueAccent,
                                          onPressbtn: () async {

                                            XFile? image = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.gallery);
                                            addProductImageBloc?.add(AddImageEvent(image: image));
                                            _image = File(image!.path);
                                            imagepath = _image!.path;
                                            imageUrlController.text =
                                                imagepath ?? "";
                                          }),
                                      elevatedButton(
                                          buttonName: "Select From Camera",
                                          color: Colors.lightBlueAccent,
                                          onPressbtn: () {
                                            getImagefromcamera();
                                          }),
                                      const SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: textFormField(
                                icon: Icon(Icons.image),
                                enabled: false,
                                labelText: "Select Image",
                                controller: imageUrlController),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          textFormField(
                              controller: discriptionController,
                              labelText: "Enter Description",
                              validator: (value) =>
                                  NewValidations().isnotEmptyValidation(value))!,
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              elevatedButton(
                                  buttonName: "Add Product",
                                  color: Colors.blue,
                                  onPressbtn: () async {
                                    if (_key.currentState!.validate()) {
                                      listBloc!.add(APEvent(
                                        lastPage: widget.lasPage,
                                          addProductModel: AddProductModel(
                                              data: AddData(
                                                  name:
                                                      productNameController.text,
                                                  description:
                                                      discriptionController.text,
                                                  mrp: mrpController.text,
                                                  selling: sellingController.text,
                                                  image: _image
                                                      ))));
                                      Navigator.pop(context);

                                    }
                                  }),
                              elevatedButton(
                                  buttonName: "Cancel",
                                  color: Colors.blue,
                                  onPressbtn: () {
                                    Navigator.pop(context);
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
      ),
    ),
        ));
  }
}
