import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import 'package:vacatiion/ScopedModels/ScopedModelShowChalet.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart' as prefix0;
import 'package:vacatiion/model/ShowChaletModel.dart';
import 'package:vacatiion/model/ShowChaletModel.dart' as prefix1;
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart';
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart' as prefix2;
import 'package:vacatiion/pages/mainPages/DrawerPages/ContactUsPage.dart';
import 'package:vacatiion/utility/RatingDialog.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:geocoder/geocoder.dart';


class SkipShowChalet extends StatefulWidget {
  int chaletId;

  SkipShowChalet({this.chaletId});

  @override
  _SkipShowChaletState createState() => _SkipShowChaletState();
}

class _SkipShowChaletState extends State<SkipShowChalet> {

  ScopedModelShowChalet get _scopedModelShowChalet => GetIt.I<ScopedModelShowChalet>();

  double reating=0;

  int feedbackRating=0;

  int role_id=0;
  int discount=0;

  //------------------------------------//
  DateTime startOfPeriod;
  DateTime endOfPeriod;
  DateTime firstDate;
  DateTime lastDate;
  //-----------------------------------//


  List<String>imageList;

  String locationName="السعوديه";
  String cancellationPolicyText="سياسه الالغاء المرنه ";


  String StartDate;
  String endDate;



  @override
  void initState()
  {
    check();
    // _scopedModelShowChalet.showLoadingPage();
    _scopedModelShowChalet.initialStreamControllerShowChalet();
    _scopedModelShowChalet.getDataForChaletSkipe(context: context, chaletId: widget.chaletId);
    imageList=List<String>();
    _scopedModelShowChalet.outStreamShowChalet.listen((onData)
    {
      for(int i=0;i<onData.data.chalet.images.length;i++)
      {
        imageList.add("http://vacatiion.net/public/images/"+onData.data.chalet.images[i].image);
      }
      getNameLocationForUser(lat: onData.data.chalet.lat,long: onData.data.chalet.lng);
      cancellationPolicy(onData.data.chalet.cancel);

    });


    super.initState();
  }
  TextEditingController _textFieldAddDescountOfOffers = TextEditingController();
  @override
  void dispose() {
    _scopedModelShowChalet.disposeStreamControllerShowChalet();
    _textFieldAddDescountOfOffers.dispose();
    super.dispose();
  }



  TextEditingController _textFieldControllerPriceNight =
  TextEditingController();
  TextEditingController _textFieldController = TextEditingController();

  double spinnerPrice = 0;

  @override
  Widget build(BuildContext context)
  {



    return ScopedModel<ScopedModelShowChalet>(
        model: _scopedModelShowChalet,
        child: Scaffold(
            body: ScopedModelDescendant<ScopedModelShowChalet>(
                builder: (BuildContext context, Widget child,
                    ScopedModelShowChalet model) {
                  return StreamBuilder<ShowChalet>(
                      stream: model.outStreamShowChalet,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return  Align(alignment: Alignment.topCenter,
                                child: SpinKitCircle(color: ColorsV.defaultColor));

                          default:
                            if (snapshot.hasError)
                              return Center(
                                  child: new Text('Error: ${snapshot.error}'));
                            else
                              return Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Stack(
                                  children: <Widget>[
                                    ///================================== Content Page ============================//
                                    Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: ListView(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 80,
                                          ),

                                          ///---------------------------------------- Carousel Image Chalet ------------------------------------------//
                                          Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context).size.width,
                                            height: 180,
                                            child: CarouselDemoView(imgList: imageList,rate: snapshot.data.data.rate,nightNumber: snapshot.data.data.chalet.nightNumber,),
                                          ),

                                          SizedBox(
                                            height: 5,
                                          ),

                                          ///---------------------------- Price for All Days -------------------//
                                          Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context).size.width,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  width:
                                                  MediaQuery.of(context).size.width,
                                                  child: Stack(
                                                    children: <Widget>[
                                                      //---------LEFT Row----//
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            right: 0),
                                                        child: Align(
                                                          alignment:
                                                          Alignment.centerRight,
                                                          child: Container(
                                                            width: 150,
                                                            child: Column(
                                                              children: <Widget>[
                                                                //--------------Saturday----------//
                                                                Row(
                                                                  children: <Widget>[
                                                                    Card(
                                                                      elevation: 1,
                                                                      child: Container(
                                                                        width: 80,
                                                                        height: 50,
                                                                        decoration:
                                                                        new BoxDecoration(
                                                                          //new Color.fromRGBO(255, 0, 0, 0.0),
                                                                            borderRadius:
                                                                            new BorderRadius.all(
                                                                              Radius
                                                                                  .circular(
                                                                                  10),
                                                                            )),
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        child: Text(
                                                                          "${snapshot.data.data.chalet.days[0].price}",
                                                                          style:
                                                                          TextStyle(
                                                                            fontFamily:
                                                                            'DinNextRegular',
                                                                            color: Color(
                                                                                0xff2E0063),
                                                                            fontSize:
                                                                            20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      'السبت',
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                        'DinNextRegular',
                                                                        color: Color(
                                                                            0xff2E0063),
                                                                        fontSize: 20,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                //---------------Sunday-----------//
                                                                Row(
                                                                  children: <Widget>[
                                                                    Card(
                                                                      elevation: 1,
                                                                      child: Container(
                                                                        width: 80,
                                                                        height: 50,
                                                                        decoration:
                                                                        new BoxDecoration(
                                                                          //new Color.fromRGBO(255, 0, 0, 0.0),
                                                                            borderRadius:
                                                                            new BorderRadius.all(
                                                                              Radius
                                                                                  .circular(
                                                                                  10),
                                                                            )),
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        child: Text(
                                                                          "${snapshot.data.data.chalet.days[1].price}",
                                                                          style:
                                                                          TextStyle(
                                                                            fontFamily:
                                                                            'DinNextRegular',
                                                                            color: Color(
                                                                                0xff2E0063),
                                                                            fontSize:
                                                                            20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      'الاحد',
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                        'DinNextRegular',
                                                                        color: Color(
                                                                            0xff2E0063),
                                                                        fontSize: 20,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                //---------------Monday----------//
                                                                Row(
                                                                  children: <Widget>[
                                                                    Card(
                                                                      elevation: 1,
                                                                      child: Container(
                                                                        width: 80,
                                                                        height: 50,
                                                                        decoration:
                                                                        new BoxDecoration(
                                                                          //new Color.fromRGBO(255, 0, 0, 0.0),
                                                                            borderRadius:
                                                                            new BorderRadius.all(
                                                                              Radius
                                                                                  .circular(
                                                                                  10),
                                                                            )),
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        child: Text(
                                                                          "${snapshot.data.data.chalet.days[2].price}",
                                                                          style:
                                                                          TextStyle(
                                                                            fontFamily:
                                                                            'DinNextRegular',
                                                                            color: Color(
                                                                                0xff2E0063),
                                                                            fontSize:
                                                                            20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      'الاثنين',
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                        'DinNextRegular',
                                                                        color: Color(
                                                                            0xff2E0063),
                                                                        fontSize: 20,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      //------Right Right--------//
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 0),
                                                        child: Align(
                                                          alignment:
                                                          Alignment.centerLeft,
                                                          child: Container(
                                                            width: 155,
                                                            child: Column(
                                                              children: <Widget>[
                                                                //--------------Saturday----------//
                                                                Row(
                                                                  children: <Widget>[
                                                                    Card(
                                                                      elevation: 1,
                                                                      child: Container(
                                                                        width: 80,
                                                                        height: 50,
                                                                        decoration:
                                                                        new BoxDecoration(
                                                                          //new Color.fromRGBO(255, 0, 0, 0.0),
                                                                            borderRadius:
                                                                            new BorderRadius.all(
                                                                              Radius
                                                                                  .circular(
                                                                                  10),
                                                                            )),
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        child: Text(
                                                                          "${snapshot.data.data.chalet.days[3].price}",
                                                                          style:
                                                                          TextStyle(
                                                                            fontFamily:
                                                                            'DinNextRegular',
                                                                            color: Color(
                                                                                0xff2E0063),
                                                                            fontSize:
                                                                            20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      'الثلاثاء',
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                        'DinNextRegular',
                                                                        color: Color(
                                                                            0xff2E0063),
                                                                        fontSize: 20,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                //---------------Sunday-----------//
                                                                Row(
                                                                  children: <Widget>[
                                                                    Card(
                                                                      elevation: 1,
                                                                      child: Container(
                                                                        width: 80,
                                                                        height: 50,
                                                                        decoration:
                                                                        new BoxDecoration(
                                                                          //new Color.fromRGBO(255, 0, 0, 0.0),
                                                                            borderRadius:
                                                                            new BorderRadius.all(
                                                                              Radius
                                                                                  .circular(
                                                                                  10),
                                                                            )),
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        child: Text(
                                                                          "${snapshot.data.data.chalet.days[4].price}",
                                                                          style:
                                                                          TextStyle(
                                                                            fontFamily:
                                                                            'DinNextRegular',
                                                                            color: Color(
                                                                                0xff2E0063),
                                                                            fontSize:
                                                                            20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      'الاربعاء',
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                        'DinNextRegular',
                                                                        color: Color(
                                                                            0xff2E0063),
                                                                        fontSize: 20,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                //---------------Monday----------//
                                                                Row(
                                                                  children: <Widget>[
                                                                    Card(
                                                                      elevation: 1,
                                                                      child: Container(
                                                                        width: 80,
                                                                        height: 50,
                                                                        decoration:
                                                                        new BoxDecoration(
                                                                          //new Color.fromRGBO(255, 0, 0, 0.0),
                                                                            borderRadius:
                                                                            new BorderRadius.all(
                                                                              Radius
                                                                                  .circular(
                                                                                  10),
                                                                            )),
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        child: Text(
                                                                          "${snapshot.data.data.chalet.days[5].price}",
                                                                          style:
                                                                          TextStyle(
                                                                            fontFamily:
                                                                            'DinNextRegular',
                                                                            color: Color(
                                                                                0xff2E0063),
                                                                            fontSize:
                                                                            20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      'الخميس',
                                                                      style: TextStyle(
                                                                        fontFamily:
                                                                        'DinNextRegular',
                                                                        color: Color(
                                                                            0xff2E0063),
                                                                        fontSize: 20,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                //------------------ Friday --------------------//
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: 150,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Card(
                                                          elevation: 1,
                                                          child: Container(
                                                            width: 80,
                                                            height: 50,
                                                            decoration:
                                                            new BoxDecoration(
                                                              //new Color.fromRGBO(255, 0, 0, 0.0),
                                                                borderRadius:
                                                                new BorderRadius
                                                                    .all(
                                                                  Radius.circular(10),
                                                                )),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              "${snapshot.data.data.chalet.days[6].price}",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                'DinNextRegular',
                                                                color:
                                                                Color(0xff2E0063),
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          'الجمعه',
                                                          style: TextStyle(
                                                            fontFamily:
                                                            'DinNextRegular',
                                                            color: Color(0xff2E0063),
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ///----------------------------- Location ------------------------------//
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Stack(
                                              children: <Widget>[
                                                //---------------icon Location------------//

                                                SizedBox(
                                                  width: 10,
                                                ),
                                                //------------------------ Name of Location -------------------//
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5, right: 5),
                                                  child: Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Wrap(children: <Widget>
                                                      [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: <Widget>[

                                                            Padding(
                                                              padding: EdgeInsets.only(left: 5),
                                                              child: Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      "assets/icons/20.png"),
                                                                  height: 30,
                                                                  width: 25,
                                                                  fit: BoxFit.fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                locationName,
                                                                textAlign: TextAlign.center,

                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  'DinNextRegular',
                                                                  color: Color(0xff2E0063),
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              ": العنوان",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                'DinNextRegular',
                                                                color: Color(0xff2E0063),
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],)
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          ///------------------------------- Type Chalet --------------------------//
                                          Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 5, right: 16),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: <Widget>[
                                                  //-------------------Value----------------//
                                                  Text(
                                                    "${snapshot.data.data.chalet.kind}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DinNextRegular',
                                                      color: Color(0xff2E0063),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  //------------------Key-----------------//
                                                  Text(
                                                    ": نوع العقار",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DinNextRegular',
                                                      color: Color(0xff2E0063),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          ///------------------------------Available for families----------------------------------------
                                          Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 5, right: 16),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: <Widget>[
                                                  //-------------------Value----------------//
                                                  Text(
                                                    "${snapshot.data.data.chalet.department}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DinNextRegular',
                                                      color: Color(0xff2E0063),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  //------------------Key-----------------//
                                                  Text(
                                                    "متاح ل",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DinNextRegular',
                                                      color: Color(0xff2E0063),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          ///------------------------------------- Area of Building ---------------------------//
                                          Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 5, right: 16),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: <Widget>[
                                                  //-------------------Value----------------//
                                                  //-------Unity---------//
                                                  Text(
                                                    "متر مربع",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DinNextRegular',
                                                      color: Color(0xff2E0063),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  //------- value for Area----//
                                                  Text(
                                                    " ${snapshot.data.data.chalet.space} ",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DinNextRegular',
                                                      color: Color(0xff2E0063),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  //------------------Key-----------------//
                                                  Text(
                                                    "مساحه العقار",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DinNextRegular',
                                                      color: Color(0xff2E0063),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          ///-------------------------------------  Minimum nights -------------------------//
                                          Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 5, right: 16),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: <Widget>[
                                                  //-------------------Value----------------//
                                                  //-------Unity---------//
                                                  Text(
                                                    "ريال سعودي",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DinNextRegular',
                                                      color: Color(0xff2E0063),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  //------- value for Area----//
                                                  Text(
                                                    " ${snapshot.data.data.chalet.nightNumber} ",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DinNextRegular',
                                                      color: Color(0xff2E0063),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  //------------------Key-----------------//
                                                  Text(
                                                    "الحد الأدنى لسعر الليله",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DinNextRegular',
                                                      color: Color(0xff2E0063),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),

                                          ///====================================== Description  for  Building =================================//
                                          //--------------------Divider--------------//
                                          new SizedBox(
                                            height: 10.0,
                                            child: new Center(
                                              child: new Container(
                                                margin: new EdgeInsetsDirectional.only(
                                                    start: 30.0, end: 30.0),
                                                height: 2.0,
                                                color: ColorsV.borderColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 10, right: 16),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "وصف العقار",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'DinNextRegular',
                                                    color: Color(0xff2E0063),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                            width: MediaQuery.of(context).size.width,
                                            height: 100,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: snapshot.data.data.chalet.descriptions.length,
                                                itemBuilder: (context, i) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 5, left: 5),
                                                    child: Container(
                                                      width: 130,
                                                      height: 95,
                                                      child: Column(
                                                        children: <Widget>[
                                                          //-----------------------Icons------------------------//
                                                          Image.asset(
                                                            "assets/icons/16.png",
                                                            height: 45,
                                                            width: 45,
                                                            fit: BoxFit.fill,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: <Widget>[
                                                              //-------------------- Numbers -----------------------//
                                                              Text(
                                                                "${snapshot.data.data.chalet.descriptions[i].value}",
                                                                textAlign:
                                                                TextAlign.center,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  'DinNextRegular',
                                                                  color:
                                                                  Color(0xff2E0063),
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "${snapshot.data.data.chalet.descriptions[i].key}",
                                                                textAlign:
                                                                TextAlign.center,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  'DinNextRegular',
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),

                                          ///====================================== About the property "الملكيه" =================================//
                                          //--------------------Divider--------------//
                                          new SizedBox(
                                            height: 10.0,
                                            child: new Center(
                                              child: new Container(
                                                margin: new EdgeInsetsDirectional.only(
                                                    start: 30.0, end: 30.0),
                                                height: 2.0,
                                                color: ColorsV.borderColor,
                                              ),
                                            ),
                                          ),
                                          //-------------------------Title------------------//
                                          Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 5, right: 16),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "عن الملكيه",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'DinNextRegular',
                                                    color: Color(0xff2E0063),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          //-----------------------
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 5,
                                            ),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${snapshot.data.data.chalet.about}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'DinNextRegular',
                                                    color: Color(0xff2E0063),
                                                    fontSize: 20,
                                                  ),
                                                )),
                                          ),

                                          ///====================================== means of comfort"وسائل الراحه" =================================//
                                          //------------------------ Divider -----------------------//
                                          new SizedBox(
                                            height: 10.0,
                                            child: new Center(
                                              child: new Container(
                                                margin: new EdgeInsetsDirectional.only(
                                                    start: 30.0, end: 30.0),
                                                height: 2.0,
                                                color: ColorsV.borderColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 10, right: 16),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "وسائل الراحه",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'DinNextRegular',
                                                    color: Color(0xff2E0063),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                            width: MediaQuery.of(context).size.width,
                                            height: 100,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: snapshot.data.data.chalet.restTools.length,
                                                itemBuilder: (context, i) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 5, left: 5),
                                                    child: Container(
                                                      width: 135,
                                                      height: 100,
                                                      child: Column(
                                                        children: <Widget>[
                                                          //-----------------------Icons------------------------//
                                                          Image.asset(
                                                            "assets/icons/16.png",
                                                            height: 45,
                                                            width: 45,
                                                            fit: BoxFit.fill,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "${restTools(snapshot.data.data.chalet.restTools[i])}",
                                                            textAlign:
                                                            TextAlign.center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                              'DinNextRegular',
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),

                                          ///------------------------------ Out and Enter  ---------------------------------//
                                          new SizedBox(
                                            height: 10.0,
                                            child: new Center(
                                              child: new Container(
                                                margin: new EdgeInsetsDirectional.only(
                                                    start: 30.0, end: 30.0),
                                                height: 2.0,
                                                color: ColorsV.borderColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 10,
                                                right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                //-------------------------- Out ----------------------//
                                                InkWell(
                                                  onTap: ()
                                                  {
                                                    DatePicker.showDatePicker(context,
                                                        showTitleActions: true,
                                                        minTime: DateTime(2019, 9, 5),
                                                        maxTime: DateTime(3019, 6, 7)
                                                        , onChanged: (date)
                                                        {

                                                          //2019-10-25
                                                          setState(() {
                                                            endDate=date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString();
                                                            print("=====================TTT ${endDate}");
                                                          });
                                                        }, onConfirm: (date)
                                                        {
                                                          //  print('====================confirm $date');
                                                        }, currentTime: DateTime.now(), locale: LocaleType.ar);
                                                  }
                                                  ,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      ///---------------   ---------------------//
                                                      Column(
                                                        children: <Widget>[
                                                          Text(
                                                            "المغادره",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'DinNextRegular',
                                                                color: Color(0xff2E0063),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                          Text(
                                                            "حدد التاريخ",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                              'DinNextRegular',
                                                              color: Color(0xff2E0063),
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Image.asset(
                                                        "assets/icons/19.png",
                                                        height: 45,
                                                        width: 45,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                //--------------------------- Enter --------------------//
                                                InkWell(
                                                  onTap: ()
                                                  {
                                                    DatePicker.showDatePicker(context,
                                                        showTitleActions: true,
                                                        minTime: DateTime(2019, 9, 5),
                                                        maxTime: DateTime(3019, 6, 7)
                                                        , onChanged: (date)
                                                        {

                                                          //2019-10-25
                                                          setState(() {
                                                            StartDate=date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString();
                                                            print("=====================TTT ${StartDate}");
                                                          });
                                                        }, onConfirm: (date)
                                                        {
                                                          //  print('====================confirm $date');
                                                        }, currentTime: DateTime.now(), locale: LocaleType.ar);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      ///---------------   ---------------------//
                                                      Column(
                                                        children: <Widget>[
                                                          Text(
                                                            "الدخول",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'DinNextRegular',
                                                                color: Color(0xff2E0063),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                          Text(
                                                            "حدد التاريخ",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                              'DinNextRegular',
                                                              color: Color(0xff2E0063),
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Image.asset(
                                                        "assets/icons/19.png",
                                                        height: 45,
                                                        width: 45,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          new SizedBox(
                                            height: 10.0,
                                            child: new Center(
                                              child: new Container(
                                                margin: new EdgeInsetsDirectional.only(
                                                    start: 30.0, end: 30.0),
                                                height: 2.0,
                                                color: ColorsV.borderColor,
                                              ),
                                            ),
                                          ),
                                          //-----------------------------------Condition of Subscripe--------------------//
                                          Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 5, right: 16),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "شروط الحجز",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'DinNextRegular',
                                                    color: Color(0xff2E0063),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                            width: MediaQuery.of(context).size.width,
                                            height: double.parse(snapshot.data.data.chalet.conditions.length.toString())*35,
                                            child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: snapshot.data.data.chalet.conditions.length,
                                                itemBuilder: (context, i) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 5, left: 5),
                                                    child: Text(
                                                      "${snapshot.data.data.chalet.conditions[i]}",
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                        'DinNextRegular',
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          //-------------------------------سياسه الاغاء----------------
                                          new SizedBox(
                                            height: 10.0,
                                            child: new Center(
                                              child: new Container(
                                                margin: new EdgeInsetsDirectional.only(
                                                    start: 30.0, end: 30.0),
                                                height: 2.0,
                                                color: ColorsV.borderColor,
                                              ),
                                            ),
                                          ),
                                          //-------------------------Title------------------//
                                          Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 5, right: 16),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "سياسه الالغاء",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'DinNextRegular',
                                                    color: Color(0xff2E0063),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          //-----------------------
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 5,
                                            ),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${cancellationPolicyText}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'DinNextRegular',
                                                    color: Color(0xff2E0063),
                                                    fontSize: 20,
                                                  ),
                                                )

                                            ),
                                          ),
                                          SizedBox(height: 15,),
                                          //------------------------------------------------------------------------//
                                          new SizedBox(
                                            height: 10.0,
                                            child: new Center(
                                              child: new Container(
                                                margin: new EdgeInsetsDirectional.only(
                                                    start: 30.0, end: 30.0),
                                                height: 2.0,
                                                color: ColorsV.borderColor,
                                              ),
                                            ),
                                          ),

                                          ///================================================Add to Offers==================================//
                                          Visibility(
                                            visible: (role_id==3),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 50),
                                              child: Container(
                                                width: 100,
                                                child: RaisedButton(
                                                  onPressed: ()
                                                  {
                                                    //shawAlertAddReating(snapshot.data.data.chalet.id.toString(),context,snapshot.data.data.chalet.name);
                                                    _onAlertAddDiscountForOffers(chaletId: snapshot.data.data.chalet.id.toString());

                                                  },
                                                  padding: EdgeInsets.all(8),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20)),
                                                  color: Color(0xee201D5F),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 10),
                                                    child: Text("اضافه للعروض",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25,
                                                            fontFamily: 'DinNextLight')),
                                                  ),
                                                ),
                                              ),
                                            ),),


                                          SizedBox(height: 15,),
                                          ///----------------------------------------- Btn  Done --------------------------------//
                                          InkWell(
                                            onTap: ()
                                            {
                                              Utility.shawAlertDialogFailedLoginPage(context: context,title: "الاداره",msg: "برجاء تسجيل الدخول للتمتع بصلاحيه المستخدم");

                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              child: Container(
                                                height: 60,
                                                width: double.infinity,
                                                decoration: new BoxDecoration(
                                                  image: new DecorationImage(
                                                    image: new AssetImage(
                                                        "assets/bootom_navigation/bootom_nv.png"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "التحقق من الاتاحية",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                        fontFamily: 'DinNextLight'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ///---------------------loading------------------//
                                          Visibility(
                                            visible: ScopedModelShowChalet.loadingPage,
                                            child: SpinKitCircle(color: ColorsV.defaultColor),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ///------------------------------------------------------------ AppBar ----------------------------------------------------//
                                    Container(
                                      height: 100,
                                      width: double.infinity,
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                          image: new AssetImage(
                                              "assets/appbar/background_app_bar.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Column(
                                          children: <Widget>[
                                            //-------------no----------//
                                            ListTile(
                                              leading: Container(
                                                width: 28,
                                                height: 28,
                                              ),
                                              //---------------------------------- Title --------------------------//
                                              title: Center(
                                                  child: Text(
                                                    "${snapshot.data.data.chalet.name}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily: 'DinNextLight'),
                                                  )),
                                              //------------------------------------  Back ----------------------------------//
                                              trailing: ClipOval(
                                                child: Material(
                                                  color: Colors.transparent,
                                                  // button color
                                                  child: InkWell(
                                                    splashColor: ColorsV.defaultColor,
                                                    // inkwell color
                                                    child: SizedBox(
                                                        width: 45,
                                                        height: 45,
                                                        child: Image.asset(
                                                          "assets/icons/13.png",
                                                          width: 25,
                                                          height: 25,
                                                        )),
                                                    onTap: ()
                                                    {
                                                      Utility.backPage(context);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                        }
                      });
                })));
  }


  String restTools(String idRest)
  {
    String valueName="";
    switch(idRest)
    {

      case "1":
        {
          return valueName="كرسي مساج";
        }
        break;
      case "2":
        {
          return valueName="ملائم لذوي الاعاقه";
        }
        break;
      case "3":
        {
          return valueName="نطيطه";
        }
        break;
      case "4":
        {
          return valueName="ملعب كره";
        }
        break;
      case "5":
        {
          return valueName="مسبح وساونا";
        }
        break;
      case "6":
        {
          return valueName="سينما";
        }
        break;
      case "7":
        {
          return valueName="غساله وثلاجه";
        }
        break;
      case "8":
        {
          return valueName="تلفاز";
        }
        break;
      case "9":
        {
          return valueName="واي فاي";
        }
        break;
      case "10":
        {
          return valueName="مكيف";
        }
        break;
      case "11":
        {
          return valueName="مدخل خاص";
        }
        break;
      case "12":
        {
          return valueName="حارس";
        }
        break;
    }









  }


  getNameLocationForUser({double lat,double long}) async {//call this async method from whereever you need

    final coordinates = new Coordinates(lat,long);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("==================${first.featureName} : ${first.addressLine}=====================");

    setState(() {
      locationName=first.featureName+" - "+first.addressLine;
    });

  }


  cancellationPolicy(int cancel)
  {
    switch(cancel)
    {

      case 0:
        {
          setState(() {
            cancellationPolicyText="سياسه الالغاء المرنه";
          });
        }
        break;
      case 1:
        {
          setState(() {
            cancellationPolicyText="سياسه الالغاء المعتدله";
          });
        }
        break;
      case 2:
        {
          setState(() {
            cancellationPolicyText="سياسه الالغاء الصارمه";
          });
        }
        break;

    }









  }



  void shawAlertDialog(String msg,String title)
  {
    Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: msg,
      style: Utility.alertStyle,
      buttons: [
        DialogButton(
          child: Text(
            "إلغاء",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

//    _showAlert()
//    {
////    AlertDialog dialog =
//   return  showDialog(
//     context: context,
//     builder: (context)
//     {
//       return AlertDialog(
//         content: new Container(
//           width: 260.0,
//           height: 230.0,
//           decoration: new BoxDecoration(
//             shape: BoxShape.rectangle,
//             color: const Color(0xFFFFFF),
//             borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
//           ),
//           child: new Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               // dialog top
//               new Expanded(
//                 child: new Row(
//                   children: <Widget>[
//                     new Container(
//                       // padding: new EdgeInsets.all(10.0),
//                       decoration: new BoxDecoration(
//                         color: Colors.white,
//                       ),
//                       child: new Text(
//                         'Rate',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 18.0,
//                           fontFamily: 'helvetica_neue_light',
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // dialog centre
//               new Expanded(
//                 child: new Container(
//                     child: new TextField(
//                       decoration: new InputDecoration(
//                         border: InputBorder.none,
//                         filled: false,
//                         contentPadding: new EdgeInsets.only(
//                             left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
//                         hintText: ' add review',
//                         hintStyle: new TextStyle(
//                           color: Colors.grey.shade500,
//                           fontSize: 12.0,
//                           fontFamily: 'helvetica_neue_light',
//                         ),
//                       ),
//                     )),
//                 flex: 2,
//               ),
//
//               // dialog bottom
//               new Expanded(
//                 child: new Container(
//                   padding: new EdgeInsets.all(16.0),
//                   decoration: new BoxDecoration(
//                     color: const Color(0xFF33b17c),
//                   ),
//                   child: new Text(
//                     'Rate product',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18.0,
//                       fontFamily: 'helvetica_neue_light',
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//   );
//   /// showDialog(context: context, child: dialog);
//  }


  Future<void> check() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      role_id = prefs.getInt(Utility.ROLE_ID);
    });
    print("========Role Id=========$role_id====================");
    //runApp(MaterialApp(home: email == null ? Login() : Home()));
  }


  _onAlertAddDiscountForOffers({String chaletId}) {
    Alert(
        context: context,
        title: "اضافه خصم للعرض",
        content: Column(
          children: <Widget>[
            TextField(
              controller: _textFieldAddDescountOfOffers,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.add_circle),
                labelText: 'قيمه الخصم',
              ),
            ),

          ],
        ),
        buttons: [
          DialogButton(
            onPressed: ()
            {
              Navigator.pop(context);
              if(_textFieldAddDescountOfOffers.text.toString().isEmpty||_textFieldAddDescountOfOffers.text.toString()==null)
              {
                Utility.showToast("لم يتم ادخال خصم ولم يتم اضافه عرض !!",context: context,duration:Toast.LENGTH_LONG,chooseColor: 1,gravity:Toast.BOTTOM);

              }else
              {
                print("==================${_textFieldAddDescountOfOffers.text.toString()}+${chaletId}");
                ScopedModelShowChalet _scopedModelShow=ScopedModelShowChalet();
                _scopedModelShow.addChaletToOffers(context: context,chaletId: chaletId,discount: int.parse(_textFieldAddDescountOfOffers.text.toString()));

                Utility.showToast("تم ادخال الخصم واضافه العرض",context: context,duration:Toast.LENGTH_LONG,chooseColor: 2,gravity:Toast.BOTTOM);
                _scopedModelShowChalet.stopLoadingPage();
              }


            },
            child: Text(
              " اضافه",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();


  }




}






///---------------------------------------Source ----------------------------------------//
//////------------------------ Image Cursor------------------//
//final List<String> imgList = [
//  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
//];

//-------------------------Used for Return List--------------------//
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}


///-------------------------------------------- Cur -----------------------------------------//
class CarouselDemoView extends StatefulWidget {

  List<String> imgList ;
  int rate;
  int nightNumber;

  CarouselDemoView({this.imgList,this.rate,this.nightNumber});

  @override
  _CarouselDemoViewState createState() => _CarouselDemoViewState();
}

class _CarouselDemoViewState extends State<CarouselDemoView> {

  List child ;
  String review="بدون تقييم";

  @override
  void initState()
  {

    getReview();

    child = map<Widget>(widget.imgList,

          (index, urlImage) {
        return Container(
          margin: EdgeInsets.all(1.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(children: <Widget>[
              Image.network(urlImage, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  //padding: EdgeInsets.symmetric(, horizontal: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ///------------------------------- Rating ------------------------------//
                            SmoothStarRating(
                                allowHalfRating: false,
                                rating: double.parse(widget.rate.toString()),
                                onRatingChanged: (v) {
                                  //  rating = v;
                                  //  setState(() {});
                                },
                                starCount: 5,
                                // ratingV: v,
                                size: 25.0,
                                color: Colors.amber,
                                borderColor: Colors.amber,
                                spacing: 0.0),
                            //------Text Rating-------//
                            Text(
                              "${review}",
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.only(
                              bottom: 5, top: 10.0, left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              //--------------------- index image -------------------------------//
                              Text(
                                '$index/${widget.imgList.length - 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  //  fontWeight: FontWeight.bold,
                                ),
                              ),
                              //---------------------------- Price for Image Chalet ------------------------//
                              Text(
                                "سعر الليله ${widget.nightNumber} ريال سعودى",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ],
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
  }

  @override
  Widget build(BuildContext context) {
    //Manually operated Carousel
    final CarouselSlider manualCarouselDemo = CarouselSlider(
      items: child,
      autoPlay: true,
      enlargeCenterPage: true,
      viewportFraction: 1.0,
      aspectRatio: 2.0,

    );

    return Scaffold(
      //appBar: AppBar(title: Text('Carousel slider demo')),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: manualCarouselDemo,)
    );



//    return Scaffold(
//      //appBar: AppBar(title: Text('Carousel slider demo')),
//      body: Center(
//        child: Padding(
//          padding: EdgeInsets.symmetric(vertical: 0.0),
//          child: manualCarouselDemo,
//        ),
//      ),
//    );


  }

  void getReview ()
  {
    switch(widget.rate)
    {

      case 0:
        {
          setState(() {
            review="بدون تقييم";
          });
        }
        break;
      case 1:
        {
          setState(() {
            review="سىء";
          });
        }
        break;
      case 2:
        {
          setState(() {
            review="عادي";
          });
        }
        break;
      case 3:
        {
          setState(() {
            review="جيد";
          });
        }
        break;
      case 4:
        {
          setState(() {
            review="جيد جدا";
          });
        }
        break;
      case 5:
        {
          setState(() {
            review="ممتاز";
          });
        }
        break;
    }

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
