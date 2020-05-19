import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:vacatiion/pages/SkipePages/MainSkipPages.dart';
import 'package:vacatiion/pages/login_signup/Register/RegisterAdvertiser.dart';
import 'package:vacatiion/pages/login_signup/Register/RegisterClient.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'MainPageUser.dart';



class FirstPage extends StatefulWidget
{
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


  final FirebaseMessaging _fcm = FirebaseMessaging();




  @override
  Widget build(BuildContext context)
  {

    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom,]);
     //----change status bar color---------//
        SystemChrome.setSystemUIOverlayStyle(
           SystemUiOverlayStyle(statusBarColor: ColorsV.defaultColor));

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[

              //--------------------------Logo-----------------------------//
              Container(
                height: 250,
                child: Stack(children: <Widget>
                [
                  Image.asset("assets/background/background.png",width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset("assets/logo/logo.png",width: MediaQuery.of(context).size.width,fit: BoxFit.fill,)),
                ],),
              ),
              SizedBox(height: 55,),
              //------------------------------2 Buttons ----------------------------------//
              ///============================================Btn مقدم الخدمه=====================================//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: InkWell(
                  onTap: ()
                  {
                    ///=========================== open RegisterAdvertiser ================================//
                    Navigator.pushReplacement(
                        context, SizeRoute(page: RegisterAdvertiser()));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/button_click/background_btn.png'),
                          fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: Text(
                        "مقدم الخدمة",
                        style: TextStyle(color: Colors.white,
                            fontSize: 22,fontFamily: 'DinNextMedium',),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ///========================================== Btn طالب الخدمه=========================================//
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: InkWell(
                  onTap: ()
                  {
                     //================open MainPagesUser===============//
                    Navigator.pushReplacement(
                        context, SizeRoute(page: RegisterClient()));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/button_click/background_btn.png'),
                          fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: Text("طالب الخدمة",
                          style: TextStyle(color: Colors.white,
                              fontSize: 22,fontFamily: 'DinNextMedium',)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ///===================================  Divider  تخطى =====================//
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: ColorsV.borderColor,
                            height: 1.5,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: ()
                              {
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainWidgetSkipPages()));

                                ///// Navigator.pushReplacement(
                                //context, MaterialPageRoute(builder: (context) => MainWidget()));
                              },
                              child: Center(
                                child: Text(
                                  "تخطي",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color:ColorsV.defaultColor,fontFamily: 'DinNextMedium'),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: ColorsV.borderColor,
                            height: 1.5,
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {

        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']!=null?message['notification']['title']:message['aps']['alert']['title']),
              subtitle: Text(message['notification']!=null?message['notification']['body']:message['aps']['alert']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }


}
