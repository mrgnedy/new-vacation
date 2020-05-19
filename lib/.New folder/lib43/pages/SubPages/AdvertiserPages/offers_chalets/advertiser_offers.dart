import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageAdvertiser.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';
import 'package:vacatiion/pages/SubPages/AdvertiserPages/ShowOffers.dart';
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart' as prefix0;
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart';
import 'package:vacatiion/utility/page-route-transition.dart';

class AdvertiserOffers extends StatefulWidget {
  @override
  _AdvertiserOffersState createState() => _AdvertiserOffersState();
}

class _AdvertiserOffersState extends State<AdvertiserOffers>
    with AutomaticKeepAliveClientMixin {
  ScopedModelMainPageAdvertiser get _scopedModelMainPageAdvertiser =>
      GetIt.I<ScopedModelMainPageAdvertiser>();

  @override
  void initState() {
    _scopedModelMainPageAdvertiser.initialStreamControllerOffers();
    _scopedModelMainPageAdvertiser.stopLoadingHomePage();
    _scopedModelMainPageAdvertiser.getAllOffers(context: context);
    _scopedModelMainPageAdvertiser.outAllOffersAdvertiser.listen((onData) {
      print(
          "============Numbers Of Chalites=====${onData.data.length}=====================");
    });
    super.initState();
  }

  @override
  void dispose() {
    //_scopedModelMainPageAdvertiser.disposeStreamControllerChalet();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModelMainPageAdvertiser>(
        model: _scopedModelMainPageAdvertiser,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: ScopedModelDescendant<ScopedModelMainPageAdvertiser>(
              builder: (BuildContext context, Widget child,
                  ScopedModelMainPageAdvertiser model) {
                return StreamBuilder<AllChaletsAndOffersModel>(
                    stream: model.outAllOffersAdvertiser,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          if (ScopedModelMainPageAdvertiser.checkExistOffers)
                            return Align(
                                alignment: Alignment.topCenter,
                                child: SpinKitCircle(color: Colors.white));
                          else
                            return Center(
                              child: Text(
                                "لا توجد عروض",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
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
                              decoration:
                                  BoxDecoration(color: Colors.transparent),
                              child: Stack(
                                children: <Widget>[
                                  ///============================ Content Page ============================//
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.data.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                SlideRightRoute(
                                                    page: ShowOffers(
                                                  chaletId: snapshot
                                                      .data.data[index].id,
                                                )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3),
                                            child: Card(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "http://vacatiion.net/public/images/" +
                                                              snapshot
                                                                  .data
                                                                  .data[index]
                                                                  .images[0]
                                                                  .image),
                                                      fit: BoxFit.cover),
                                                ),
                                                height: 165,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Container(
                                                            width: 235.0,
                                                            height: 90.0,
                                                            decoration:
                                                                new BoxDecoration(
                                                              color: Color(
                                                                  0xff370066),
                                                              border: new Border.all(
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
                                                                    allowHalfRating:
                                                                        false,
                                                                    rating: double.parse(snapshot
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .averageRating),
                                                                    onRatingChanged:
                                                                        (v) {
                                                                      //  rating = v;
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    starCount:
                                                                        5,
                                                                    // ratingV: v,
                                                                    size: 20.0,
                                                                    color: Colors
                                                                        .lightBlue[600],
                                                                    borderColor:
                                                                        Colors
                                                                            .white,
                                                                    spacing:
                                                                        0.0),
                                                                //-----------------------Name Cha----------------------//
                                                                new Text(
                                                                  '${snapshot.data.data[index].name}',
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          18.0,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                //--------------Price-------------------------//
                                                                new Text(
                                                                  '${snapshot.data.data[index].nightNumber} ريال سعودى ',
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          18.0,
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
                                      }),
                                ],
                              ),
                            );
                      }
                    });
              },
            ),
          ),
        ));
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        backgroundColor: Colors.transparent,
//      body:  ListView.builder(
//        physics: NeverScrollableScrollPhysics(),
//        itemCount: 6
//        ,
//        itemBuilder: (context,i)
//        {
//          return InkWell(
//            onTap: () {
//              Navigator.push(context,
//                  SlideRightRoute(page: NameChaletView()));
//            },
//            child: Padding(
//              padding:
//              const EdgeInsets.symmetric(horizontal: 3),
//              child: Card(
//                child: Container(
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                        image: AssetImage(
//                            'assets/imagetest/1.jpg'),
//                        fit: BoxFit.cover),
//                  ),
//                  height: 165,
//                  child: Stack(
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.all(5.0),
//                        child: Column(
//                          children: <Widget>[
//                            //----------Logo-----------//
//                            Image.asset(
//                              "assets/Views/views.png",
//                              height: 20,
//                              width: 40,
//                              fit: BoxFit.fill,
//                            ),
//                            //---------Number Views-----------//
//                            Text(
//                              "1234",
//                              style: TextStyle(
//                                color: Colors.white,
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
//                      Padding(
//                        padding:
//                        const EdgeInsets.only(bottom: 5),
//                        child: Align(
//                          alignment: Alignment.bottomCenter,
//                          child: Container(
//                              width: 235.0,
//                              height: 90.0,
//                              decoration: new BoxDecoration(
//                                color: Color(0xff370066),
//                                border: new Border.all(
//                                    color: Color(0xff370066),
//                                    width: 1.0),
//                                borderRadius:
//                                new BorderRadius.circular(
//                                    5.0),
//                              ),
//                              child: Column(
//                                children: <Widget>[
//                                  //--------------------------------Rating-------------------------//
//                                  SmoothStarRating(
//                                      allowHalfRating: false,
//                                      rating: 3,
//                                      onRatingChanged: (v) {
//                                        //  rating = v;
//                                        setState(() {});
//                                      },
//                                      starCount: 5,
//                                      // ratingV: v,
//                                      size: 20.0,
//                                      color: Colors.amber,
//                                      borderColor: Colors.amber,
//                                      spacing: 0.0),
//                                  //-----------------------Name Cha----------------------//
//                                  new Text(
//                                    'اسم الاستراحه',
//                                    style: new TextStyle(
//                                        fontSize: 18.0,
//                                        color: Colors.white),
//                                  ),
//                                  //--------------Price-------------------------//
//                                  new Text(
//                                    '1ريال سعودى 50',
//                                    style: new TextStyle(
//                                        fontSize: 18.0,
//                                        color: Colors.white),
//                                  ),
//                                ],
//                              )),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          );
//        }),);
//  }
}
