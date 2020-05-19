import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:flutter/services.dart';

import 'EditPostPage.dart';

class OpenPostDescription extends StatefulWidget {
  @override
  _MainPagesUserState createState() => _MainPagesUserState();
}

class _MainPagesUserState extends State<OpenPostDescription> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ///------------------Background Full Page---------------------------------//
          Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
        ),
        ///----------------Background AppBar------------------------------//
          Container(
          height: 100,
          width: double.infinity,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/appbar/background_app_bar.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        ///============================Content Page==========================//
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: <Widget>
            [

              Column(
                children: <Widget>[
                  //============================AppBar============================//
                  Container(
                    // height: 100,
                    padding: EdgeInsets.only(top: 10),
//                     decoration:BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("assets/background/background.png"),
//                             fit: BoxFit.fill))
                    child: Column(
                      children: <Widget>[
                        //-------------Title----------//
                        ListTile(
                          //--edit
                          leading: InkWell(
                              onTap: () {
                                //
                                Navigator.push(
                                    context, FadeRoute(page: EditPostPage()));
                              },
                              child: Image.asset(
                                "assets/icons/15.png",
                                width: 25,
                                height: 25,
                              )),
                          title: Center(
                              child: Text(
                            "استراحه النور",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'DinNextLight'),
                          )),
                          //---Back
                          trailing: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                "assets/icons/13.png",
                                width: 25,
                                height: 25,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ///===============================Content page=================================//
                  SizedBox(
                    height: 5,
                  ),
                  //--------------------Carousel Image Chalet------------------//
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 180,
                    child: CarouselDemo(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //---------------------------Price for the night---------------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 5,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              //---------------Price------------//
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: <Widget>[
                                    //---------------Price Type---------------//
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "ريال سعودى",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'DinNextRegular',
                                              color: Color(0xff2E0063),
                                              fontSize: 20,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    //--------------Price Value--------//
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "500",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'DinNextRegular',
                                              color: Color(0xff2E0063),
                                              fontSize: 20,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                width: 7,
                              ),
                              //--------------Text Price of Night------------//
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 15),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "سعر الليله",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                  //-----------------------------Location------------------------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 3,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              //---------------icon Location------------//
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image(
                                    image: AssetImage("assets/icons/20.png"),
                                    height: 30,
                                    width: 25,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 10,
                              ),
                              //--------------Name of Location------------//
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 15),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "جده-المملكه العربيه",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                  //-------------------------Type of building--------------------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 3,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              //--------------Name of Location------------//
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 15),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "نوع العقار",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),



                            ],
                          )),
                    ),
                  ),
                  //--------Name of building-------------//
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "استراحة",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'DinNextRegular',
                            color: Color(0xff2E0063),
                            fontSize: 20,
                          ),
                        )),
                  ),
                  //---------------------------Type of Department---------------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 3,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              //--------------Name of Location------------//
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 15),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "القسم",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                  //--------Name of Department-------------//
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "عائلى",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'DinNextRegular',
                            color: Color(0xff2E0063),
                            fontSize: 20,
                          ),
                        )),
                  ),
                  //---------------------------Area of building---------------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 5,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              //---------------Price------------//
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: <Widget>[
                                    //---------------Price Type---------------//
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "متر مربع",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'DinNextRegular',
                                              color: Color(0xff2E0063),
                                              fontSize: 20,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    //--------------Price Value--------//
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "200",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'DinNextRegular',
                                              color: Color(0xff2E0063),
                                              fontSize: 20,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                width: 7,
                              ),
                              //--------------Text Price of Night------------//
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 15),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "مساحه العقار",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                  //---------------------------Minimum number of nights---------------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 5,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              //---------------Price------------//
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: <Widget>[
                                    //---------------Price Type---------------//
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "ليلة",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'DinNextRegular',
                                              color: Color(0xff2E0063),
                                              fontSize: 20,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    //--------------Price Value--------//
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "2",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'DinNextRegular',
                                              color: Color(0xff2E0063),
                                              fontSize: 20,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              //--------------Text Price of Night------------//
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 15),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "الحد الادني الليالى",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                  //---------------------------Description of building---------------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 3,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              //--------------Name of Location------------//
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 15),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "وصف العقار",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                  //--------Name of building-------------//
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("2"),
                            SizedBox(
                              width: 4,
                            ),
                            Text("سرير مزدوج"),
                            SizedBox(
                              width: 5,
                            ),
                            Image(
                              image: AssetImage("assets/icons/16.png"),
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("2"),
                            SizedBox(
                              width: 4,
                            ),
                            Text("سرير مزدوج"),
                            SizedBox(
                              width: 5,
                            ),
                            Image(
                              image: AssetImage("assets/icons/16.png"),
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            )
                          ],
                        )),
                  ),
                  //------------------------About the property----------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 3,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 420,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 5, right: 15, top: 5),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      "عن الملكيه",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 1, right: 1, left: 1, bottom: 1),
                                child: Text(
                                  "هنالك العديد من الأنواع المتوفرة لنصوص لوريم إيبسوم، ولكن الغالبية تم تعديلها بشكل ما عبر إدخال بعض النوادر أو الكلمات العشوائية إلى النص. إن كنت تريد أن تستخدم نص لوريم إيبسوم ما، عليك أن تتحقق أولاً أن ليس هناك أي كلمات أو عبارات محرجة أو غير لائقة مخبأة في هذا النص. بينما تعمل جميع مولّدات نصوص لوريم إيبسوم على الإنترنت على إعادة تكرار مقاطع من نص لوريم إيبسوم نفسه عدة مرات بما تتطلبه الحاجة، يقوم مولّدنا هذا باستخدام كلمات من قاموس يحوي على أكثر من 200 كلمة لا تينية، مضاف إليها مجموعة من الجمل النموذجية، لتكوين نص لوريم إيبسوم ذو شكل منطقي قريب إلى النص الحقيقي. وبالتالي يكون النص الناتح خالي من التكرار، أو أي كلمات أو عبارات غير لائقة أو ما شابه. وهذا ما يجعله أول مولّد نص لوريم إيبسوم حقيقي على الإنترنت.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'DinNextRegular',
                                    color: Color(0xff2E0063),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  //-------------------------------meansComfort-----------------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 3,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              //--------------Name of Location------------//
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 15),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "وسائل الراحه",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                  //-------------meansComfort-------------//
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("تكييف"),
                            SizedBox(
                              width: 5,
                            ),
                            Image(
                              image: AssetImage("assets/icons/10.png"),
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("واي فاي"),
                            SizedBox(
                              width: 5,
                            ),
                            Image(
                              image: AssetImage("assets/icons/9.png"),
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("حارس"),
                            SizedBox(
                              width: 7,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Image(
                                  image: AssetImage("assets/icons/8.png"),
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.fill,
                                ))
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("تلفاز"),
                            SizedBox(
                              width: 5,
                            ),
                            Image(
                              image: AssetImage("assets/icons/7.png"),
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            )
                          ],
                        )),
                  ),
                  //---------------------------N of WC---------------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 5,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              //---------------Price------------//
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: <Widget>[
                                    //--------------Price Value--------//
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "4",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'DinNextRegular',
                                              color: Color(0xff2E0063),
                                              fontSize: 20,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                width: 7,
                              ),
                              //--------------Text Price of Night------------//
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 15),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "عدد دورات المياه",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                  //-------------------------------Rules Home-----------------------//
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Card(
                      elevation: 3,
                      child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                                width: 1.0, color: Color(0xffE1E1E1)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //                 <--- border radius here
                                ),
                          ),
                          height: 60,
                          child: Stack(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              //--------------Name of Location------------//
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 15),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "شروط الحجز",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 20,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                  //-------------meansComfort-------------//
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "مسموح للحفلات و المناسبات",
                      style: TextStyle(
                          color: Color(0xff393939),
                          fontSize: 20,
                          height: 0.8,
                          fontFamily: 'DinNextLight',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "مسموح بدخول الحيوانات الاليفه",
                      style: TextStyle(
                          color: Color(0xff393939),
                          fontSize: 20,
                          height: 0.8,
                          fontFamily: 'DinNextLight',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "مسموح التدخين",
                      style: TextStyle(
                          color: Color(0xff393939),
                          fontSize: 20,
                          height: 0.8,
                          fontFamily: 'DinNextLight',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //----------------
                ],
              ),

              //------------------Btn  Available---------------//
              InkWell(
                onTap: ()
                {
                   Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/bootom_navigation/bootom_nv.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Text("متاح",style: TextStyle(color: Colors.white,
                                                          fontSize: 25,
                                                          fontFamily: 'DinNextLight'),),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ],
    );
  }
}

//------------------------ Image Cursor------------------//
final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

//-------------------------Used for Return List--------------------//
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

final List child = map<Widget>(
  imgList,
  (index, urlImage) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.network(urlImage, fit: BoxFit.cover, width: 1000.0),
          // Align(
          //   child: Image.asset('assets/logoNOBG.png'),
          // ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              //padding: EdgeInsets.symmetric(, horizontal: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //-------------Rating---------------//
                  Container(
                    width: double.infinity,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        //------Rating------//
                        SmoothStarRating(
                            allowHalfRating: false,
                            rating: 10,
                            onRatingChanged: (v) {
                              //  rating = v;
                              //  setState(() {});
                            },
                            starCount: 10,
                            // ratingV: v,
                            size: 20.0,
                            color: Colors.amber,
                            borderColor: Colors.amber,
                            spacing: 0.0),
                        //------Text Rating-------//
                        Text(
                          "رائع",
                          style: TextStyle(color: Colors.amber, fontSize: 17),
                        )
                      ],
                    ),
                  ),
                  //--------------------------------Number Images----------------------------//
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: 40,
                    width: double.infinity,
                    padding: EdgeInsets.all(0.0),
                    //------Background Color Gradient in Text------//
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$index/${imgList.length - 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Manually operated Carousel
    final CarouselSlider manualCarouselDemo = CarouselSlider(
      items: child,
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 1.0,
      aspectRatio: 2.0,
    );

    return Scaffold(
      //appBar: AppBar(title: Text('Carousel slider demo')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0),
          child: manualCarouselDemo,
        ),
      ),
    );
  }
}
class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}
class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: map<Widget>(
          imgList,
          (index, url) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ),
      ),
    ]);
  }
}


