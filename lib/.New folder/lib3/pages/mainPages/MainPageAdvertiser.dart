import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/services.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageAdvertiser.dart';
import 'package:vacatiion/pages/SubPages/AdvertiserPages/account/PersonalAccountAdvertiser.dart';
import 'package:vacatiion/pages/SubPages/AdvertiserPages/offers_chalets/advertiser_chalets.dart';
import 'package:vacatiion/pages/SubPages/AdvertiserPages/offers_chalets/advertiser_offers.dart';
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/ContactUsPage.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/NotificationsPage.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/Statistics/StatisticsPage.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/TermsAndConditionsPage.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/UsePolicyPage.dart';
import 'package:vacatiion/pages/mainPages/DrawerPages/WhoAreWePage.dart';
import 'package:vacatiion/utility/DrawerOnly.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import '../SubPages/AdvertiserPages/AddAnnouncementPage.dart';
import 'FirstPage.dart';
import '../SubPages/UserPages/FavoritesPage.dart';
import 'ReservationsPage.dart';

//---------------الصفحه الرئيسيه للمعلن-----------------
class MainWidgetAdvertiser extends StatefulWidget {
  @override
  _MainWidgetAdvertiser createState() => _MainWidgetAdvertiser();
}

class _MainWidgetAdvertiser extends State<MainWidgetAdvertiser> {
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static Function functionOpenDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  int selectedIndex = 0;

  //----------------AppBar----------------//
  final widgetOptions = [
    //----------------MainPage-------------------//
    MainPageAdvertiser(),
    //----------------Personal Pageالشخصى -------------------//
    PersonalAccountAdvertiser(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: (selectedIndex == 0)
              ? DecorationImage(
                  image: AssetImage("assets/background/background.png"),
                  fit: BoxFit.fill)
              : DecorationImage(
                  image: AssetImage("assets/background/backgroundt.png"),
                  fit: BoxFit.fill)),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: widgetOptions[selectedIndex],
        endDrawer: DrawerOnly(),
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Container(
              height: 75,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/bootom_navigation/bootom_nv.png"),
                      fit: BoxFit.fill)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //------------------- Account --------------//
                  ClipOval(
                    child: Material(
                      color: Colors.transparent, // button color
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: SizedBox(
                            width: 45,
                            height: 45,
                            child: Image.asset(
                              "assets/icons/1.png",
                              width: 25,
                              height: 25,
                            )),
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                      ),
                    ),
                  ),
                  //------------------------ Home -----------------//
                  ClipOval(
                    child: Material(
                      color: Colors.transparent, // button color
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: SizedBox(
                            width: 45,
                            height: 45,
                            child: Image.asset(
                              "assets/icons/5.png",
                              width: 25,
                              height: 25,
                            )),
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

////------------------------------------------ الصفحه الرئيسيه للمعلن -----------------------------------/
class MainPageAdvertiser extends StatefulWidget {
  @override
  _MainPageAdvertiserState createState() => _MainPageAdvertiserState();
}

class _MainPageAdvertiserState extends State<MainPageAdvertiser>
    with SingleTickerProviderStateMixin {
  ///-----------permission--------------//
  Geolocator _geolocator;
  TabController _tabController;
  ScopedModelMainPageAdvertiser get _scopedModelMainPageAdvertiser =>
      GetIt.I<ScopedModelMainPageAdvertiser>();

  int ratingV;

  @override
  void initState() {
    _geolocator = Geolocator();
    _tabController = TabController(initialIndex: 0, vsync: this, length: 2)
      ..addListener(listener);
    _scopedModelMainPageAdvertiser.stopLoadingHomePage();
    _scopedModelMainPageAdvertiser.getAllChalet(context: context);
    super.initState();
  }

  listener() {
    // if (_tabController.index == 1) {
    //   _scopedModelMainPageAdvertiser.getAllOffers(context: context);
    //   _tabController.removeListener(listener);
    // }
  }

  @override
  void dispose() {
    _scopedModelMainPageAdvertiser.disposeStreamControllerChalet();
    _scopedModelMainPageAdvertiser.disposeStreamControllerOffers();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModelMainPageAdvertiser>(
      model: _scopedModelMainPageAdvertiser,
      child: ScopedModelDescendant<ScopedModelMainPageAdvertiser>(builder:
          (BuildContext context, Widget child,
              ScopedModelMainPageAdvertiser model) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/background.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                ListView(
//                       physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        children: <Widget>[
                          ///=================================== Btn Add Category ==========================================//
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: InkWell(
                              onTap: () {
                                //RegisterAdvertiser
                                Navigator.push(context,
                                    SizeRoute(page: AddAnnouncementPage()));
                              },
                              child: Center(
                                child: Container(
                                  height: 60.0,
                                  padding: EdgeInsets.only(
                                      top: 12, bottom: 12, left: 12, right: 12),
                                  decoration: new BoxDecoration(
                                    color: Colors.transparent,
                                    border: new Border.all(
                                        color: Colors.white, width: 1.0),
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                  ),
                                  child: new Center(
                                    child: new Text(
                                      ' أضف بيانات عقارك',
                                      style: new TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'DinNextLight'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          //ظ--------------------------------------------------------------hint text ---------------------------------------------- /
                          Visibility(
                            visible: ScopedModelMainPageAdvertiser
                                .showhintAddCategory,
                            child: Column(
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    "ضف بيانات العقار لتتمكن",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "من استقبال الحجز",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          ///--------------------------------------------------------- Content Page -------------------------------------------//
                          Stack(
                            children: <Widget>[
                              Visibility(
                                visible: true,
                                child: Column(
                                  children: <Widget>[
                                    ///============================================= TabBar===============================================//
                                    TabBar(
                                        controller: _tabController,
                                        unselectedLabelColor:
                                            ColorsV.defaultColor,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: ColorsV.defaultColor),
                                        tabs: [
                                          Tab(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color:
                                                          ColorsV.defaultColor,
                                                      width: 1)),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: Text(
                                                    "إعلاناتك",
                                                    style: TextStyle(
                                                        fontSize: 19,
                                                        fontFamily:
                                                            'DinNextLight',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color:
                                                          ColorsV.defaultColor,
                                                      width: 1)),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: Text(
                                                    "العروض",
                                                    style: TextStyle(
                                                        fontSize: 19,
                                                        fontFamily:
                                                            'DinNextLight',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                    SizedBox(
                                      height: 15,
                                    ),

                                    ///---------------Content for TabBar---------------//
                                    Container(
                                      height: (ScopedModelMainPageAdvertiser
                                                  .numbersOfChalets
                                                  .toDouble() *
                                              165) +
                                          (ScopedModelMainPageAdvertiser
                                                  .numbersOfChalets *
                                              10),
                                      child: TabBarView(
                                          controller: _tabController,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          children: [
                                            AdvertiserChalets(),
                                            AdvertiserOffers(),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),

                              ///----------------------- Loading for Get Data -----------------------//
                              Visibility(
                                visible: ScopedModelMainPageAdvertiser
                                    .loadingHomePage,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: SpinKitCircle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

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
                            "الرئيسية",
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          )),
                          trailing: InkWell(
                              onTap: () {
                                _MainWidgetAdvertiser.functionOpenDrawer();
                              },
                              child: Image.asset(
                                "assets/icons/18.png",
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
      }),
    );
  }

  //---------------------------------Check permission------------------------------//
  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) {
      print('status: $status');
    });
    _geolocator
        .checkGeolocationPermissionStatus(
            locationPermission: GeolocationPermission.locationAlways)
        .then((status) {
      print('always status: $status');
    });
    _geolocator.checkGeolocationPermissionStatus(
        locationPermission: GeolocationPermission.locationWhenInUse)
      ..then((status) {
        print('whenInUse status: $status');
      });
  }
}
