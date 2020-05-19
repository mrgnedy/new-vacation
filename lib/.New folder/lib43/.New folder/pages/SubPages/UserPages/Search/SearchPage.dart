import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModeResultSearchPage.dart';
import 'package:vacatiion/ScopedModels/ScopedModelDrawerPages.dart';
import 'package:vacatiion/model/ModelDrawer.dart';
import 'package:vacatiion/model/NotificationsModel.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScopedModeResultSearchPage _modeResultSearchPage;

  TextEditingController _textEditingController;
  TextEditingController _textEditingControllerCity;
  TextEditingController _textEditDate;
  String date = '';
  Geolocator _geolocator;
  @override
  void initState() {
    _geolocator = Geolocator();
    _textEditingController = TextEditingController();
    _textEditingControllerCity = TextEditingController();
    _textEditDate = TextEditingController();
    _modeResultSearchPage = ScopedModeResultSearchPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModeResultSearchPage>(
      model: _modeResultSearchPage,
      child: Scaffold(body: ScopedModelDescendant<ScopedModeResultSearchPage>(
          builder: (BuildContext context, Widget child,
              ScopedModeResultSearchPage model) {
        return Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),

                ///---------------------------------------Search by locations---------------------------------//
                FlatButton(
                  padding:
                      EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
                  onPressed: () {
                    getNameLocationForUser();
                  },
                  textColor: Colors.white,
                  color: ColorsV.defaultColor,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white,
                  highlightColor: Colors.orangeAccent,
                  child: Text(' بحث ب الاقرب للموقع الجغرافي'),
                ),

                SizedBox(
                  height: 30,
                ),

                ///-------------------------------------Search by Name---------------------------------------//
                FlatButton(
                  padding:
                      EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
                  onPressed: () {
                    debugPrint('');

                    if (_textEditingController.text.toString() == null ||
                        _textEditingController.text.toString().isEmpty) {
                      Utility.shawAlertDialogFailed(
                          context: context,
                          title: "بيانات غير مكتمله",
                          msg: "من فضلك اكتب اسم الملكية المراد البحث عنها");
                    } else {
                      _modeResultSearchPage.getResultSearchByName(
                          context: context,
                          chaletName: _textEditingController.text.toString());
                    }
                  },
                  textColor: Colors.white,
                  color: ColorsV.defaultColor,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white,
                  highlightColor: Colors.orangeAccent,
                  child: Text(' بحث ب اسم الملكيه'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _textEditingController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: "اكتب اسم الملكيه",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: ColorsV.defaultColor),
                          enabledBorder: new OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: ColorsV.defaultColor)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      )),
                ),

                ///========================================================= City Name===================================================//
                FlatButton(
                  padding:
                      EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
                  onPressed: () {
                    print(_textEditingControllerCity.text);
                    debugPrint('');

                    if (_textEditingControllerCity.text.toString() == null ||
                        _textEditingControllerCity.text.toString().isEmpty) {
                      Utility.shawAlertDialogFailed(
                          context: context,
                          title: "بيانات غير مكتمله",
                          msg: "من فضلك اكتب اسم الملكية المراد البحث عنها");
                    } else {
                      _modeResultSearchPage.getResultSearchByCity(
                          context: context,
                          cityName: _textEditingControllerCity.text.toString());
                    }
                  },
                  textColor: Colors.white,
                  color: ColorsV.defaultColor,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white,
                  highlightColor: Colors.orangeAccent,
                  child: Text(' بحث ب اسم المدينه'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _textEditingControllerCity,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: "اكتب اسم المدينه",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: ColorsV.defaultColor),
                          enabledBorder: new OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: ColorsV.defaultColor)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      )),
                ),

                ///================================== Search By Date =================================//
                FlatButton(
                  padding:
                      EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
                  onPressed: () {
                    print(_textEditDate.text);
                    debugPrint('');

                    if (_textEditDate.text.toString() == null ||
                        _textEditDate.text.toString().isEmpty) {
                      Utility.shawAlertDialogFailed(
                          context: context,
                          title: "بيانات غير مكتمله",
                          msg: "من فضلك اكتب اسم الملكية المراد البحث عنها");
                    } else {
                      _modeResultSearchPage.getResultSearchByDate(
                          context: context,
                          date: _textEditDate.text.toString());
                    }
                  },
                  textColor: Colors.white,
                  color: ColorsV.defaultColor,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.white,
                  highlightColor: Colors.orangeAccent,
                  child: Text('بحث ب التاريخ'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 1 / 2,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: _textEditDate,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorsV.defaultColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange
                                )
                              ),
                              hintText: 'اضف تاريخ'),
                        ),
                      ),
                      IconButton(
                        iconSize: 45,
                        onPressed: getDate,
                        icon:
                         Image.asset("assets/icons/19.png",
                              height: 45, width: 45, fit: BoxFit.cover),

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
                        "بحث ب",
                        style: TextStyle(color: Colors.white, fontSize: 25),
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
            //--------------------------------------- Loading ------------------------------------//
            Visibility(
              visible: ScopedModeResultSearchPage.loadingPage,
              child: Align(
                  alignment: Alignment.center,
                  child: SpinKitCircle(color: ColorsV.defaultColor)),
            ),
          ],
        );
      })),
    );
  }

  getDate() async {
    return DatePicker.showDatePicker(context,
        locale: LocaleType.ar,
        minTime: DateTime(2000, 1, 1),
        maxTime: DateTime(3000, 1, 1),
        currentTime: DateTime.now(), onConfirm: (date) {
      setState(() {
        _textEditDate.text = date.toString().split(' ')[0];
      });
    });
  }

  //-----------------------Location----------------------------------//
  getNameLocationForUser() async {
    //call this async method from whereever you need
    var lat;
    var long;

    ///------------------------Check GPS is activated or deactivated-----------------//
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();

    if (isLocationEnabled) {
      print("--------------------Active-----------");

      checkPermission();
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(
          "=========postion=======${position.latitude} : ${position.longitude}=====================");

      lat = position.latitude.toString();
      long = position.longitude.toString();

      if (lat == null || long == null) {
        Utility.shawAlertDialogFailedLocation(
            context: context,
            title: "خدمات مطلوبه",
            msg: "للحصول على الشاليهات القريبه يجب تفعيل الموقع الجغرافي");
      } else {
        print("-------------Lat${lat}");
        _modeResultSearchPage.getResultSearchByLocation(
            context: context, lat: lat.toString(), long: long.toString());
      }
    } else {
      print("--------------------not Active-----------");
      Utility.shawAlertDialogFailedLocation(
          context: context,
          title: "خدمات مطلوبه",
          msg: "للحصول على الشاليهات القريبه يجب تفعيل الموقع الجغرافي");
    }
  }

  //---------------------------------Check permission------------------------------//
  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) {
      print('===============status: $status');
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
