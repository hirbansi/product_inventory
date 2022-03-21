import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incdnc/app_string/pref.dart';
import 'package:incdnc/app_string/strings.dart';
import 'package:incdnc/commons/common_widget.dart';
import 'package:incdnc/model_class/user_login_model.dart';
import 'package:incdnc/screens/product_list.dart';
import 'package:incdnc/screens/signup.dart';
import 'package:incdnc/service/register_service.dart';
import 'package:incdnc/validations/validations.dart';
class LogIn extends StatefulWidget {
  String? action;
  LogIn({this.action});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? name;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  UserLoginModel? userLoginModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                'Welcome Back',
                style: GoogleFonts.marmelad(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 28.0,
                    right: 28.0,
                  ),
                  child: SizedBox(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppString.login,
                                  style: GoogleFonts.marmelad(
                                      fontSize: 24, fontWeight: FontWeight.w400),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: textFormField(
                                  labelText: 'Your Email',
                                  controller: emailController,
                                  validator:(value) =>NewValidations().emailValidations(value!),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: textFormField(
                                  labelText: 'Password',
                                  controller: passwordController,
                                  validator:(value) =>Validations().passwordValidation(value) /*NewValidations().passwordValidation(value)*/,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text(
                                    'Forgot Password ?',
                                    style: GoogleFonts.marmelad(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onPressed: () {},
                                )
                              ],
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: SizedBox(
                                  height: 54,
                                  width: MediaQuery.of(context).size.width,
                                  child: elevatedButton(
                                      buttonName: AppString.login,
                                      color: Colors.blueGrey,
                                      onPressbtn: () async{
                                        if(_key.currentState!.validate()){
                                          userLoginModel= await RegisterApi().userLogin(
                                            userLoginModel: UserLoginModel(user:User(email: emailController.text,password: passwordController.text))
                                          );
                                          AppPreference.set('token', '${userLoginModel!.token}');
                                          AppPreference.set("IsSignIn", true);
                                          print('${userLoginModel!.token}');
                                         Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductList(),
                                            ));
                                        }

                                      }),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Dont have an Account ?',
                                  style: GoogleFonts.marmelad(
                                      fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                                TextButton(
                                    style: const ButtonStyle(
                                        alignment: Alignment.centerLeft),
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SignUp()));
                                    },
                                    child: Text(
                                      AppString.signup,
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
            ),
          ],
        ),
      ),
    );
  }
}
