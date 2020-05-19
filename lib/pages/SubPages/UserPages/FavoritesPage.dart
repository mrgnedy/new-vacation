//المفضله--------
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import 'package:vacatiion/ScopedModels/ScopedModeFavorites.dart';
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart';

import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';


class FavoritePage extends StatefulWidget {
  @override
  _IncomingPageState createState() => _IncomingPageState();
}
class _IncomingPageState extends State<FavoritePage> {



  ScopedModeFavorites   _scopedModelFavorites ;

  @override
  void initState()
  {
    _scopedModelFavorites=ScopedModeFavorites();
    _scopedModelFavorites.initialStreamControllerFavorites();
    _scopedModelFavorites.stopLoadingHomePage();
    _scopedModelFavorites.getAllFavorites(context: context);
    _scopedModelFavorites.outAllFavorites.listen((onData)
    {
      print("============Numbers Of Favorites=====${onData.data.length}=====================");
    });
    super.initState();
  }

  @override
  void dispose() {
    _scopedModelFavorites.disposeStreamControllerChalet();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModeFavorites>(
      model: _scopedModelFavorites,
      child: Scaffold(
        body: Container(
        color: Colors.white,
        child: ScopedModelDescendant<ScopedModeFavorites>(
            builder: (BuildContext context, Widget child, ScopedModeFavorites model)
            {
              return StreamBuilder<AllChaletsAndOffersModel>(
                  stream: model.outAllFavorites,
                  builder: ( context, snapshot)
                  {

                    switch (snapshot.connectionState)
                    {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      if(ScopedModeFavorites.checkFavorites)
                        return Align(
                            alignment: Alignment.topCenter,
                            child: SpinKitCircle(color: ColorsV.defaultColor));
                      else
                        return Center(child: Text("لا توجد مفضلة",style: TextStyle(
                                        fontSize: 25.0,
                                        color:ColorsV.defaultColor,
                                       fontWeight: FontWeight.bold,
                            fontFamily: 'DinNextLight'),),);
                      break;


                      default:
                        if (snapshot.hasError)
                          return Center(child: new Text('Error: ${snapshot.error}'));
                        else
                          return  Stack(
                            children: <Widget>[
                              ///---------------- AppBar------------------------------//
                              Container(
                                height: 100,
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage("assets/appbar/background_app_bar.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Column(
                                    children: <Widget>[
                                      //-------------Title----------//
                                      ListTile(
                                        leading: Container(
                                          width: 28,
                                          height: 28,
                                        ),
                                        title: Center(
                                            child: Text(
                                              "المفضله",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontFamily: 'DinNextLight'),
                                            )),
//                           trailing: InkWell(
//                               onTap: () {},
//                               child: Image.asset(
//                                 "assets/icons/18.png",
//                                 width: 25,
//                                 height: 25,
//                               )),
                                        trailing: Container(
                                          width: 28,
                                          height: 28,
                                        ),
//                    trailing: ClipOval(
//                      child: Material(
//                        color: Colors.transparent, // button color
//                        child: InkWell(
//                          splashColor: Colors.amberAccent,
//                          // inkwell color
//                          child: SizedBox(
//                              width: 45,
//                              height: 45,
//                              child: Image.asset(
//                                "assets/icons/13.png",
//                                width: 25,
//                                height: 25,
//                              )),
//                          onTap: ()
//                          {
//                            Utility.backPage(context);
//                          },
//                        ),
//                      ),
//                    ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ///============================Content Page==========================//
                              Padding(
                                padding: const EdgeInsets.only(top: 85),
                                child: Container(
                                  child: ListView.builder(
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder: (context,indexList)
                                  {
                                    return  InkWell(
                                      onTap: ()
                                      {
                                        Navigator.push(context,
                                            SlideRightRoute(page: ShowChaletUser(chaletId: snapshot.data.data[indexList].id,)));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 3),
                                        child: Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image:
                                                  NetworkImage("http://vacatiion.net/public/images/"+snapshot.data.data[indexList].images[0].image),
                                                  fit: BoxFit.fill),
                                            ),
                                            height: 165,
                                            child: Stack(
                                              children: <Widget>[
                                                //------------------------Remove Favorites----------------------//
                                                InkWell(
                                                  onTap: ()
                                                  {

                                                       model.removeFavorites(context: context,chaletId: snapshot.data.data[indexList].id.toString());
                                                  }
                                                  ,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child:     Image.asset(
                                                      "assets/icons/3.png",
                                                      height: 33,
                                                      width: 33,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
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
                                                                rating: double.parse(snapshot.data.data[indexList].averageRating),
                                                                onRatingChanged: (v)
                                                                {
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
                                                              '${snapshot.data.data[indexList].name}',
                                                              style: new TextStyle(
                                                                  fontSize: 18.0,
                                                                  color: Colors.white),
                                                            ),
                                                            //--------------Price-------------------------//
                                                            new Text(
                                                               'ريال سعودى'+" "+"${snapshot.data.data[indexList].nightNumber}",
                                                              style: new TextStyle(
                                                                  fontSize: 18.0,
                                                                  color: Colors.white,),
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
                                ),)
                              ),
                              ///----------------------- Loading for Get Data -----------------------//
                              Visibility (
                                visible: ScopedModeFavorites.loadingHomePage,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: SpinKitCircle(color: ColorsV.defaultColor)),
                              ),
                            ],
                          );
                    }
                  }
              );
            }


        ),
      ),),
    );
  }
}