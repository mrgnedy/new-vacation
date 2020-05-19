import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageAdvertiser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageUser.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart' as prefix0;
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart';
import 'package:vacatiion/pages/SubPages/UserPages/offers_chalets/chalet_card.dart';
import 'package:vacatiion/utility/page-route-transition.dart';

class UserOffers extends StatefulWidget {
  @override
  _UserOffersState createState() => _UserOffersState();
}

class _UserOffersState extends State<UserOffers> {
  ScopedModelMainPageUser get _scopedModelMainPageUser =>
      GetIt.I<ScopedModelMainPageUser>();

  @override
  void initState() {
    _scopedModelMainPageUser.initialStreamControllerOffers();
    _scopedModelMainPageUser.stopLoadingHomePage();
    _scopedModelMainPageUser.getAllOffersUser(context: context);
    _scopedModelMainPageUser.outAllOffersUser.listen((onData) {
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
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModelMainPageUser>(
        model: _scopedModelMainPageUser,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: ScopedModelDescendant<ScopedModelMainPageUser>(
              builder: (BuildContext context, Widget child,
                  ScopedModelMainPageUser model) {
                return StreamBuilder<AllChaletsAndOffersModel>(
                    stream: model.outAllOffersUser,
                    builder: (context, snapshot) =>
                        ChaletCard(context, snapshot, callback));
              },
            ),
          ),
        ));
  }

  Future callback(id) {
    print('Fav ADDED');
    return _scopedModelMainPageUser
        .addFavorites(chaletId: id.toString(), context: context)
        .then(
            (_) => _scopedModelMainPageUser.getAllOffersUser(context: context));
  }

//Widget _buildChaletCard(BuildContext context,AsyncSnapshot snapshot)
//{
//
//  switch (snapshot.connectionState)
//  {
//    case ConnectionState.none:
//    case ConnectionState.waiting:
//      if(ScopedModelMainPageUser.checkExistOffers)
//        return Align(
//            alignment: Alignment.topCenter,
//            child: SpinKitCircle(color: Colors.white));
//      else
//        return Center(child: Text("لا توجد عروض",style: TextStyle(
//            fontSize: 25.0,
//            color: Colors.white,
//            fontWeight: FontWeight.bold,
//            fontFamily: 'DinNextLight'),),);
//      break;
//
//    default:
//      if (snapshot.hasError)
//        return Center(child: new Text('Error: ${snapshot.error}'));
//      else
//        return Container(
//          decoration: BoxDecoration(color: Colors.transparent),
//          child: Stack(
//            children: <Widget>[
//              ///============================ Content Page ============================//
//              ListView.builder(
//                  physics: NeverScrollableScrollPhysics(),
//                  itemCount: snapshot.data.data.length,
//                  itemBuilder: (context,index)
//                  {
//                    return InkWell(
//                      onTap: () {
//                        Navigator.push(context,
//                            SlideRightRoute(page: ShowChaletUser(chaletId: snapshot.data.data[index].id,)));
//                      },
//                      child: Padding(
//                        padding:
//                        const EdgeInsets.symmetric(horizontal: 3),
//                        child: Card(
//                          child: Container(
//                            decoration: BoxDecoration(
//                              image: DecorationImage(
//                                  image: NetworkImage("http://vacatiion.net/public/images/"+snapshot.data.data[index].images[0].image),
//                                  fit: BoxFit.fill),
//                            ),
//                            height: 165,
//                            child: Stack(
//                              children: <Widget>[
//
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween
//                                  ,
//                                  children: <Widget>
//                                  [
//                                    ///-----------------------------------VIEW-----------------------//
//                                    Padding(
//                                      padding: const EdgeInsets.all(5.0),
//                                      child: Column(
//                                        children: <Widget>[
//                                          //----------Logo-----------//
//                                          Image.asset(
//                                            "assets/Views/views.png",
//                                            height: 20,
//                                            width: 40,
//                                            fit: BoxFit.fill,
//                                          ),
//                                          //---------Number Views-----------//
//                                          Text(
//                                            "${snapshot.data.data[index].views}",
//                                            style: TextStyle(
//                                              color: Colors.white,
//                                            ),
//                                          )
//                                        ],
//                                      ),
//                                    ),
//                                    //-------------------Like Button----------------------//
//                                    InkWell(
//                                      onTap: ()
//                                      {
//                                        _scopedModelMainPageUser.addFavorites(chaletId: snapshot.data.data[index].id.toString(),context: context);
//                                      },
//                                      child: Padding(
//                                        padding: const EdgeInsets.all(5.0),
//                                        child: Column(
//                                          children: <Widget>[
//                                            //----------Logo-----------//
//                                            snapshot.data.data[index].isFavourite==false?Icon(
//                                              Icons.favorite,
//                                              color: Colors.grey,
//                                              size: 35.0,
//                                            ):Icon(
//                                              Icons.favorite,
//                                              color: Colors.red,
//                                              size: 35.0,
//                                            )
//                                            //---------Number Views-----------//
//
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                    //-------------------------Delete000
//
//                                  ],),
//
//
//                                Padding(
//                                  padding:
//                                  const EdgeInsets.only(bottom: 5),
//                                  child: Align(
//                                    alignment: Alignment.bottomCenter,
//                                    child: Container(
//                                        width: 235.0,
//                                        height: 90.0,
//                                        decoration: new BoxDecoration(
//                                          color: Color(0xff370066),
//                                          border: new Border.all(
//                                              color: Color(0xff370066),
//                                              width: 1.0),
//                                          borderRadius:
//                                          new BorderRadius.circular(
//                                              5.0),
//                                        ),
//                                        child: Column(
//                                          children: <Widget>[
//                                            //--------------------------------Rating-------------------------//
//                                            SmoothStarRating(
//                                                allowHalfRating: false,
//                                                rating: double.parse(snapshot.data.data[index].averageRating),
//                                                onRatingChanged: (v) {
//                                                  //  rating = v;
//                                                  setState(() {});
//                                                },
//                                                starCount: 5,
//                                                // ratingV: v,
//                                                size: 20.0,
//                                                color: Colors.amber,
//                                                borderColor: Colors.amber,
//                                                spacing: 0.0),
//                                            //-----------------------Name Cha----------------------//
//                                            new Text(
//                                              '${snapshot.data.data[index].name}',
//                                              style: new TextStyle(
//                                                  fontSize: 18.0,
//                                                  color: Colors.white),
//                                            ),
//                                            //--------------Price-------------------------//
//                                            new Text(
//                                              ' خصم ${snapshot.data.data[index].discount}'+" ريال سعودي",
//                                              style: new TextStyle(
//                                                  fontSize: 18.0,
//                                                  color: Colors.white),
//                                            ),
//
//                                          ],
//                                        )),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//                    );
//                  }),
//
//            ],
//          ),
//        );
//  }
//}
//
//
}
