import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageAdvertiser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageUser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelReservations.dart';
import 'package:vacatiion/ScopedModels/ScopedModelStatistics.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';
import 'package:vacatiion/model/ReservationsAdvertiser.dart';
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart' as prefix0;
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';

class StatisticsbyYear extends StatefulWidget
{
  @override
  _StatisticsbyYearState createState() => _StatisticsbyYearState();
}

class _StatisticsbyYearState extends State<StatisticsbyYear> {
  ScopedModelStatistics _modelReservations = ScopedModelStatistics();

  @override
  void initState() {
    _modelReservations.initialStreamChaletReservations();
    _modelReservations.stopLoadingHomePage();
    _modelReservations.getAllYearReservationsPrevious(context: context);
    _modelReservations.outAllChaletReservations.listen((onData) {
      print(
          "============Numbers Of Chalites=====${onData.data.toString()}=====================");
    });
    super.initState();
  }

  @override
  void dispose() {
    _modelReservations.disposeStreamChaletReservations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModelStatistics>(
        model: _modelReservations,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: ScopedModelDescendant<ScopedModelStatistics>(
              builder: (BuildContext context, Widget child,
                  ScopedModelStatistics model) {
                return StreamBuilder<ReservationsAdvertiser>(
                    stream: model.outAllChaletReservations,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          if (ScopedModelMainPageUser.checkExistOffers)
                            return Align(
                                alignment: Alignment.topCenter,
                                child: SpinKitCircle(color: Colors.white));
                          else
                            return Center(
                              child: Text(
                                "لا يوجد احصائيات حاليه",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: ColorsV.defaultColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DinNextLight'),
                              ),
                            );
                          break;

                        default:
                          if (snapshot.hasError)
                            return Center(
                                child: new Text('Error: ${snapshot.error}'));
                          else
                            return Container(
                              color: Colors.white,
                              child:

                              ///============================ Content Page ==========================//
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: ListView.builder(
                                      itemCount: snapshot
                                          .data.data.reservations.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: <Widget>[
                                            ///=============================================Content===============================================//
                                            //====================Divider==================//
                                            Center(
                                              child: new Container(
                                                margin:
                                                new EdgeInsetsDirectional
                                                    .only(
                                                    start: 30.0, end: 30.0),
                                                height: 2.0,
                                                color: Color(0xffDADBDB),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            //------------Data-----------//
                                            ListTile(
                                              //----------------Dot-----------------//
                                              trailing: Container(
                                                height: 12,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                    ColorsV.defaultColor),
                                              ),
                                              //--------------Date---------------//
                                              title: Container(
                                                alignment:
                                                Alignment.centerRight,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "${snapshot.data.data.reservations[index].startDate}",
                                                      style: TextStyle(
                                                          color: ColorsV
                                                              .defaultColor,
                                                          fontSize: 18),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      "${snapshot.data.data.reservations[index].endDate}",
                                                      style: TextStyle(
                                                          color: ColorsV
                                                              .defaultColor,
                                                          fontSize: 18),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              //--------------Price----------------//
                                              leading: Text(
                                                "ريال سعودي ${snapshot.data.data.reservations[index].price}",
                                                style: TextStyle(
                                                    color: ColorsV.defaultColor,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            );
                      }
                    });
              },
            ),
          ),
        ));
  }
}
