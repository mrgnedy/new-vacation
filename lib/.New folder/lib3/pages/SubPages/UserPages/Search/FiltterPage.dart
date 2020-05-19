import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/ScopedModels/ScopedModeResultSearchPage.dart';
import 'package:vacatiion/ScopedModels/ScopedModelShowChalet.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart'
    as prefix0;
import 'package:vacatiion/model/ShowChaletModel.dart';
import 'package:vacatiion/model/ShowChaletModel.dart' as prefix1;
import 'package:vacatiion/pages/SubPages/UserPages/Search/SearchPage.dart';
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart';
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart'
    as prefix2;
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

//روئيه الشاليه فى حاله انه غير مشترك فيه --------
class FilterPageUser extends StatefulWidget {
  String chaletId;

  String chaletName;
  String totalPrice;
  String startDate;
  String endDate;

  FilterPageUser(
      {this.chaletId,
      this.chaletName,
      this.endDate,
      this.startDate,
      this.totalPrice});

  @override
  _FilterPageUserState createState() => _FilterPageUserState();
}

class _FilterPageUserState extends State<FilterPageUser> {
  ScopedModeResultSearchPage get _scopedModelResultSearchPage =>
      GetIt.I<ScopedModeResultSearchPage>();

  //--------------------------------------Check for Means of Comfortوسائل الراحه-----------------------------//
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;
  bool _value6 = false;
  bool _value7 = false;
  bool _value8 = false;
  bool _value9 = false;
  bool _value10 = false;
  bool _value11 = false;
  bool _value12 = false;
  List<String> restStuff = [
    'حارس', //Icons.accessibility
    'مدخل خاص',
    'مكيف',
    'واي فاي',
    'تلفاز',
    'غساله و تلاجه',
    'سينما',
    'ساونا',
    'ملعب كره',
    'نطيطه',
    'ملائم لذوي الحاجه',
    'كرسي مساج',
    'مصعد',
    'صندوق الأمانة',
    'وسادات وأغطيه أسرة إضافية',
    'مكواة ملابس',
    'مجفف الشعر',
    'مدفأة',
    'جاكوزي',
    'صابون ومناديل ورقية',
    '‏مناشف',
    'علاقة ملابس',
    'مطبخ',
    'أدوات مطبخ',
    'طاولة الطعام',
    'مايكروويف',
    'مكينة القهوة',
    'منطقة شواء',
    'غلاية',
    'فرن',
    'ثلاجة وغسالة',
    'سماعات',
    'العاب اطفال',
    'العاب مائية',
    'مسبح داخلي',
    'مسبح خارجي',
    'تدفئة مسبح',
    'نادي رياضي',
    'بلياردو',
    'ملعب تنس‏',
    'ملعب طائرة',
    'مسطحات خضراء',
    'طاولة هوكي'
  ];
  List<bool> restVals;

  void _value1Changed(bool value, index) {
    setState(() {
      restVals[index] = value;
    });

    print("==============Test p=========${value}======");
  }

  void _value2Changed(bool value) => setState(() => _value2 = value);
  void _value3Changed(bool value) => setState(() => _value3 = value);
  void _value4Changed(bool value) => setState(() => _value4 = value);
  void _value5Changed(bool value) => setState(() => _value5 = value);
  void _value6Changed(bool value) => setState(() => _value6 = value);
  void _value7Changed(bool value) => setState(() => _value7 = value);
  void _value8Changed(bool value) => setState(() => _value8 = value);
  void _value9Changed(bool value) => setState(() => _value9 = value);
  void _value10Changed(bool value) => setState(() => _value10 = value);
  void _value11Changed(bool value) => setState(() => _value11 = value);
  void _value12Changed(bool value) => setState(() => _value12 = value);

  TextEditingController _textFieldControllerbathrooms;
  TextEditingController _textFieldControllerNumberBeads;
  //----------------Data Source for DropdownButtonItem(Type Of Building)----------------//
  final List<String> _itemsTypeBuilding =
      ['شاليه', 'منتجع', 'مخيم', 'منزل', "شقه", "استراحه"].toList();
  final List<String> _itemsDepartment = ['افراد', 'عائلى'].toList();
  final List<String> _itemsBeds = ['سرير فردي', 'سرير زوجي'].toList();

  String _selectionTypeBuilding = "مخيم";
  String _selectionTypeKind = "عائلى"; //
  String _selectionTypeBeds = "سرير فردي";

  //---------------------------list of restTools--------------------------------//
  List<String> restTools;

  double _lowerValue = 80.0;
  double _upperValue = 500.0;

  @override
  void initState() {
    _textFieldControllerbathrooms = TextEditingController();
    _textFieldControllerNumberBeads = TextEditingController();
    listConditions = List<String>();
    restVals = List.generate((restStuff.length), (_) => false);
    restTools = List<String>();
    super.initState();
  }

  //-----------------------------------CONDITIONS--------------------------//
  //--------------------------------------list of Conditions-----------------------------//
  List<String> listConditions;
  bool _valuec1 = true;
  bool _valuec2 = false;
  bool _valuec3 = false;

  ///--------------------------------y-------------------

  @override
  void dispose() {
    _textFieldControllerbathrooms?.dispose();
    _textFieldControllerNumberBeads?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('FILTER PAGE HERE');
    final dropdownMenuOptions = _itemsTypeBuilding.map((String item) {
      return DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 15, bottom: 5.0, left: 5.0, top: 5.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: new Text(
                  item,
                  style: TextStyle(
                    color: Color(0xff2E0063),
                  ),
                )),
          ));
    }).toList();

    final dropdownMenuOptionsDepartment = _itemsDepartment.map((String item) {
      return DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 15, bottom: 5.0, left: 5.0, top: 5.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: new Text(
                  item,
                  style: TextStyle(
                    color: Color(0xff2E0063),
                  ),
                )),
          ));
    }).toList();
    final dropdownMenuOptionsBeds = _itemsBeds.map((String item) {
      return DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 15, bottom: 5.0, left: 5.0, top: 5.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: new Text(
                  item,
                  style: TextStyle(
                    color: Color(0xff2E0063),
                  ),
                )),
          ));
    }).toList();

    return ScopedModel<ScopedModeResultSearchPage>(
        model: _scopedModelResultSearchPage,
        child: Scaffold(
          body: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ScopedModelDescendant<ScopedModeResultSearchPage>(builder:
                  (BuildContext context, Widget child,
                      ScopedModeResultSearchPage model) {
                return Stack(
                  children: <Widget>[
                    ///================================== Content Page ============================//
                    Align(
                      alignment: Alignment.center,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 130,
                            ),

                            ///-------------------------Type of building(KInd)--------------------------//
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  height:
                                      55, //gives the height of the dropdown button
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, //gives the width of the dropdown button
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white),

                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Theme(
                                        data: Theme.of(context).copyWith(
                                            canvasColor: Colors.grey.shade300,
                                            // background color for the dropdown items
                                            buttonTheme: ButtonTheme.of(context)
                                                .copyWith(
                                              alignedDropdown:
                                                  true, //If false (the default), then the dropdown's menu will be wider than its button.
                                            )),
                                        child: DropdownButtonHideUnderline(
                                          // to hide the default underline of the dropdown button
                                          child: new DropdownButton<String>(
                                              iconEnabledColor:
                                                  Color(0xff2E0063),
                                              isExpanded: true,
                                              elevation: 0,
                                              underline: Container(),
                                              style: TextStyle(
                                                color: ColorsV.defaultColor,
                                                fontSize: 20,
                                              ),
                                              hint: Text(
                                                "نوع العقار",
                                                style: TextStyle(
                                                    color: Color(0xFF8B8B8B),
                                                    fontSize: 15),
                                              ),
                                              // setting hint
                                              value:
                                                  _selectionTypeBuilding, // displaying the selected value
                                              items: dropdownMenuOptions,
                                              onChanged: (s) {
                                                setState(() {
                                                  _selectionTypeBuilding =
                                                      s; // saving the selected value

                                                  print(
                                                      "نوع العقار ${_selectionTypeBuilding.toString()}");
                                                });
                                              }),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, top: 5),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _selectionTypeBuilding,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            ///-----------------------------department---------------------------------//
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  height:
                                      55, //gives the height of the dropdown button
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, //gives the width of the dropdown button
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white),

                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Theme(
                                        data: Theme.of(context).copyWith(
                                            canvasColor: Colors.grey.shade300,
                                            // background color for the dropdown items
                                            buttonTheme: ButtonTheme.of(context)
                                                .copyWith(
                                              alignedDropdown:
                                                  true, //If false (the default), then the dropdown's menu will be wider than its button.
                                            )),
                                        child: DropdownButtonHideUnderline(
                                          // to hide the default underline of the dropdown button
                                          child: new DropdownButton<String>(
                                              iconEnabledColor:
                                                  Color(0xff2E0063),
                                              isExpanded: true,
                                              elevation: 0,
                                              underline: Container(),
                                              style: TextStyle(
                                                color: ColorsV.defaultColor,
                                                fontSize: 20,
                                              ),
                                              hint: Text(
                                                "القسم",
                                                style: TextStyle(
                                                    color: Color(0xFF8B8B8B),
                                                    fontSize: 15),
                                              ),
                                              // setting hint
                                              value:
                                                  _selectionTypeKind, // displaying the selected value
                                              items:
                                                  dropdownMenuOptionsDepartment,
                                              onChanged: (s) {
                                                setState(() {
                                                  _selectionTypeKind =
                                                      s; // saving the selected value

                                                  print(
                                                      "القسم ${_selectionTypeKind.toString()}");
                                                });
                                              }),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, top: 5),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _selectionTypeKind,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),

                            ///------------------------- selection of a range of values price-------------------//
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                //------------------------------To-----------------------------//
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5, top: 5, right: 5),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${_upperValue}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Colors.blue,
                                          fontSize: 20,
                                        ),
                                      )),
                                ),
                                //-----Title----From
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5, top: 5, right: 18),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "الى",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 20,
                                        ),
                                      )),
                                ),
                                //---------------------------------From-----------------------//
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5, top: 5, right: 5),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${_lowerValue}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Colors.blue,
                                          fontSize: 20,
                                        ),
                                      )),
                                ),
                                //-----Title----From
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5, top: 5, right: 18),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "من",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 20,
                                        ),
                                      )),
                                ),
                                //-----Title----price
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5, top: 5, right: 18),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        ": السعر",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 24,
                                        ),
                                      )),
                                ),
                              ],
                            ),

                            frs.RangeSlider(
                              min: 0.0,
                              max: 1000.0,
                              lowerValue: _lowerValue,
                              upperValue: _upperValue,
                              divisions: 1000,
                              showValueIndicator: true,
                              valueIndicatorMaxDecimals: 1,
                              onChanged:
                                  (double newLowerValue, double newUpperValue) {
                                setState(() {
                                  _lowerValue = newLowerValue;
                                  _upperValue = newUpperValue;
                                });
                              },
                              onChangeStart: (double startLowerValue,
                                  double startUpperValue) {
                                print(
                                    'Started with values: $startLowerValue and $startUpperValue');
                              },
                              onChangeEnd:
                                  (double newLowerValue, double newUpperValue) {
                                print(
                                    'Ended with values: $newLowerValue and $newUpperValue');
                              },
                            ),

                            ///--------------------------------------------------Number bath Roms------------------------------///
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    decoration: new BoxDecoration(
                                      border: Border.all(
                                          width: 1.0, color: Color(0xffE1E1E1)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              5.0) //                 <--- border radius here
                                          ),
                                    ),
                                    height: 60,
                                    child: Stack(
                                      children: <Widget>[
                                        //---------------Price------------//
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: <Widget>[
                                              //---------------Price Type---------------//
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "غرفه",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'DinNextRegular',
                                                        color:
                                                            Color(0xff2E0063),
                                                        fontSize: 20,
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              //--------------Price Value--------//
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, left: 8),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      width: 100,
                                                      height: 50,
                                                      alignment:
                                                          Alignment.center,
                                                      child: TextField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller:
                                                            _textFieldControllerbathrooms,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        //  textDirection: TextDirection.rtl,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        //--------------------------------===== decoration =====-----------------------------//
                                                        decoration:
                                                            InputDecoration(
                                                          //Add th Hint text here.
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 8,
                                                                  right: 17,
                                                                  bottom: 9,
                                                                  top: 9),
                                                          hintText: "4",
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          //-----------------Decoration no Active Click---------------//
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: ColorsV
                                                                        .defaultColor,
                                                                    width: 0.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          //----------------- Decoration Active Click ---------------//
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: ColorsV
                                                                    .defaultColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                        ),
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
                                          padding: EdgeInsets.only(
                                              bottom: 5, right: 15),
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

                            ///--------------------------------------------------Number bead Roms------------------------------///
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    decoration: new BoxDecoration(
                                      border: Border.all(
                                          width: 1.0, color: Color(0xffE1E1E1)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              5.0) //                 <--- border radius here
                                          ),
                                    ),
                                    height: 60,
                                    child: Stack(
                                      children: <Widget>[
                                        //---------------Price------------//
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: <Widget>[
                                              //---------------Price Type---------------//
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "سرير",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'DinNextRegular',
                                                        color:
                                                            Color(0xff2E0063),
                                                        fontSize: 20,
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              //--------------Price Value--------//
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, left: 8),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      width: 100,
                                                      height: 50,
                                                      alignment:
                                                          Alignment.center,
                                                      child: TextField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller:
                                                            _textFieldControllerNumberBeads,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        //  textDirection: TextDirection.rtl,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        //--------------------------------===== decoration =====-----------------------------//
                                                        decoration:
                                                            InputDecoration(
                                                          //Add th Hint text here.
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 8,
                                                                  right: 17,
                                                                  bottom: 9,
                                                                  top: 9),
                                                          hintText: "4",
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          //-----------------Decoration no Active Click---------------//
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: ColorsV
                                                                        .defaultColor,
                                                                    width: 0.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          //----------------- Decoration Active Click ---------------//
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: ColorsV
                                                                    .defaultColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                        ),
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
                                          padding: EdgeInsets.only(
                                              bottom: 5, right: 15),
                                          child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "عدد السرائر",
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

                            ///-----------------------------------------------Beed-----------------------------------//
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  height:
                                      55, //gives the height of the dropdown button
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, //gives the width of the dropdown button
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white),

                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Theme(
                                        data: Theme.of(context).copyWith(
                                            canvasColor: Colors.grey.shade300,
                                            // background color for the dropdown items
                                            buttonTheme: ButtonTheme.of(context)
                                                .copyWith(
                                              alignedDropdown:
                                                  true, //If false (the default), then the dropdown's menu will be wider than its button.
                                            )),
                                        child: DropdownButtonHideUnderline(
                                          // to hide the default underline of the dropdown button
                                          child: new DropdownButton<String>(
                                              iconEnabledColor:
                                                  Color(0xff2E0063),
                                              isExpanded: true,
                                              elevation: 0,
                                              underline: Container(),
                                              style: TextStyle(
                                                color: ColorsV.defaultColor,
                                                fontSize: 20,
                                              ),
                                              hint: Text(
                                                "عدد السرائر",
                                                style: TextStyle(
                                                    color: Color(0xFF8B8B8B),
                                                    fontSize: 15),
                                              ),
                                              // setting hint
                                              value:
                                                  _selectionTypeBeds, // displaying the selected value
                                              items: dropdownMenuOptionsBeds,
                                              onChanged: (s) {
                                                setState(() {
                                                  _selectionTypeBeds =
                                                      s; // saving the selected value

                                                  print(
                                                      "عدد السرائر ${_selectionTypeBeds.toString()}");
                                                });
                                              }),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, top: 5),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _selectionTypeBeds,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            ///-----------------------------------------------
                            //-------------------------------وسائل الراحه meansComfort-----------------------//
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: ExpandableNotifier(
                                  child: ScrollOnExpand(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Card(
                                    elevation: 3,
                                    clipBehavior: Clip.antiAlias,
                                    //============================================= Content Expandable===================================//
                                    child: Column(
                                      children: <Widget>[
                                        //------------------------ Item for Content ----------------//
                                        ScrollOnExpand(
                                          scrollOnExpand: true,
                                          scrollOnCollapse: false,
                                          child: ExpandablePanel(
                                            tapHeaderToExpand: false,
                                            tapBodyToCollapse: false,
                                            headerAlignment:
                                                ExpandablePanelHeaderAlignment
                                                    .center,
                                            //-------------------------------header(Title)------------------------//
                                            header: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, right: 15),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "وسائل الراحه",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'DinNextRegular',
                                                        color:
                                                            Color(0xff2E0063),
                                                        fontSize: 20,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            // collapsed: Text("وصف وهوا مقفول", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                            expanded: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Container(
                                                // height: 100,
                                                // width: 100,
                                                color: Colors.grey.shade50,
                                                child: GridView.count(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  // crossAxisAlignment:
                                                  // CrossAxisAlignment.start,
                                                  shrinkWrap: true,
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 2.5,
                                                  children: List.generate(
                                                      restStuff.length,
                                                      (index) {
                                                    return Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: CheckboxListTile(
                                                        onChanged: (value) =>
                                                            _value1Changed(
                                                                value, index),
                                                        value: restVals[index],
                                                        title: Container(
                                                            child: Text(
                                                                restStuff[
                                                                    index])),
                                                        controlAffinity:
                                                            ListTileControlAffinity
                                                                .leading,
                                                                activeColor: ColorsV.defaultColor,
                                                      ),
                                                    );
                                                  }),
                                                ),
                                                // children: <Widget>[
                                                //   //------------------V1----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value1,
                                                //     onChanged: _value1Changed,
                                                //     title:
                                                //         new Text('كرسي مساج'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     // subtitle: new Text('Subtitle'),
                                                //     secondary: new Icon(
                                                //       Icons
                                                //           .airline_seat_recline_extra,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------V2----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value2,
                                                //     onChanged: _value2Changed,
                                                //     title: new Text(
                                                //         'ملائم لذوي الاعاقه'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     secondary: new Icon(
                                                //       Icons.accessible,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------V3----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value3,
                                                //     onChanged: _value3Changed,
                                                //     title: new Text('نطيطه'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     // subtitle: new Text('Subtitle'),
                                                //     secondary: new Icon(
                                                //       Icons.filter_tilt_shift,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------V4----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value4,
                                                //     onChanged: _value4Changed,
                                                //     title:
                                                //         new Text('ملعب كره'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     secondary: new Icon(
                                                //       Icons.texture,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------V5----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value5,
                                                //     onChanged: _value5Changed,
                                                //     title: new Text(
                                                //         'مسبح , ساونا'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     // subtitle: new Text('Subtitle'),
                                                //     secondary: new Icon(
                                                //       Icons.texture,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------V6----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value6,
                                                //     onChanged: _value6Changed,
                                                //     title: new Text('سينما'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     secondary: new Icon(
                                                //       Icons.satellite,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------V7----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value7,
                                                //     onChanged: _value7Changed,
                                                //     title: new Text(
                                                //         'غساله وثلاجه'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     // subtitle: new Text('Subtitle'),
                                                //     secondary: new Icon(
                                                //       Icons
                                                //           .chrome_reader_mode,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------V8----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value8,
                                                //     onChanged: _value8Changed,
                                                //     title: new Text('تلفاز'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     secondary: new Icon(
                                                //       Icons.satellite,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------V9----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value9,
                                                //     onChanged: _value9Changed,
                                                //     title:
                                                //         new Text('واي فاي'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     secondary: new Icon(
                                                //       Icons.wifi,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------V10----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value10,
                                                //     onChanged:
                                                //         _value10Changed,
                                                //     title: new Text('مكيف'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     secondary: new Icon(
                                                //       Icons
                                                //           .chrome_reader_mode,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------V11----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value11,
                                                //     onChanged:
                                                //         _value11Changed,
                                                //     title:
                                                //         new Text('مدخل خاص'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     secondary: new Icon(
                                                //       Icons.input,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                //   //------------------ V12 ----------------//
                                                //   new CheckboxListTile(
                                                //     value: _value12,
                                                //     onChanged:
                                                //         _value12Changed,
                                                //     title: new Text('حارس'),
                                                //     controlAffinity:
                                                //         ListTileControlAffinity
                                                //             .leading,
                                                //     secondary: new Icon(
                                                //       Icons.accessibility,
                                                //       color: ColorsV
                                                //           .defaultColor,
                                                //     ),
                                                //     activeColor:
                                                //         ColorsV.defaultColor,
                                                //   ),
                                                // ],
                                              ),
                                            ),

                                            builder: (_, collapsed, expanded) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    bottom: 5),
                                                child: Expandable(
                                                  collapsed: collapsed,
                                                  expanded: expanded,
                                                  crossFadePoint: 0,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            ///========================================================================= Rules Home ========================================================//
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: ExpandableNotifier(
                                  child: ScrollOnExpand(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Card(
                                    elevation: 3,
                                    clipBehavior: Clip.antiAlias,
                                    //============================================= Content Expandable===================================//
                                    child: Column(
                                      children: <Widget>[
                                        //------------------------ Item for Content ----------------//
                                        ScrollOnExpand(
                                          scrollOnExpand: true,
                                          scrollOnCollapse: false,
                                          child: ExpandablePanel(
                                            tapHeaderToExpand: false,
                                            tapBodyToCollapse: false,
                                            headerAlignment:
                                                ExpandablePanelHeaderAlignment
                                                    .center,
                                            //-------------------------------header(Title)------------------------//
                                            header: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, right: 15),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "شروط الحجز",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'DinNextRegular',
                                                        color:
                                                            Color(0xff2E0063),
                                                        fontSize: 20,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            // collapsed: Text("وصف وهوا مقفول", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                            expanded: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: ColorsV.defaultColor,
                                                    borderRadius:
                                                        new BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15))),
                                                //   color: ColorsV.defaultColor,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    //--------------Condition Standart--------------//
                                                    Stack(
                                                      children: <Widget>[
                                                        //---------------Description------------//
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              //      Text("2"),
                                                              SizedBox(
                                                                width: 7,
                                                              ),
                                                              Text(
                                                                "دفع عربون مقداره 50% من قيمه الحجز",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'DinNextMedium',
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        //------------------True  or False----------------//
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                _valuec1 =
                                                                    !_valuec1;
                                                              });
                                                            },
                                                            child: Container(
                                                              //decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: _valuec1
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                            30.0,
                                                                        color: Colors
                                                                            .green,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .cancel,
                                                                        size:
                                                                            30.0,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Stack(
                                                      children: <Widget>[
                                                        //---------------Description------------//
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              //      Text("2"),
                                                              SizedBox(
                                                                width: 7,
                                                              ),
                                                              Text(
                                                                "دفع عربون مقداره 30% من قيمه الحجز",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'DinNextMedium',
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        //------------------True  or False----------------//
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                _valuec2 =
                                                                    !_valuec2;
                                                              });
                                                            },
                                                            child: Container(
                                                              //decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: _valuec2
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                            30.0,
                                                                        color: Colors
                                                                            .green,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .cancel,
                                                                        size:
                                                                            30.0,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Stack(
                                                      children: <Widget>[
                                                        //---------------Description------------//
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              //      Text("2"),
                                                              SizedBox(
                                                                width: 7,
                                                              ),
                                                              Text(
                                                                "يوجد تأمين بمبلغ 500 ريال يدفع",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'DinNextMedium',
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        //------------------True  or False----------------//
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                _valuec3 =
                                                                    !_valuec3;
                                                              });
                                                            },
                                                            child: Container(
                                                              //decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: _valuec3
                                                                    ? Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                            30.0,
                                                                        color: Colors
                                                                            .green,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .cancel,
                                                                        size:
                                                                            30.0,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            builder: (_, collapsed, expanded) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 0),
                                                child: Expandable(
                                                  collapsed: collapsed,
                                                  expanded: expanded,
                                                  crossFadePoint: 0,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///----------------------------------------------- BTn Search ---------------------------------//
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          ///=========================== open RegisterAdvertiser ================================//

                          addDataForChalets();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
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
                                "بحث",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'DinNextLight'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                                "البحث ب",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
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
                                    onTap: () {
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

                    ///----------------------- Loading for Get Data -----------------------//
                    Visibility(
                      visible: ScopedModeResultSearchPage.loadingPage,
                      child: Align(
                          alignment: Alignment.center,
                          child: SpinKitCircle(color: ColorsV.defaultColor)),
                    ),
                  ],
                );
              })),
        ));
  }

  void shawAlertDialog(String msg, String title) {
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

  void addDataForChalets() async {
    listConditions = [];
    restTools = [];
    Map<String, dynamic> detailsOfChalets = {
      "kind": "${_selectionTypeKind}",
      "from": "${_lowerValue}",
      "to": "${_upperValue}",
      "beds": "${_textFieldControllerNumberBeads.text.toString()}",
      "bathrooms": "${_textFieldControllerbathrooms.text.toString()}",
      "department": "${_selectionTypeBuilding}",

      "tools": [],
      "conditions": [], //---List String
    };

    //---------------------bathrooms-----------------------//
//    if(_textFieldControllerbathrooms.text.toString().isEmpty||_textFieldControllerbathrooms.text.toString()==null)
//    {
//      Utility.shawAlertDialogFailed(context: context,title: "بيانات غير مكتمله",msg: "من فضلك ادخل عدد دورات المياه");
//      return null;
//    }
//    //----------------------------beads----------------------------//
//    if(_textFieldControllerNumberBeads.text.toString().isEmpty||_textFieldControllerNumberBeads.text.toString()==null)
//    {
//      Utility.shawAlertDialogFailed(context: context,title: "بيانات غير مكتمله",msg: "من فضلك ادخل عدد السرائر");
//      return null;
//    }

    //--------------------------------------Rest Tools---------------------------------//
    // if (_value1) {
    //   restTools.add("1");
    // }
    // if (_value2) {
    //   restTools.add("2");
    // }
    // if (_value3) {
    //   restTools.add("3");
    // }
    // if (_value4) {
    //   restTools.add("4");
    // }
    // if (_value5) {
    //   restTools.add("5");
    // }
    // if (_value6) {
    //   restTools.add("6");
    // }
    // if (_value7) {
    //   restTools.add("7");
    // }
    // if (_value8) {
    //   restTools.add("8");
    // }
    // if (_value9) {
    //   restTools.add("9");
    // }
    // if (_value10) {
    //   restTools.add("10");
    // }
    // if (_value11) {
    //   restTools.add("11");
    // }
    // if (_value12) {
    //   restTools.add("12");
    // }
    for (int i = 1; i <= restStuff.length; i++) {
      if (restVals[i - 1]) restTools.add('$i');
    }

    if (restTools.length > 0) {
      detailsOfChalets['tools'] = [];
      for (int i = 0; i < restTools.length; i++) {
        detailsOfChalets["tools"].add("${restTools[i]}");
      }
    }
//    else {
//      Utility.shawAlertDialogFailed(
//          context: context,
//          title: "بيانات غير مكتمله",
//          msg: "من فضلك اكمل وسائل الراحه");
//      return null;
//    }

    //------------------------Conditions--------------------//
    if (_valuec1) {
      listConditions.add("دفع عربون مقداره 50% من قيمه الحجز");
    }
    if (_valuec2) {
      listConditions.add("دفع عربون مقداره 30% من قيمه الحجز");
    }

    if (_valuec3) {
      listConditions.add("يوجد تأمين بمبلغ 500 ريال يدفع");
    }

    if (listConditions.length > 0) {
      detailsOfChalets['conditions'] = [];
      for (int i = 0; i < listConditions.length; i++) {
        detailsOfChalets["conditions"].add("${listConditions[i]}");
      }
    }
//    else {
//      Utility.shawAlertDialogFailed(
//          context: context,
//          title: "بيانات غير مكتمله",
//          msg: "من فضلك اكمل الشروط");
//      return null;
//    }
    if (restTools.isEmpty &&
        (_textFieldControllerbathrooms.text.toString().isEmpty ||
            _textFieldControllerbathrooms.text.toString() == null) &&
        (_textFieldControllerNumberBeads.text.toString().isEmpty ||
            _textFieldControllerNumberBeads.text.toString() == null)) {
      Utility.shawAlertDialogFailed(
          context: context, title: 'بيانات غير مكتمله');
      return null;
    }

    print("${detailsOfChalets.toString()}");
    // WaveProgress(180.0, Colors.blue, Colors.blueAccent,);
    //pr.show();
    _scopedModelResultSearchPage.getResultSearchByFilter(
        context: context, detailsOfChalets: detailsOfChalets);
  }
}
