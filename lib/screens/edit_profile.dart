import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incdnc/app_string/strings.dart';
import 'package:incdnc/commons/common_widget.dart';
import 'package:incdnc/model_class/profile_update.dart';
import 'package:incdnc/screens/camera_and_gallary.dart';
import 'package:incdnc/service/get_it.dart';
import 'package:incdnc/service/register_service.dart';

import 'api_bloc/update_user_profile/update_bloc.dart';
import 'api_bloc/update_user_profile/update_event.dart';

class EditProfile extends StatefulWidget {
  int? id;

  EditProfile({this.id});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  UserUpdateModel? userUpdateModel;
  DateTime? tempDate;
  UpdateUserBloc? updateUserBloc;
  DateTime time = DateTime.now();
  void handleButtons(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CameraAndGallary(type)));
  }
  @override
  void initState() {
    updateUserBloc = sl<UpdateUserBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF555555),
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(60),
                        bottomRight: Radius.circular(60))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          widthFactor: 3.5,
                          child: Text(
                            AppString.profile_title,
                            style: GoogleFonts.marmelad(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 43.0),
                      child: CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 70,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 18,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 18,
                                      color: Color(0xFF444444),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Scaffold(
                                            backgroundColor: Colors.transparent,
                                            body: Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    "Select",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24),
                                                  ),
                                                  elevatedButton(
                                                      onPressbtn: () {
                                                        handleButtons(
                                                            context,
                                                            ImageSource
                                                                .gallery);
                                                      },
                                                      buttonName:
                                                          'Select From Gallary',
                                                      color: Colors.white),
                                                  elevatedButton(
                                                      onPressbtn: () {
                                                        handleButtons(context,
                                                            ImageSource.camera);
                                                      },
                                                      buttonName:
                                                          'Select From Camera',
                                                      color: Colors.white),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13.0),
                      child: Text(
                        'Username',
                        style: GoogleFonts.marmelad(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'emailadress.com',
                        style: GoogleFonts.marmelad(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45, right: 38, left: 38),
                child: textFormField(
                    labelText: 'User Name',
                    controller: nameController,
                    enabled: true,
                    suffixIcon: Icon(Icons.edit, color: Color(0xFF444444)),
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'Enter Valide Password';
                      }
                      return null.toString();
                    })!,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, right: 38, left: 38),
                child: textFormField(
                    labelText: 'Email',
                    enabled: true,
                    suffixIcon: const Icon(Icons.edit, color: Color(0xFF444444)),
                    controller: emailController,
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'Enter Valide Password';
                      }
                      return null.toString();
                    })!,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, right: 38, left: 38),
                child: textFormField(
                    labelText: 'Gender',
                    enabled: true,
                    suffixIcon: const Icon(Icons.edit, color: Color(0xFF444444)),
                    controller: genderController,
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'Enter Valide Password';
                      }
                      return null.toString();
                    })!,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, right: 38, left: 38),
                child: GestureDetector(
                    onTap: () async {
                      datePickerFunc(
                        context,
                        dobController,
                      );
                      tempDate = DateTime.tryParse(dobController.text);
                    },
                    child: textFormField(
                        controller: dobController,
                        fontSize: 10,
                        enabled: false,
                        labelText: 'DOB',
                        icon: const Icon(Icons.date_range))!),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, right: 38, left: 38),
                child: SizedBox(
                    height: 54,
                    width: MediaQuery.of(context).size.width,
                    child: elevatedButton(
                      buttonName: 'Save Changes',
                      color: const Color(0xFF55555),
                      onPressbtn: () async {
                        userUpdateModel = await RegisterApi().updateUser(
                            id: widget.id,
                            userUpdateModel: UserUpdateModel(
                                user: User(
                                    name: nameController.text,
                                    email: emailController.text,
                                    gender: genderController.text,
                                    birthDate: time)));
                        updateUserBloc!.add(UpdateEvent());
                        Navigator.pop(context);
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
