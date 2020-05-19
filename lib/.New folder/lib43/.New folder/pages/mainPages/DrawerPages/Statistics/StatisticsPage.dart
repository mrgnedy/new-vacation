import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';


import 'SupPage/StatisticsbyMonth.dart';
import 'SupPage/StatisticsbyYear.dart';

//الاحصائيات----
//-------------Main for Main Statistics----------------//
class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            ///============================Content Page==========================//
            DefaultTabController(
                length: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      bottom: TabBar(
                          unselectedLabelColor: ColorsV.defaultColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ColorsV.defaultColor),
                          tabs: [
                            //--------Month-----------//
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: ColorsV.defaultColor, width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      "الشهر",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'DinNextLight'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //--------Year-----------//
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: ColorsV.defaultColor, width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      "السنه",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'DinNextLight'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    body: TabBarView(children: [
                      StatisticsbyMonth(),
                      StatisticsbyYear(),
                    ]),
                  ),
                )),

            ///--------------------- AppBar------------------------------//
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
                        "الإحصائيات",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'DinNextLight'),
                      )),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent, // button color
                            child: InkWell(
                              splashColor: Colors.white,
                              // inkwell color
                              child: SizedBox(
                                  width: 45,
                                  height: 45,
                                  child: Image.asset(
                                    "assets/icons/13.png",
                                    width: 25,
                                    height: 25,
                                  )),
                              onTap: () {
//                              Navigator.push(
//                                  context, SlideRightRoute(page: MainWidget()));

                                //  Navigator.push(context,MaterialPageRoute(builder: (context)=>MainWidget()));

                                //  Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///--------------- ButtonNavigation ------------------//
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Text("المبلغ الكلي 500 ريال سعودى",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'DinNextMedium',fontSize: 17)),
                      )),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/bootom_navigation/bootom_nv.png"),
                          fit: BoxFit.fill)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
