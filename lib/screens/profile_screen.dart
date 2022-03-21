import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incdnc/app_string/pref.dart';
import 'package:incdnc/commons/common_widget.dart';
import 'package:incdnc/model_class/user_profile_model.dart';
import 'package:incdnc/screens/api_bloc/userprofile/event.dart';
import 'package:incdnc/screens/api_bloc/userprofile/state.dart';
import 'package:incdnc/screens/edit_profile.dart';
import 'package:incdnc/screens/homescreen.dart';
import 'package:incdnc/service/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_bloc/userprofile/bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  UserProfileBloc? userProfileBloc;
  UserProfileModel? userProfileModel;
  SharedPreferences? prefs;
  String? loadingMessage;

  @override
  void initState() {
    userProfileBloc = sl<UserProfileBloc>();
    userProfileBloc!.add(ProfileFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocListener<UserProfileBloc, UserProfileState>(
            bloc: userProfileBloc,
            listener: (context, state) {
              if (state is UserProfileLoading) {
                loadingMessage = state.load;
              }
              if (state is UserProfileLoaded) {
                userProfileModel = state.userProfileModel;
              }
            },
            child: BlocBuilder<UserProfileBloc, UserProfileState>(
              bloc: userProfileBloc,
              builder: (context, state) {
                return userProfileModel != null
                    ? Column(
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    /*Align(
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
                                        'Profile',
                                        style: GoogleFonts.marmelad(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Logout',
                                            style: GoogleFonts.marmelad(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ))*/
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Profile',
                                      style: GoogleFonts.marmelad(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        AppPreference.remove("IsSignIn");
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context) => HomeScreen(),), (route) => false);
                                      },
                                      child: Text(
                                        'Logout',
                                        style: GoogleFonts.marmelad(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 43.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://cdna.artstation.com/p/assets/images/images/009/372/706/large/royy-_ledger-untitled-1.jpg?1518610660'),
                                    radius: 70,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13.0),
                                  child: Text(
                                    userProfileModel!.user!.name!,
                                    style: GoogleFonts.marmelad(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    userProfileModel!.user!.email!,
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
                            padding: const EdgeInsets.only(
                                top: 45, right: 38, left: 38),
                            child: textFormField(
                              labelText: "Name",
                              value: userProfileModel!.user!.name,
                              enabled: false,
                            )!,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 24, right: 38, left: 38),
                            child: textFormField(
                              labelText: "Email",
                              enabled: false,
                              value: userProfileModel!.user!.email,
                            )!,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 24, right: 38, left: 38),
                            child: textFormField(
                              labelText: "Gender",
                              enabled: false,
                              value: userProfileModel!.user!.gender,
                            )!,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 24, right: 38, left: 38),
                            child: textFormField(
                                labelText: "Date of Birth",
                                enabled: false,
                                value: userProfileModel!.user!.birthDate!
                                    .toIso8601String())!,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 24, right: 38, left: 38),
                            child: SizedBox(
                                height: 54,
                                width: MediaQuery.of(context).size.width,
                                child: elevatedButton(
                                  buttonName: 'Edit Profile',
                                  color: const Color(0xFF55555),
                                  onPressbtn: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfile(id: userProfileModel!.user!.id,)));
                                  },
                                )),
                          )
                        ],
                      )
                    : Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
