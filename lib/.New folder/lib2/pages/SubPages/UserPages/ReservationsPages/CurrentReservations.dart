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
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';

import 'CancelReservationPage/CancelReservation.dart';

class CurrentReservations extends StatefulWidget
{
  @override
  _CurrentReservationsState createState() => _CurrentReservationsState();
}

class _CurrentReservationsState extends State<CurrentReservations> {





  ScopedModelReservations  _modelReservations=ScopedModelReservations();

  @override
  void initState()
  {
    _modelReservations.initialStreamChaletReservations();
    _modelReservations.stopLoadingHomePage();
    _modelReservations.getAllReservationsRecent(context: context);
    _modelReservations.outAllChaletReservations.listen((onData)
    {
      print("============Numbers Of Chalites=====${onData.data.length}=====================");
    });
    super.initState();
  }

  @override
  void dispose()
  {
    _modelReservations.disposeStreamChaletReservations();
    super.dispose();
  }


  @override
  Widget build(BuildContext context)
  {
    return ScopedModel<ScopedModelReservations>(
        model: _modelReservations,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: ScopedModelDescendant<ScopedModelReservations>(
              builder: (BuildContext context, Widget child, ScopedModelReservations model)
              {
                return StreamBuilder<AllChaletsAndOffersModel>(
                    stream: model.outAllChaletReservations,
                    builder: ( context, snapshot)
                    {

                      switch (snapshot.connectionState)
                      {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          if (ScopedModelMainPageUser.checkExistOffers)
                            return Align(
                                alignment: Alignment.topCenter,
                                child: SpinKitCircle(color: Colors.white));
                          else
                            return Center(child: Text(
                              "لا يوجد حجوزات حاليه", style: TextStyle(
                                fontSize: 25.0,
                                color: ColorsV.defaultColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DinNextLight'),),);
                          break;

                        default:
                          if (snapshot.hasError)
                            return Center(
                                child: new Text('Error: ${snapshot.error}'));
                          else
                            return
                              Container(
                                color: Colors.white,
                                child:
                                ///============================Content Page==========================//
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: ListView.builder(
                                          itemCount: snapshot.data.data.length,
                                          itemBuilder: (context, index)
                                          {
                                            return  InkWell(
                                                onTap: ()
                                                {

                                                  Navigator.push(context,
                                                        SlideRightRoute(page: CancelReservation(flag1Cancel: true,flag2Rating: false,flag3Report: false,chaletName: snapshot.data.data[index].name,endtDate: snapshot.data.data[index].startDate,
                                                                                                                                                         startDate: snapshot.data.data[index].endDate,chaletId: snapshot.data.data[index].id.toString()
                                                                                                                                                   ,)));
                                                },
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(horizontal: 3),
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
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .all(5.0),
                                                          child: Image.asset(
                                                            "assets/icons/3.png",
                                                            height: 33,
                                                            width: 33,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              bottom: 5),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                                width: 235.0,
                                                                height: 90.0,
                                                                decoration: new BoxDecoration(
                                                                  color: Color(
                                                                      0xff370066),
                                                                  border: new Border
                                                                      .all(
                                                                      color: Color(
                                                                          0xff370066),
                                                                      width: 1.0),
                                                                  borderRadius:
                                                                  new BorderRadius
                                                                      .circular(
                                                                      5.0),
                                                                ),
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    //--------------------------------Rating-------------------------//
                                                                    SmoothStarRating(
                                                                        allowHalfRating: false,
                                                                        rating: double.parse(snapshot.data.data[index].averageRating),
                                                                        onRatingChanged: (
                                                                            v) {
                                                                          //  rating = v;
                                                                          setState(()
                                                                          {

                                                                           });
                                                                        },
                                                                        starCount: 5,
                                                                        // ratingV: v,
                                                                        size: 20.0,
                                                                        color: Colors
                                                                            .amber,
                                                                        borderColor: Colors
                                                                            .amber,
                                                                        spacing: 0.0),
                                                                    //-----------------------Name Cha----------------------//
                                                                    new Text(
                                                                      '${snapshot.data.data[index].name.toString()}',
                                                                      style: new TextStyle(
                                                                          fontSize: 18.0,
                                                                          color: Colors
                                                                              .white),
                                                                    ),
                                                                    //-------------- Price -------------------------//
                                                                    new Text(
                                                                      'ريال سعودى ${snapshot.data.data[index].nightNumber}',
                                                                      style: new TextStyle(
                                                                          fontSize: 18.0,
                                                                          color: Colors
                                                                              .white),
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
                                          })

                                  ),
                                ),
                              );
                      }

                    });
              },
            ) ,
          ),)
    );
  }




}












