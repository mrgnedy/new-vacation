
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:vacatiion/ScopedModels/ScopedModeResultSearchPage.dart';
import 'package:vacatiion/ScopedModels/ScopedModelBannerUser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageAdvertiser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageUser.dart';
import 'package:vacatiion/model/BannerModel.dart';
import 'package:vacatiion/pages/SubPages/AdvertiserPages/account/PersonalAccountAdvertiser.dart';
import 'package:vacatiion/pages/SubPages/TopFivePage.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Search/FiltterPage.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Search/ResultSearchPage.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Search/SearchPage.dart';
import 'package:vacatiion/pages/SubPages/UserPages/account/PersonalAccountUser.dart';
import 'package:vacatiion/pages/SubPages/UserPages/offers_chalets/userChalet.dart';
import 'package:vacatiion/pages/SubPages/UserPages/offers_chalets/userOffers.dart';
import 'package:vacatiion/pages/SubPages/UserPages/FavoritesPage.dart';
import 'package:vacatiion/pages/mainPages/MainPageAdvertiser.dart';
import 'package:vacatiion/pages/mainPages/ReservationsPage.dart';
import 'package:vacatiion/utility/DrawerOnly.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';



////---------------------- NavigationBar --------------------------------------------//
class MainWidgetUser extends StatefulWidget
{
   @override
  _MainWidgetUser createState() => _MainWidgetUser();
}
class _MainWidgetUser extends State<MainWidgetUser> {



  ///---------------------------------------------------
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static Function functionOpenDrawer()
  {
    _scaffoldKey.currentState.openEndDrawer();
  }

  int selectedIndex = 0;


  bool loadinPro=false;
  //----------------AppBar----------------//
  final widgetOptions = [
    //----------------MainPage-------------------//
    MainPagesUser(),
    //----------------ReservationsPage الحجوزات-------------------//
    ReservationsPageAdvertiser(),
    //------------------------ المفضله-------------------------//
    FavoritePage(),
     //----------------IncomingPage الوارد-------------------//
     //    IncomingPage(),
     //----------------Personal Pageالشخصى -------------------//
    PersonalAccountUser(),
  ];

  @override
  Widget build(BuildContext context)
  {

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
                  //-----------------Account------------//
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
                            selectedIndex = 3;
                          });
                        },
                      ),
                    ),
                  ),
//                  //----------------Incomingالوارد --------//
//                  ClipOval(
//                    child: Material(
//                      color: Colors.transparent, // button color
//                      child: InkWell(
//                        splashColor: Colors.white, // inkwell color
//                        child: SizedBox(
//                            width: 45,
//                            height: 45,
//                            child: Image.asset(
//                              "assets/icons/2.png",
//                              width: 25,
//                              height: 25,
//                            )),
//                        onTap: () {
//                          setState(() {
//                            selectedIndex = 3;
//                          });
//                        },
//                      ),
//                    ),
//                  ),
                  //------------------- المفضله--------------------//
                  ClipOval(
                    child: Material(
                      color: Colors.transparent, // button color
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: SizedBox(
                            width: 45,
                            height: 45,
                            child: Image.asset(
                              "assets/icons/3.png",
                              width: 25,
                              height: 25,
                            )),
                        onTap: ()
                        {
                          setState(()
                          {
                            selectedIndex = 2;
                          });
                        },
                      ),
                    ),
                  ),
                  //---------------- Reservations الحجوزات --------//
                  ClipOval(
                    child: Material(
                      color: Colors.transparent, // button color
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: SizedBox(
                            width: 45,
                            height: 45,
                            child: Image.asset(
                              "assets/icons/4.png",
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
                  //------------------Home---------------//
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

  void onItemTapped(int index)
  {
    setState(() {
      selectedIndex = index;
    });
  }

}

////------------------------------------  الصفحه الرئيسيه للمستخدم -----------------------------
class MainPagesUser extends StatefulWidget
{
  @override
  _MainPagesUserState createState() => _MainPagesUserState();
}

class _MainPagesUserState extends State<MainPagesUser> {


  ///-----------permission--------------//
  Geolocator _geolocator;

  ///--------------------------------------------------
  TextEditingController _textFieldController = TextEditingController();
  int ratingV;
  bool isLoading=false;

  ScopedModelMainPageUser get _scopedModelMainPageUser=> GetIt.I<ScopedModelMainPageUser>();
  ScopedModeResultSearchPage _modeResultSearchPage=ScopedModeResultSearchPage();

  @override
  void initState()
  {
      _geolocator = Geolocator();

    _scopedModelMainPageUser.stopLoadingHomePage();
    _scopedModelMainPageUser.getAllChaletUser(context: context);
    super.initState();
  }

  @override
  void dispose()
  {
    _scopedModelMainPageUser.disposeStreamControllerChalet();
    _scopedModelMainPageUser.disposeStreamControllerOffers();

    super.dispose();
  }


  @override
  Widget build(BuildContext context)
  {

    return ScopedModel<ScopedModelMainPageUser>(
      model: _scopedModelMainPageUser,
      child: ScopedModelDescendant<ScopedModelMainPageUser>(
        builder:(BuildContext context, Widget child, ScopedModelMainPageUser model)
      {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background/background.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: DefaultTabController(
              length: 3,
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>
                    [
                      Padding(
                        padding: const EdgeInsets.only(top: 135),
                        child: Column(
                          children: <Widget>
                          [
                            SizedBox(),
                            //=============================== Slider =============================//
                            Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: CarouselSlider()),
                            SizedBox(height: 15,),
                            ///============================================= TabBar===============================================//
                            TabBar(
                                unselectedLabelColor: ColorsV.defaultColor,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:ColorsV.defaultColor),
                                tabs: [
                                  Tab(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: ColorsV.defaultColor, width: 1)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Text("الكل",style: TextStyle(fontSize: 19,fontFamily: 'DinNextLight',color: Colors.white),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: ColorsV.defaultColor, width: 1)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Text("العروض",style: TextStyle(fontSize: 19,fontFamily: 'DinNextLight',color: Colors.white),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: ColorsV.defaultColor, width: 1)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Text("المميز",style: TextStyle(fontSize: 19,fontFamily: 'DinNextLight',color: Colors.white),),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 2,
                            ),
                            ///---------------Content for TabBar---------------//
                            Container(
                              height: (ScopedModelMainPageUser.numbersOfChalets.toDouble()*165) + (ScopedModelMainPageUser.numbersOfChalets*10),
                              child: TabBarView(children: [
                                UserChalets(),
                                UserOffers(),
                                TopFivePage(),
                              ]),
                            ),



                ],),
                      ),

                    ],
                  ),
                  ///----------------------- Loading for Get Data -----------------------//
                  Visibility (
                    visible: ScopedModelMainPageUser.loadingHomePage,
                    child: Align(
                        alignment: Alignment.center,
                        child: SpinKitCircle(color: Colors.white)),
                  ),
                  ///=========================================================== AppBar =====================================================//
                  Align(
                    alignment: Alignment.topCenter,
                    child:Container(
                      height: 150,
                      decoration: BoxDecoration(image: DecorationImage(
                        image: AssetImage("assets/appbar/background_app_bar.png"),fit: BoxFit.fill,)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 25,),
                          //------------------------------- Icon Filter ----------------------------//
                          ListTile(
                            leading: InkWell(
                                onTap: ()
                                {
                                  Navigator.push(
                                      context, SizeRoute(page:  FilterPageUser()));
                                },
                                child: Image.asset(
                                  "assets/icons/12.png",
                                  width: 28,
                                  height: 28,
                                )),
                            title: Center(
                                child: Text(
                                  "الرئيسية",
                                  style: TextStyle(color: Colors.white, fontSize: 25),
                                )),

                            //-------------------------------------Icon Menu ------------------------------------//
                            trailing: InkWell(
                                onTap: ()
                                {
                                  _MainWidgetUser.functionOpenDrawer();
                                },
                                child: Image.asset(
                                  "assets/icons/18.png",
                                  width: 25,
                                  height: 25,
                                )),
                          ),
                          //--------------------------------------- Search -------------------------------------//
                          SizedBox(
                            height: 6,
                          ),

                          ///-----------------Search----------------------//
                         InkWell(
                           onTap: ()
                           {
                             Navigator.push(
                                 context, SizeRoute(page: SearchPage()));
                           },
                           child: Center(child:  Chip(
                             avatar: CircleAvatar(
                                 backgroundColor: ColorsV.defaultColor, child: Text('C', style: TextStyle(color: Colors.white))),
                             label: Padding(
                               padding: const EdgeInsets.only(right: 20,left: 70,top: 8,bottom: 8),
                               child: Text('ابحث بأسم المدينه او الموقع الجغرافي'),
                             ),
                             backgroundColor: Colors.white,
                           ),),
                         )


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },)

    );
  }










  //---------------------------------Check permission------------------------------//
  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) { print('status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationAlways).then((status) { print('always status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationWhenInUse)..then((status) { print('whenInUse status: $status'); });
  }

}
///-------------------------------------------------------- CarouselSlider -------------------------------------------//
class CarouselSlider extends StatefulWidget {




  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  final List<String> imgList = [
      'https://www.gstatic.com/webp/gallery/1.jpg',
      'https://www.gstatic.com/webp/gallery/1.jpg',
  ];


  ScopedModelBannerUser _bannerUser=ScopedModelBannerUser();


  @override
  void initState()
  {
      _bannerUser.showLoadingHomePage();
      _bannerUser.initialStreamControllerBanner();
      _bannerUser.getAllBanners(context: context);
  }


  @override
  void dispose() {
    _bannerUser.disposeStreamControllerBanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModelBannerUser>(
      model: _bannerUser,
      child: Scaffold(body:
          ScopedModelDescendant<ScopedModelBannerUser>(
          builder:(BuildContext context, Widget child, ScopedModelBannerUser model)
          {

           return StreamBuilder<BannerModel>(
                stream: model.outAllImagesBanner,
                builder: ( context, snapshot)
                {
                  switch (snapshot.connectionState)
                  {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Swiper(
                        itemBuilder: (BuildContext context, int index)
                        {
                          return new Image.network(imgList[index],fit: BoxFit.fill,);

                        },
                        indicatorLayout: PageIndicatorLayout.COLOR,
                        autoplay: true,
                        // viewportFraction: 0.8,
                        itemCount: imgList.length,
                        pagination: new SwiperPagination(),
                        //-------Config Arrow-------//
                        control: new SwiperControl(
                          color: ColorsV.defaultColor,
                          padding: EdgeInsets.all(10),
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return Center(child: new Text('Error: ${snapshot.error}',style: TextStyle(color: Colors.indigo),));
                      else
                        return  Swiper(
                          itemBuilder: (BuildContext context, int index)
                          {
                            return new Image.network("http://vacatiion.net/public/images/"+snapshot.data.data[index].image,fit: BoxFit.fill,);

                          },
                          indicatorLayout: PageIndicatorLayout.COLOR,
                          autoplay: true,
                          // viewportFraction: 0.8,
                          itemCount: snapshot.data.data.length,
                          pagination: new SwiperPagination(),
                          //-------Config Arrow-------//
                          control: new SwiperControl(
                            color: ColorsV.defaultColor,
                            padding: EdgeInsets.all(10),
                          ),
                        );
                  }
                }
            );




          }),)



    );
  }
}



