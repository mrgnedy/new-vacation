import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/ScopedModels/ScopedModeResultSearchPage.dart';
import 'package:vacatiion/ScopedModels/ScopedModelDrawerPages.dart';
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';
import 'package:vacatiion/model/ModelDrawer.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';

import '../ShowChalet.dart';

class NoChalets extends StatefulWidget {
  String msg;

  NoChalets({this.msg});

  @override
  _NoChaletsState createState() => _NoChaletsState();
}

class _NoChaletsState extends State<NoChalets> {
  ScopedModeResultSearchPage _modeResultSearchPage;

  @override
  void initState() {
    _modeResultSearchPage = ScopedModeResultSearchPage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModeResultSearchPage>(
      model: _modeResultSearchPage,
      child: Scaffold(
        body: Stack(
          children: <Widget>[

            ListView(
              padding: EdgeInsets.only(top: 200),
              children: <Widget>
            [
                Center(
                  child: Text("لا توجد شاليهات",style: TextStyle(fontSize: 19,
                      color: ColorsV.defaultColor,
                      fontFamily: 'DinNextMedium',height: 2),
                    textDirection: TextDirection.rtl,),
                ),

                Center(
                  child: Text("${widget.msg}",style: TextStyle(fontSize: 19,
                      color: ColorsV.defaultColor,
                      fontFamily: 'DinNextMedium',height: 2),
                    textDirection: TextDirection.rtl,),
                ),
              ],),

            ///=========================================================== AppBar =====================================================//
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/appbar/background_app_bar.png"),
                  fit: BoxFit.fill,
                )),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 35,
                    ),
                    //------------------- Title AppBar ---------------//
                    ListTile(
                      leading: Container(
                        height: 25,
                        width: 25,
                      ),
                      title: Center(
                          child: Text(
                        "نتائج البحث",
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      )),
                      trailing: InkWell(
                          onTap: () {
                            Utility.backPage(context);
                          },
                          child: Image.asset(
                            "assets/icons/13.png",
                            width: 27,
                            height: 27,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
