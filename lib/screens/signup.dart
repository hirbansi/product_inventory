import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incdnc/app_string/pref.dart';
import 'package:incdnc/app_string/strings.dart';
import 'package:incdnc/commons/common_widget.dart';
import 'package:incdnc/model_class/register_modelclass.dart';
import 'package:incdnc/screens/api_bloc/update_user_profile/update_bloc.dart';
import 'package:incdnc/screens/login.dart';
import 'package:incdnc/service/register_service.dart';
import 'package:incdnc/validations/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'product_list.dart';

class SignUp extends StatefulWidget {
  String? action;

  SignUp({this.action});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List lst = ['Male', 'Female', 'Other'];
  String? name;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController confirmationController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  DateTime? tempDate;
  DateTime dateTime = DateTime.now();
  RegisterModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: key,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/SignUpBackground.png'),
                        fit: BoxFit.fill)),
              ),
              Positioned(
                top: 83,
                left: 26,
                child: Container(
                    child: Text(
                  'Welcome',
                  style: GoogleFonts.marmelad(
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60),
                        topLeft: Radius.circular(60)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 28.0,
                      right: 28.0,
                    ),
                    child: SizedBox(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'SignUp',
                                  style: GoogleFonts.marmelad(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: textFormField(
                                  labelText: 'Name',
                                  controller: nameController,
                                  validator: (value) =>
                                      NewValidations().nameValidation(value)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: textFormField(
                                labelText: 'Your Email',
                                controller: emailController,
                                validator: (value) =>
                                    Validations().emailvalidation(value!),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: textFormField(
                                  labelText: 'Password',
                                  controller: passwordController,
                                  validator: (value) =>
                                      Validations().passwordValidation(value!)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: textFormField(
                                  controller: confirmationController,
                                  labelText: 'Confirm Password',
                                  validator: (value) =>
                                      Validations().passwordValidation(value!)),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 62,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        //border: Border.all( width: 0.80),
                                      ),
                                      child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                            enabledBorder: InputBorder.none),
                                        hint: Text('Gender'),
                                        items: lst
                                            .map((value) => DropdownMenuItem(
                                                  child: Text(value),
                                                  value: value,
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          name = value as String?;
                                        },
                                        isExpanded: false,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                          onTap: () async {
                                            datePickerFunc(
                                              context,
                                              dobController,
                                            );
                                            tempDate = DateTime.tryParse(
                                                dobController.text);
                                          },
                                          child: textFormField(
                                              controller: dobController,
                                              fontSize: 10,
                                              enabled: false,
                                              labelText: 'DOB',
                                              icon: Icon(Icons.date_range))!),
                                    ))
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: SizedBox(
                                  height: 54,
                                  width: MediaQuery.of(context).size.width,
                                  child: elevatedButton(
                                      buttonName: AppString.signup,
                                      color: Colors.blueGrey,
                                      onPressbtn: () async {
                                        if (key.currentState!.validate()) {
                                          user = await RegisterApi().createUser(
                                              model: RegisterModel(
                                                  data: Data(
                                                      name: nameController.text,
                                                      birthDate: DateTime.tryParse(
                                                          dobController.text),
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text,
                                                      gender: name,
                                                      password_confirmation:
                                                          confirmationController
                                                              .text)));
                                          AppPreference.set('token', '${user!.token}');
                                          AppPreference.set("IsSignIn", true);
                                          print('${user!.token}');
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductList()));
                                        }
                                      }),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'You have an account ?',
                                  style: GoogleFonts.marmelad(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextButton(
                                    style: const ButtonStyle(
                                        alignment: Alignment.centerLeft),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LogIn()));
                                    },
                                    child: Text(
                                      AppString.login,
                                      style: GoogleFonts.marmelad(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
