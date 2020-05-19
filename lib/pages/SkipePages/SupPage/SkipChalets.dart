import 'dart:async';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageAdvertiser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageUser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelSkipePage.dart';
import 'package:vacatiion/ScopedModels/ScopedModelUpdateUser.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';

import 'SkipShowChalet.dart';



class SkipChalets extends StatefulWidget
{



  @override
  _SkipChaletsState createState() => _SkipChaletsState();
}

class _SkipChaletsState extends State<SkipChalets> {


  ScopedModelSkipePage get scopedModelSkipePage => GetIt.I<ScopedModelSkipePage>();

  @override
  void initState()
  {
    scopedModelSkipePage.initialStreamSkipChalet();
    scopedModelSkipePage.stopLoadingHomePage();
    scopedModelSkipePage.getAllChaletSkip(context: context);
    scopedModelSkipePage.outAllChaletSkip.listen((onData)
    {
      print("============Numbers Of Chalites=====${onData.data.length}=====================");
    });
    super.initState();
  }

  @override
  void dispose()
  {
    //_scopedModelMainPageAdvertiser.disposeStreamControllerChalet();
    super.dispose();
  }


  @override
  Widget build(BuildContext context)
  {
    return ScopedModel<ScopedModelSkipePage>(
        model: scopedModelSkipePage,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: ScopedModelDescendant<ScopedModelSkipePage>(
              builder: (BuildContext context, Widget child, ScopedModelSkipePage model) {
                return StreamBuilder<AllChaletsAndOffersModel>(
                    stream: model.outAllChaletSkip,
                    builder: ( context, snapshot)
                    {
                      switch (snapshot.connectionState)
                      {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Align(
                              alignment: Alignment.topCenter,
                              child: SpinKitCircle(color: Colors.white));
                        default:
                          if (snapshot.hasError)
                            return Center(child: new Text('Error: ${snapshot.error}'));
                          else
                            return Container(
                              decoration: BoxDecoration(color: Colors.transparent),
                              child: Stack(
                                children: <Widget>[
                                  ///============================ Content Page ============================//
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.data.length,
                                      itemBuilder: (context,index)
                                      {
                                        return InkWell(
                                          onTap: ()
                                          {
                                        Navigator.push(context,
                                                SlideRightRoute(page: ShowChaletUser(isSkip:true,chaletId: snapshot.data.data[index].id,)));
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.symmetric(horizontal: 3),
                                            child: Card(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage("http://vacatiion.net/public/images/"+snapshot.data.data[index].images[0].image),
                                                      fit: BoxFit.fill),
                                                ),
                                                height: 165,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween
                                                      ,
                                                      children: <Widget>
                                                      [
                                                        ///-----------------------------------VIEW-----------------------//
                                                        Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: Column(
                                                            children: <Widget>[
                                                              //----------Logo-----------//
                                                              Image.asset(
                                                                "assets/Views/views.png",
                                                                height: 20,
                                                                width: 40,
                                                                fit: BoxFit.fill,
                                                              ),
                                                              //---------Number Views-----------//
                                                              Text(
                                                                "${snapshot.data.data[index].views}",
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        //-------------------Like Button----------------------//
                                                        InkWell(
                                                          onTap: ()
                                                          {
                                                            Utility.shawAlertDialogFailedLoginPage(context: context,title: "الاداره",msg: "برجاء تسجيل الدخول للتمتع بصلاحيه المستخدم");

                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(5.0),
                                                            child: Column(
                                                              children: <Widget>[
                                                                //----------Logo-----------//
                                                                snapshot.data.data[index].isFavourite==false?Icon(
                                                                  Icons.favorite,
                                                                  color: Colors.grey,
                                                                  size: 35.0,
                                                                ):Icon(
                                                                  Icons.favorite,
                                                                  color: Colors.red,
                                                                  size: 35.0,
                                                                )
                                                                //---------Number Views-----------//

                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        //-------------------------Delete000

                                                      ],)
                                                    ,
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(bottom: 5),
                                                      child: Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: Container(
                                                            width: 235.0,
                                                            height: 90.0,
                                                            decoration: new BoxDecoration(
                                                              color: Color(0xff370066),
                                                              border: new Border.all(
                                                                  color: Color(0xff370066),
                                                                  width: 1.0),
                                                              borderRadius:
                                                              new BorderRadius.circular(
                                                                  5.0),
                                                            ),
                                                            child: Column(
                                                              children: <Widget>[
                                                                //--------------------------------Rating-------------------------//
                                                                SmoothStarRating(
                                                                    allowHalfRating: false,
                                                                    rating: double.parse(snapshot.data.data[index].averageRating),
                                                                    onRatingChanged: (v) {
                                                                      //  rating = v;
                                                                      setState(() {});
                                                                    },
                                                                    starCount: 5,
                                                                    // ratingV: v,
                                                                    size: 20.0,
                                                                    color: Colors.amber,
                                                                    borderColor: Colors.amber,
                                                                    spacing: 0.0),
                                                                //-----------------------Name Cha----------------------//
                                                                new Text(
                                                                  '${snapshot.data.data[index].name}',
                                                                  style: new TextStyle(
                                                                      fontSize: 18.0,
                                                                      color: Colors.white),
                                                                ),
                                                                //--------------Price-------------------------//
                                                                new Text(
                                                                  '${snapshot.data.data[index].nightNumber} ريال سعودى ',
                                                                  style: new TextStyle(
                                                                      fontSize: 18.0,
                                                                      color: Colors.white),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),

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



}
