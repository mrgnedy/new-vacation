import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart';
import 'package:vacatiion/utility/page-route-transition.dart';


////-----العروض-------
class OffersPage extends StatefulWidget
{
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (context,i)
      {
        return InkWell(
          onTap: () {
            Navigator.push(context,
                SlideRightRoute(page: OpenPostDescription()));
          },
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 3),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/imagetest/1.jpg'),
                      fit: BoxFit.cover),
                ),
                height: 165,
                child: Stack(
                  children: <Widget>[
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
                            "1234",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
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
                                    rating: 3,
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
                                  'اسم الاستراحه',
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white),
                                ),
                                //--------------Price-------------------------//
                                new Text(
                                  '1ريال سعودى 50',
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
      physics: NeverScrollableScrollPhysics(),

    );
  }
}

