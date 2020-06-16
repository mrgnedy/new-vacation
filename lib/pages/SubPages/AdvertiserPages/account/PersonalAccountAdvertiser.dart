import 'dart:async';
import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacatiion/ScopedModels/ScopedModelUpdateUser.dart';
import 'package:vacatiion/model/Advertiser/UpdateAdvertiser.dart';
import 'package:vacatiion/pages/SubPages/AdvertiserPages/account/EditPersonalAccountAdvertiser.dart';
import 'package:vacatiion/pages/SubPages/AdvertiserPages/account/add_officer.dart';
import 'package:vacatiion/utility/api_utilites.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:http/http.dart' as http;

class PersonalAccountAdvertiser extends StatefulWidget {
  @override
  _PersonalAccountAdvertiserState createState() =>
      _PersonalAccountAdvertiserState();
}

class _PersonalAccountAdvertiserState extends State<PersonalAccountAdvertiser> {
  ScopedModelUpdateUser get _scopedModelUpdateUser =>
      GetIt.I<ScopedModelUpdateUser>();

  @override
  void initState() {
    _scopedModelUpdateUser.initialStreamControllerAdvertiser();
    _scopedModelUpdateUser.stopLoading();
    _scopedModelUpdateUser.getUpdateAdvertiser(context: context);

    super.initState();
  }

  @override
  void dispose() {
    _scopedModelUpdateUser.disposeAdvertiser();
    super.dispose();
  }
Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ScopedModel<ScopedModelUpdateUser>(
        model: _scopedModelUpdateUser,
        child: Scaffold(
          body: Container(
            child: ScopedModelDescendant<ScopedModelUpdateUser>(
              builder: (BuildContext context, Widget child,
                  ScopedModelUpdateUser model) {
                return StreamBuilder<UpdateAdvertiser>(
                    stream: model.outUpdateAdvertiser,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return SpinKitCircle(color: ColorsV.defaultColor);
                        default:
                          if (snapshot.hasError)
                            return Center(
                                child: new Text('Error: ${snapshot.error}'));
                          else
                            return Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Stack(
                                children: <Widget>[
                                  ///============================ Content Page ============================//
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: ListView(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              ///============================================= Content ===============================================//
                                              SizedBox(
                                                height: 85,
                                              ),

                                              ///------------------------------------- Choose Image Profile ------------------------------//
                                              CircularProfileAvatar(
                                                "http://vacatiion.net/public/images/" +
                                                    snapshot.data.data.profile
                                                        .image, //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                                                radius:
                                                    90, // sets radius, default 50.0
                                                backgroundColor: Colors
                                                    .transparent, // sets background color, default Colors.white
                                                borderWidth:
                                                    7, // sets border, default 0.0
                                                borderColor: ColorsV
                                                    .defaultColor, // sets border color, default Colors.white
                                                elevation:
                                                    5.0, // sets elevation (shadow of the profile picture), default value is 0.0
                                                //    foregroundColor: Colors.brown.withOpacity(0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                                                cacheImage:
                                                    true, // allow widget to cache image against provided url
                                                onTap: () {
                                                  print('adil');
                                                }, // sets on tap
                                                showInitialTextAbovePicture:
                                                    true, // setting it true will show initials text above profile picture, default false
                                              ),

                                              ///---------------------------  Name ----------------------------------//
                                              ///
                                              SizedBox(
                                                height: 5,
                                              ),

                                              buildOfficers(
                                                  snapshot.data.data.officers),
                                              SizedBox(
                                                height: 5,
                                              ),

                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 10),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: myBoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${snapshot.data.data.profile.name}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: ColorsV
                                                            .defaultColor),
                                                  ),
                                                ),
                                              ),

                                              ///------------------------------- TextField Email--------------------------------//
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 10),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: myBoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${snapshot.data.data.profile.email}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: ColorsV
                                                            .defaultColor),
                                                  ),
                                                ),
                                              ),

                                              //email

                                              ///-----------------------------TextField Phone ---------------------------------//
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 10),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: myBoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${snapshot.data.data.profile.phone}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: ColorsV
                                                            .defaultColor),
                                                  ),
                                                ),
                                              ),
                                              //phone

                                              ///---------------------------- TextField Bank name --------------------------------//
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 10),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: myBoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${snapshot.data.data.profile.bank == null ? 'لم يدخل بعد' : snapshot.data.data.profile.bank}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: ColorsV
                                                            .defaultColor),
                                                  ),
                                                ),
                                              ),
                                              //phone

                                              //--------------------------- TextField Account Name ------------------------//
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 10),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: myBoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${snapshot.data.data.profile.accountName == 'null' ? 'لم يدخل بعد' : snapshot.data.data.profile.accountName}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: ColorsV
                                                            .defaultColor),
                                                  ),
                                                ),
                                              ),
                                              //phone

                                              //-------------------------- TextField Account Number  -----------------------//
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 10),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: myBoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${snapshot.data.data.profile.accountNumber == 'null' ? 'لم يدخل بعد' : snapshot.data.data.profile.accountNumber}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: ColorsV
                                                            .defaultColor),
                                                  ),
                                                ),
                                              ),
                                              //phone

                                              //-------------------------------TextField Iban Number--------------------//
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 10),
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                decoration: myBoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${snapshot.data.data.profile.eban == 'null' ? 'لم يدخل بعد' : snapshot.data.data.profile.eban}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: ColorsV
                                                            .defaultColor),
                                                  ),
                                                ),
                                              ),
                                              //Iban
                                              SizedBox(
                                                height: 3,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  ///---------------- AppBar------------------------------//
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        image: new AssetImage(
                                            "assets/appbar/background_app_bar.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Column(
                                        children: <Widget>[
                                          //-------------Title----------//
                                          ListTile(
                                            //-------------------------- Edit Profile --------------------//
                                            leading: ClipOval(
                                              child: Material(
                                                color: Colors
                                                    .transparent, // button color
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.amberAccent,
                                                  // inkwell color
                                                  child: SizedBox(
                                                      width: 45,
                                                      height: 45,
                                                      child: Image.asset(
                                                        "assets/icons/15.png",
                                                        width: 25,
                                                        height: 25,
                                                      )),
                                                  onTap: () {
                                                    _scopedModelUpdateUser
                                                        .openEditAccountAdvertiser(
                                                            context);
                                                  },
                                                ),
                                              ),
                                            ),
                                            title: Center(
                                                child: Text(
                                              "الملف الشخصى",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'DinNextLight'),
                                            )),
                                            //----btn Back
                                            trailing: Container(
                                              child: SizedBox(
                                                width: 45,
                                                height: 45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                      }
                    });
              },
            ),
          ),
        ));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0) //
          ),
    );
  }

  BoxDecoration officerBorder() {
    return BoxDecoration(
      // color: ColorsV.defaultColor,
      border: Border.all(width: 1.0, color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(15.0) //
          ),
    );
  }

  Widget buildOfficers(officers) {
    officers =[];
    return Container(
      width: size.width*0.9,
      decoration: BoxDecoration(
          color: ColorsV.defaultColor, borderRadius: BorderRadius.circular(8)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ExpansionTile(
            backgroundColor: ColorsV.defaultColor,
            title: Text(
              'مسؤولى الحجوزات',
              style: TextStyle(color: Colors.white, fontFamily: 'DinNextLight'),
            ),
            children: officers.isEmpty
                ? [addOfficer()]
                : List.generate(
                    officers.length,
                    (index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          officerCard(officers[index].name),
                          officerCard(officers[index].phone),
                          index==officers.length-1?SizedBox(height: 10,): Divider(color: Colors.white,),
                        ],
                      );
                    },
                  )),
      ),
    );
  }

  Widget officerCard(String value) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
      padding: const EdgeInsets.all(3.0),
      decoration: officerBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "$value",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget addOfficer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width* 0.74,
        height: MediaQuery.of(context).size.height / 16,
        child: RaisedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddOfficerPage())),
          child: Text(
            'أضف مسؤول حجوزات',
            style: TextStyle(
                color: ColorsV.defaultColor, fontSize: 16, fontFamily: 'DinNextMedium'),
          ),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
