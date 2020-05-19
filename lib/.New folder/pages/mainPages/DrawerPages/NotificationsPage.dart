
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModelDrawerPages.dart';
import 'package:vacatiion/model/ModelDrawer.dart';
import 'package:vacatiion/model/NotificationsModel.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';

class NotificationsPage extends StatefulWidget
{



  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

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
                future:  _scopedModelDrawerPages.getNotifications(context: context), //This is the method name above
                builder: (context, AsyncSnapshot<NotificationsModel> snapshot)
                {

                  if (!snapshot.hasData)
                  {
                    return Center(
                      child: SpinKitPumpingHeart(color: ColorsV.defaultColor),
                    );
                  } else {

                    if (snapshot.data.status == Utility.VERIFICATION_CODE_SUCCESS)
                      return ListView.builder(
                          itemCount:snapshot.data.data.length,
                          padding: EdgeInsets.only(top: 120),
                          itemBuilder: (context, index)
                          {
                            return  Column(
                              children: <Widget>[
                                ///=============================================Content===============================================//
                                ///----------------------Title ------------------------------//
                                Text(
                                  "${snapshot.data.data[index].title}",
                                  style: TextStyle(
                                      color: ColorsV.defaultColor,
                                      fontSize: 23.0,
                                      fontFamily: 'DinNextLight',fontWeight: FontWeight.bold),

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8,right: 10,left: 10,bottom: 8),
                                  child: Text(
                                    "${snapshot.data.data[index].body}",
                                    style: TextStyle(
                                      color: ColorsV.defaultColor,
                                      fontSize: 23.0,
                                      fontFamily: 'DinNextLight',),
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    //  textDirection: TextDirection.rtl,
                                    softWrap: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8,right: 10,left: 10,bottom: 8),
                                  child: Text(
                                    "${snapshot.data.data[index].updatedAt}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 23.0,
                                      fontFamily: 'DinNextLight',),
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    //  textDirection: TextDirection.rtl,
                                    softWrap: true,
                                  ),
                                ),
                                new SizedBox(
                                  height: 10.0,
                                  child: new Center(
                                    child: new Container(
                                      margin: new EdgeInsetsDirectional.only(start: 30.0, end: 30.0),
                                      height: 2.0,
                                      color: ColorsV.defaultColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                              ],
                            );
                          }

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
                            "الاشعارات",
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



