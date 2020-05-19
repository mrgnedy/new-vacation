import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageAdvertiser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageUser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelReservations.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart' as prefix0;
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/ContactUsPage.dart';
import 'package:vacatiion/utility/RatingDialog.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';

import 'RportingChaitPage.dart';

class CancelReservation extends StatefulWidget
{

  bool flag1Cancel;
  bool flag2Rating;
  bool flag3Report;
  String chaletName;
  String startDate;
  String endtDate;
  String chaletId;

  CancelReservation({this.flag1Cancel,this.flag2Rating,this.flag3Report,this.chaletName,this.startDate,this.endtDate,this.chaletId});

  @override
  _CancelReservationState createState() => _CancelReservationState();
}

class _CancelReservationState extends State<CancelReservation> {



   int feedbackRating=0;

  ScopedModelReservations  _modelReservations=ScopedModelReservations();

  @override
  void initState()
  {
    _modelReservations.stopLoadingHomePage();

    super.initState();
  }

  @override
  void dispose()
  {
    super.dispose();
  }


  @override
  Widget build(BuildContext context)
  {
    return ScopedModel<ScopedModelReservations>(
        model: _modelReservations,
        child: Scaffold(

          body: Container(
            child: ScopedModelDescendant<ScopedModelReservations>(
              builder: (BuildContext context, Widget child, ScopedModelReservations model)
              {
                return  Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Stack(
                      children: <Widget>[

                        ListView(children: <Widget>
                        [
                          Padding(
                            padding: const EdgeInsets.only(top: 130),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: DashedContainer(
                                child: Container(
                                  height: 200.0,
                                  width: (MediaQuery.of(context).size.width)*0.9,
                                  decoration: BoxDecoration(color: ColorsV.defaultColor, borderRadius: BorderRadius.circular(20.0)),
                                 child: Column(children: <Widget>
                                 [
                                   ListTile(leading: Text("${widget.startDate}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                                            trailing: Text("بدايه الحجز",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),

                                   ),
                                   SizedBox(height: 10,),
                                   ListTile(leading: Text("${widget.startDate}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                                     trailing: Text("نهايه الحجز",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),

                                   ),
                                   SizedBox(height: 15,),

                                 ///-----------------------------------Cancel -----------------------------//
                                   Visibility(
                                     visible: widget.flag1Cancel,
                                     child: FlatButton(
                                       onPressed: ()
                                       {
                                         _modelReservations.cancelReservations(context: context,chaletId: widget.chaletId);
                                         debugPrint('I am Awesome');
                                       },
                                       textColor: Colors.white,
                                       color: Colors.red,
                                       disabledColor: Colors.grey,
                                       disabledTextColor: Colors.white,
                                       highlightColor: Colors.orangeAccent,

                                       shape: RoundedRectangleBorder(
                                           borderRadius:
                                           BorderRadius.circular(20)),
                                       child: Padding(
                                         padding:
                                         const EdgeInsets.only(bottom: 6,right: 5,left: 5),
                                         child: Text("الغاء الحجز",
                                             style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 25,
                                                 fontFamily: 'DinNextLight')),
                                       ),
                                     ),
                                   ),
                                 ],),
                                ),
                                dashColor: Colors.black,
                                borderRadius: 20.0,
                                dashedLength: 30.0,
                                blankLength: 6.0,
                                strokeWidth: 6.0
                              ),
                            ),
                          ),

                          SizedBox(height: 30,),
                         ///-------------------------------------------Rating------------------------------------//
                          Visibility(
                             visible: widget.flag2Rating,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                              child: FlatButton(
                                onPressed: ()
                                {
                                  debugPrint('I am Awesome');
                                  shawAlertAddReating(chaletId: widget.chaletId,context2: context,nameChalit: widget.chaletName);
                                },
                                textColor: Colors.white,
                                 color: ColorsV.defaultColor,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.white,
                                highlightColor: Colors.orangeAccent,

                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20)),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 8,top: 2),
                                  child: Text("تقييم الشاليه ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'DinNextLight')),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8,),
                          ///-------------------------------------------Reporting------------------------------------//
                          Visibility(
                            visible: widget.flag3Report,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                              child: FlatButton(
                                onPressed: ()
                                {
                                  //RportingChaitPage
                                  Navigator.push(
                                      context, ScaleRoute(page: RportingChaitPage(chaletName: widget.chaletName,chaletId: widget.chaletId,)));
                                  debugPrint('I am Awesome');
                                },
                                textColor: Colors.white,
                                color: Colors.red,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.white,
                                highlightColor: Colors.orangeAccent,

                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20)),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 8,top: 2),
                                  child: Text("الابلاغ عن الشاليه",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'DinNextLight')),
                                ),
                              ),
                            ),
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
                                        "${widget.chaletName}",
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
                        //------------------------------Loading--------------------------//
                        Visibility (
                          visible: ScopedModelReservations.loadingHomePage,
                          child: Align(
                              alignment: Alignment.center,
                              child: SpinKitCircle(color: ColorsV.defaultColor)),
                        ),
                      ],
                    )

                );
              },
            ) ,
          ),)
    );
  }

  void shawAlertAddReating({String chaletId,BuildContext context2,String nameChalit}) {
    // We use the built in showDialog function to show our Rating Dialog
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context)
        {
          return  RatingDialog(
            icon: const Icon(Icons.home,color: ColorsV.defaultColor,size: 90,),
            // set your own image/icon widget
            title: "${nameChalit}تقييم شاليه ",
            description:
            " اضف تعليقاً لتحسين الخدمة المقدمة",
            submitButton: "نشر",
            alternativeButton: "اتصل بنا ؟",
            // optional
            positiveComment: " سعداء لخدمتكم",
            // optional
            negativeComment: "نعتذر عن أي إزعاج أو عقبات قد شاهدتها",
            // optional
            accentColor: ColorsV.defaultColor,
            feedbackComment:(comment)
            {
              print("---------------------from------${comment},${feedbackRating}-------");

              var comm =(null==comment)?"":comment;

              _modelReservations.addCommentForChalet(context: context2,chaletId: chaletId,comment:comm ,rate: feedbackRating);

            } ,
            // optional
            onSubmitPressed: (int rating)
            {
              setState(() {
                feedbackRating=rating;
              });
            },
            onAlternativePressed: ()
            {

              Navigator.push(
                  context, ScaleRoute(page: ContactUsPage()));

            },
          );

        });
  }


}












