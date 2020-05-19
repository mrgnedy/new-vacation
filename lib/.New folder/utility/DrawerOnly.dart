import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/ContactUsPage.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/NotificationsPage.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/Statistics/StatisticsPage.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/TermsAndConditionsPage.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/UsePolicyPage.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/WhoAreWePage.dart';
import 'package:vacatiion/pages/mainPages/FirstPage.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';

import 'colors.dart';



class DrawerOnly extends StatefulWidget {


  @override
  _DrawerOnlyState createState() => _DrawerOnlyState();
}

class _DrawerOnlyState extends State<DrawerOnly> {

  int role_id=0;


  @override
  void initState() {
    check();
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
        elevation: 5,
        child: new ListView(
          children: <Widget>[
            //------------------------ Logo ------------------//
            DrawerHeader(
              child: new Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/logo/logo.png'),
                      fit: BoxFit.cover),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.white),
            ),

            ///--------------------------- Content --------------------------------//
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                title: new Text(
                  "الإشعارات",
                  style: TextStyle(
                      fontSize: 22,
                      color: ColorsV.defaultColor,
                      fontFamily: 'DinNextMedium'),
                ),
                onTap: () {
                  Navigator.pop(context);
                  //RegisterAdvertiser
                  Navigator.push(
                      context, ScaleRoute(page: NotificationsPage()));
                  // NotificationsPage
                },
              ),
            ),
            Visibility(
              visible: (role_id==3),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  title: new Text("الإحصائيّات",
                      style: TextStyle(
                          fontSize: 22,
                          color: ColorsV.defaultColor,
                          fontFamily: 'DinNextMedium')),
                  onTap: () {
                    Navigator.pop(context);

                    // StatisticsPage
                    Navigator.push(context, ScaleRoute(page: StatisticsPage()));
                  },
                ),
              ),
            ),


            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                title: new Text("من نحن",
                    style: TextStyle(
                        fontSize: 22,
                        color: ColorsV.defaultColor,
                        fontFamily: 'DinNextMedium')),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, ScaleRoute(page: WhoAreWePage()));
                },
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                title: new Text("الشروط والأحكام",
                    style: TextStyle(
                        fontSize: 22,
                        color: ColorsV.defaultColor,
                        fontFamily: 'DinNextMedium')),
                onTap: () {
                  Navigator.pop(context);
                  //TermsAndConditionsPage
                  Navigator.push(
                      context, ScaleRoute(page: TermsAndConditionsPage()));
                },
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                title: new Text("سياسة الاستخدام",
                    style: TextStyle(
                        fontSize: 22,
                        color: ColorsV.defaultColor,
                        fontFamily: 'DinNextMedium')),
                onTap: () {
                  Navigator.pop(context);
                  //---UsePolicyPage
                  Navigator.push(context, ScaleRoute(page: UsePolicyPage()));
                },
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                title: new Text("اتصل بنا",
                    style: TextStyle(
                        fontSize: 22,
                        color: ColorsV.defaultColor,
                        fontFamily: 'DinNextMedium')),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, ScaleRoute(page: ContactUsPage()));
                  //ContactUsPage
                },
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                title: new Text("مشاركه التطبيق",
                    style: TextStyle(
                        fontSize: 22,
                        color: ColorsV.defaultColor,
                        fontFamily: 'DinNextMedium')),
                onTap: ()
                {
                  Navigator.pop(context);

                  shareApp();



                },
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                title: new Text("تسجيل الخروج",
                    style: TextStyle(
                        fontSize: 22,
                        color: ColorsV.defaultColor,
                        fontFamily: 'DinNextMedium')),
                onTap: () {
                  Utility.logOut();
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => FirstPage()));
                },
              ),
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

  void shareApp()async
  {
    if (Platform.isAndroid)
    {
      Share.share("https://play.google.com/store/apps/details?id="+"kws.com.vacatiion.vacatiion");


    } else if (Platform.isIOS)
    {
      Share.share("https://apps.apple.com/us/app/id"+"kws.com.vacation.vacation");
    }
  }

}