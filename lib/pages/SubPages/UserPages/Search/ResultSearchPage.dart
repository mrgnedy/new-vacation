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


///------------------------- Receive and display all search results and filter----------------------------------//
class ResultSearchPage extends StatefulWidget {

  AllChaletsAndOffersModel modelResulet;

  ResultSearchPage({this.modelResulet});

  @override
  _ResultSearchPageState createState() => _ResultSearchPageState();
}

class _ResultSearchPageState extends State<ResultSearchPage> {
  ScopedModeResultSearchPage _modeResultSearchPage;

  @override
  void initState() {
    _modeResultSearchPage = ScopedModeResultSearchPage();
    print("---------length----------${widget.modelResulet.data.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModeResultSearchPage>(
      model: _modeResultSearchPage,
      child: Scaffold(
        body: Stack(
          children: <Widget>
          [

           //------------------------------------Content-----------------------------//
            Padding(
                padding: const EdgeInsets.only(top: 85),
                child: Container(
                  child: ListView.builder(
                    itemCount: widget.modelResulet.data.length,
                    itemBuilder: (context, indexList) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: ShowChaletUser(
                                    chaletId:
                                    widget.modelResulet.data[indexList].id,
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "http://vacatiion.net/public/images/" +
                                            widget
                                                .modelResulet
                                                .data[indexList]
                                                .images[0]
                                                .image),
                                    fit: BoxFit.fill),
                              ),
                              height: 165,
                              child: Stack(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
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
                                              "${widget.modelResulet.data[indexList].favouritesCount}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
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
                                                  rating: double.parse(widget
                                                      .modelResulet
                                                      .data[indexList]
                                                      .averageRating),
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
                                                '${widget.modelResulet.data[indexList].name}',
                                                style: new TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white),
                                              ),
                                              //--------------Price-------------------------//
                                              new Text(
                                                '${widget.modelResulet.data[indexList].nightNumber} ريال سعودى ',
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
                    },
                  ),
                )),

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
