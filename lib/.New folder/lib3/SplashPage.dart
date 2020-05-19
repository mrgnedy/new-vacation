import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacatiion/pages/mainPages/FirstPage.dart';
import 'package:vacatiion/pages/mainPages/MainPageUser.dart';
import 'package:vacatiion/pages/mainPages/MainPageAdvertiser.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';


class SplashPage extends StatefulWidget
{
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  var role_id;

  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;



  @override
  void initState()
  {
    check();
    startTime();
    checkOSAndSaveToken();
    super.initState();
  }

  startTime() async
  {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

      //-----------------open navigation--------------//
  void navigationPage()
  {
     switch(role_id)
     {
       //-------------- login is advertiser -------------//
       case 3 : {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainWidgetAdvertiser()));}
       break;
       //---------------login is User-----------------//
       case 2 :
         {
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainWidgetUser()));
       }
       break;
        //---------------not login-----------------//
       default :
         {
         {
           //----------User OR advertiser---------//
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstPage()));
         }
       }
     }

  }

  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorsV.defaultColor
    ));

    return new Scaffold(

        body: Stack(
      children: <Widget>[
           ///------------------------- Background --------------------------------///
         Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/splash/splashv.png'), fit: BoxFit.cover),
          ),
//          child: Center(
//            child: CircularProgressIndicator(
//              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
//            ),
//          ),
        ),
      ],
    ));
  }

  Future<void> check() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        role_id = prefs.getInt(Utility.ROLE_ID);
      });
    print("========Role Id=========$role_id====================");
    //runApp(MaterialApp(home: email == null ? Login() : Home()));
  }


  void checkOSAndSaveToken() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    //------------------------Get Device Token --------------------------//

    _fcm.getToken().then((token)
    {
      print('token------ $token');
      prefs.setString(Utility.Device_Token, token);
    });

    if (Platform.isIOS)
    {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print('ios subscription   $iosSubscription    finished');
        // save the token  OR subscribe to a topic here
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }






    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid)
    {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      prefs.setString(Utility.OS_Platform, "isAndroid");


    } else if (Platform.isIOS)
    {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      prefs.setString(Utility.OS_Platform, "isIOS");
      print("-----------------------This Ios ${iosInfo.model}---------------------");
    }

  }




}

