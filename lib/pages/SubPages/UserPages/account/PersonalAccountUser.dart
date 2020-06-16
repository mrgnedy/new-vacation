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
import 'package:vacatiion/model/user/UpdateUser.dart';
import 'package:vacatiion/pages/SubPages/AdvertiserPages/account/EditPersonalAccountAdvertiser.dart';
import 'package:vacatiion/utility/api_utilites.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:http/http.dart' as http;


class PersonalAccountUser extends StatefulWidget {
  @override
  _PersonalAccountUserState createState() => _PersonalAccountUserState();
}
class _PersonalAccountUserState extends State<PersonalAccountUser> {



  ScopedModelUpdateUser get _scopedModelUpdateUser => GetIt.I<ScopedModelUpdateUser>();

  @override
  void initState()
  {
    _scopedModelUpdateUser.initialStreamControllerUser();
    _scopedModelUpdateUser.stopLoading();
    _scopedModelUpdateUser.getUpdateUser(context: context);

    super.initState();
  }

  @override
  void dispose() {
    _scopedModelUpdateUser.disposeUser();
    super.dispose();
  }


  @override
  Widget build(BuildContext context)
  {
    return ScopedModel<ScopedModelUpdateUser>(
        model: _scopedModelUpdateUser,
        child: Scaffold(
          body: Container(
            child: ScopedModelDescendant<ScopedModelUpdateUser>(
              builder: (BuildContext context, Widget child, ScopedModelUpdateUser model) {
                return StreamBuilder<UpdateUser>(
                    stream: model.outUpdateUser,
                    builder: ( context,  snapshot)
                    {

                      switch (snapshot.connectionState)
                      {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return SpinKitCircle(color: ColorsV.defaultColor);
                        default:
                          if (snapshot.hasError)
                            return Center(child: new Text('Error: ${snapshot.error}'));
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
                                              ///---------------------------  Name ----------------------------------//
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10),
                                                padding: const EdgeInsets.all(3.0),
                                                decoration: myBoxDecoration(),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("${snapshot.data.data.profile.name}",style: TextStyle(fontSize: 18,color: ColorsV.defaultColor),),
                                                ),
                                              ),


                                              ///------------------------------- TextField Email--------------------------------//
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10),
                                                padding: const EdgeInsets.all(3.0),
                                                decoration: myBoxDecoration(),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("${snapshot.data.data.profile.email}",style: TextStyle(fontSize: 18,color: ColorsV.defaultColor),),
                                                ),
                                              ),

                                              //email

                                              ///-----------------------------TextField Phone ---------------------------------//
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10),
                                                padding: const EdgeInsets.all(3.0),
                                                decoration: myBoxDecoration(),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("${snapshot.data.data.profile.phone}",style: TextStyle(fontSize: 18,color: ColorsV.defaultColor),),
                                                ),
                                              ),
                                              //phone

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
                                        image: new AssetImage("assets/appbar/background_app_bar.png"),
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
                                                color: Colors.transparent, // button color
                                                child: InkWell(
                                                  splashColor: Colors.amberAccent,
                                                  // inkwell color
                                                  child: SizedBox(
                                                      width: 45,
                                                      height: 45,
                                                      child: Image.asset(
                                                        "assets/icons/15.png",
                                                        width: 25,
                                                        height: 25,
                                                      )),
                                                  onTap: ()
                                                  {
                                                    _scopedModelUpdateUser.openEditAccountUser(context);

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

                                        trailing: Container(child: SizedBox(
                                            width: 45,
                                            height: 45,
                                           ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                      }
                    }
                );
              },
            ) ,
          ),)
    );
  }



  BoxDecoration myBoxDecoration()
  {
    return BoxDecoration(
      border: Border.all(
          width: 1.0
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(15.0) //
      ),
    );
  }





}

