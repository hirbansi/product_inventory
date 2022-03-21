import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incdnc/app_string/strings.dart';
import 'package:incdnc/screens/login.dart';
import '../commons/common_widget.dart';
import 'signup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? action;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/App Background.png'),
                      fit: BoxFit.fill)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    right: 28,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 1.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(AppString.welcome,style: GoogleFonts.marmelad(fontSize: 36,fontWeight: FontWeight.w400,color:Colors.white,
                            ),),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(AppString.LoginorSignup,style: GoogleFonts.marmelad(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: SizedBox(
                            height: 54,
                            width: MediaQuery.of(context).size.width,
                            child: elevatedButton(buttonName: AppString.login, color: Colors.white,onPressbtn: (){
                              action = 'login';
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));
                            //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LogIn()));
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: SizedBox(
                            height: 54,
                            width: MediaQuery.of(context).size.width,
                            child: elevatedButton(buttonName: AppString.signup,onPressbtn: (){
                              action = 'signup';
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SignUp()));
                            },color: Colors.white),
                      )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
