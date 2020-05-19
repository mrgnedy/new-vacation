import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageUser.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';

import '../ShowChalet.dart';

class ChaletCard extends StatefulWidget {
  final BuildContext context;
  final AsyncSnapshot snapshot;
  final Function callback;
  final String type;
  ChaletCard(this.context, this.snapshot, this.callback, {this.type});

  @override
  _ChaletCardState createState() => _ChaletCardState();
}

class _ChaletCardState extends State<ChaletCard> {
  @override
  void initState() {
    // TODO: implement initState
  }
  Widget showPrice(index) {
    final x = widget.snapshot.data.data[index].discount;
    final currentChalet = widget.snapshot.data.data[index];
    if (widget.type == 'العروض')
      return Align(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              currentChalet.nightNumber.toString(),
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 18,
                  color: Colors.white),
            ),
            Text(
              '${(currentChalet.nightNumber - currentChalet.discount)} ريال سعودى',
              style: TextStyle(fontSize: 18, color: Colors.white),
            )
          ],
        ),
      );
    return Text(
      'ريال سعودى ${currentChalet.nightNumber.toString()}',
      style: TextStyle(fontSize: 18, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        if (ScopedModelMainPageUser.checkExistOffers)
          return Align(
              alignment: Alignment.topCenter,
              child: SpinKitCircle(color: Colors.white));
        else
          return Center(
            child: Text(
              "لا توجد ${widget.type}",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DinNextLight'),
            ),
          );
        break;

      default:
        if (widget.snapshot.hasError)
          return Center(child: new Text('Error: ${widget.snapshot.error}'));
        else
          return Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Stack(
              children: <Widget>[
                ///============================ Content Page ============================//
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.snapshot.data.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: ShowChaletUser(
                                chaletId: widget.snapshot.data.data[index].id,
                              )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Container(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "http://vacatiion.net/public/images/" +
                                            widget.snapshot.data.data[index]
                                                .images[0].image),
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
                                              "${widget.snapshot.data.data[index].views}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      //-------------------Like Button----------------------//
                                      InkWell(
                                        onTap: () {
                                          widget.callback(
                                              widget.snapshot.data.data[index]);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: <Widget>[
                                              //----------Logo-----------//
                                              widget.snapshot.data.data[index]
                                                          .isFavourite ==
                                                      false
                                                  ? Icon(
                                                      Icons.favorite,
                                                      color: Colors.grey,
                                                      size: 35.0,
                                                    )
                                                  : Icon(
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
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          width: 235.0,
                                          height: 110.0,
                                          decoration: new BoxDecoration(
                                            color: Color(0xff370066),
                                            border: new Border.all(
                                                color: Color(0xff370066),
                                                width: 1.0),
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              //--------------------------------Rating-------------------------//
                                              SmoothStarRating(
                                                  allowHalfRating: false,
                                                  rating: double.parse(widget
                                                      .snapshot
                                                      .data
                                                      .data[index]
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
                                                '${widget.snapshot.data.data[index].name}',
                                                style: new TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white),
                                              ),
                                              //--------------Price-------------------------//
                                              // new Text(
                                              //   // ;;;
                                              //   ' خصم ${widget.snapshot.data.data[index].discount}' +
                                              //       " ريال سعودي",
                                              //   style: new TextStyle(
                                              //       fontSize: 18.0,
                                              //       color: Colors.white),
                                              // ),
                                              showPrice(index)
                                            ],
                                          )),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(
                                      'assets/logoNOBG.png',
                                      height: 30,
                                      width: 30,
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
}
