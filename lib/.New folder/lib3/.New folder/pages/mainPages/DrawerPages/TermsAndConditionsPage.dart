
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModelDrawerPages.dart';
import 'package:vacatiion/model/ModelDrawer.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';

class TermsAndConditionsPage extends StatefulWidget
{



  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {

  ScopedModelDrawerPages _scopedModelDrawerPages;

  @override
  void initState()
  {
    _scopedModelDrawerPages=ScopedModelDrawerPages();
    super.initState();
  }


  @override
  Widget build(BuildContext context)
  {

    return  ScopedModel<ScopedModelDrawerPages>(
      model: _scopedModelDrawerPages,
      child: Scaffold(
        body:  Stack(
          children: <Widget>[
        FutureBuilder(
         future:  _scopedModelDrawerPages.getTermsAndConditions(context: context), //This is the method name above
          builder: (context, snapshot)
          {

            if (!snapshot.hasData) {
              return Center(
                child: SpinKitPumpingHeart(color: ColorsV.defaultColor),
              );
            } else {

              if (snapshot.data.status == Utility.VERIFICATION_CODE_SUCCESS)
                return ListView(

                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(top: 95,right: 12,left: 10,bottom: 20),
                      child: Text("${snapshot.data.data[0].toString()}",style: TextStyle(fontSize: 19,
                          color: ColorsV.defaultColor,
                          fontFamily: 'DinNextMedium',height: 2),
                        textDirection: TextDirection.rtl,),
                    )
                  ],
                );

              return Center(child: Text("لا توجد بيانات",style: TextStyle(fontSize: 19,
                  color: ColorsV.defaultColor,
                  fontFamily: 'DinNextMedium',height: 2),
                textDirection: TextDirection.rtl,));
            }

          }),
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
                            "الشروط والأحكام",
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


