import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:vacatiion/pages/SubPages/UserPages/ReservationsPages/CurrentReservations.dart';
import 'package:vacatiion/pages/SubPages/UserPages/ReservationsPages/PreviousReservations.dart';
import 'package:vacatiion/pages/SubPages/UserPages/ReservationsPages/UpcomingReservations.dart';
import 'package:vacatiion/utility/colors.dart';
import 'MainPageAdvertiser.dart';

//الحجوزات
class ReservationsPageAdvertiser extends StatefulWidget {
  @override
  _ReservationsPageAdvertiserState createState() =>
      _ReservationsPageAdvertiserState();
}

class _ReservationsPageAdvertiserState extends State<ReservationsPageAdvertiser>with SingleTickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          ///============================ Content Page ==========================//
          DefaultTabController(
              length: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    bottom: TabBar(
                        unselectedLabelColor: ColorsV.defaultColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color:ColorsV.defaultColor),
                        tabs: [
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: ColorsV.defaultColor, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text("حاليه",style: TextStyle(fontSize: 19,fontFamily: 'DinNextLight'),),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: ColorsV.defaultColor, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text("قادمه",style: TextStyle(fontSize: 19,fontFamily: 'DinNextLight'),),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: ColorsV.defaultColor, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text("سابقه",style: TextStyle(fontSize: 19,fontFamily: 'DinNextLight'),),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  body: TabBarView(children: [
                    CurrentReservations(),
                    UpcomingReservations(),
                    PreviousReservations(),
                  ]),
                ),
              )),
          ///--------------------- AppBar --------------------------//
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
                    leading: Container(
                      height: 25,
                      width: 25,
                    ),
                    title: Center(
                        child: Text(
                      "الحجوزات",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'DinNextLight'),
                    )),

                    trailing:  Container(
                      height: 25,
                      width: 25,
                    ),
//                    trailing: Padding(
//                      padding: const EdgeInsets.only(top: 9),
//                      child: ClipOval(
//                        child: Material(
//                          color: Colors.transparent, // button color
//                          child: InkWell(
//                            splashColor: Colors.white,
//                            // inkwell color
//                            child: SizedBox(
//                                width: 45,
//                                height: 45,
//                                child: Image.asset(
//                                  "assets/icons/13.png",
//                                  width: 25,
//                                  height: 25,
//                                )),
//                            onTap: ()
//                            {
//                              Navigator.pop(context);
//                            },
//                          ),
//                        ),
//                      ),
//                    ),
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
