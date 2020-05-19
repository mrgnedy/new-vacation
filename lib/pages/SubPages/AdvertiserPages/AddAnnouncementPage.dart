import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageAdvertiser.dart';
import 'package:vacatiion/pages/SubPages/Map/MapPage.dart';
import 'package:vacatiion/utility/Counter.dart';
import 'package:vacatiion/utility/RatingDialog.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';

//----------------------------- Add new Building -----------------------------//
class AddAnnouncementPage extends StatefulWidget {
  @override
  _AddAnnouncementPageState createState() => _AddAnnouncementPageState();
}

class _AddAnnouncementPageState extends State<AddAnnouncementPage> {
  ScopedModelMainPageAdvertiser get _scopedModelMainPageAdvertiser =>
      GetIt.I<ScopedModelMainPageAdvertiser>();

  static List<String> restStuff = [
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
  List<Map<String, dynamic>> additions = [];
  int deposit;
  //--------------------------------------chalet Name-----------------------------//
  TextEditingController _textFieldChaletName = TextEditingController();
  TextEditingController additionController = TextEditingController();
  TextEditingController _textFieldControllerNumberRooms =
      TextEditingController();
  TextEditingController __textFieldControllerAreaOfbuilding =
      TextEditingController();

  TextEditingController depoCtrl = TextEditingController();
  TextEditingController insuranceCtrl = TextEditingController();

  //--------------------------------------Check for Means of Comfortوسائل الراحه-----------------------------//
  // bool _value1 = false;
  // bool _value2 = false;
  // bool _value3 = false;
  // bool _value4 = false;
  // bool _value5 = false;
  // bool _value6 = false;
  // bool _value7 = false;
  // bool _value8 = false;
  // bool _value9 = false;
  // bool _value10 = false;
  // bool _value11 = false;
  // bool _value12 = false;
  // bool _value13 = false;
  // bool _value14 = false;

  void _value1Changed(bool value, int index) {
    setState(() {
      restVals[index] = value;
    });

    print("==============Test p=========${value}======");
  }

  // void _value2Changed(bool value) => setState(() => _value2 = value);
  // void _value3Changed(bool value) => setState(() => _value3 = value);
  // void _value4Changed(bool value) => setState(() => _value4 = value);
  // void _value5Changed(bool value) => setState(() => _value5 = value);
  // void _value6Changed(bool value) => setState(() => _value6 = value);
  // void _value7Changed(bool value) => setState(() => _value7 = value);
  // void _value8Changed(bool value) => setState(() => _value8 = value);
  // void _value9Changed(bool value) => setState(() => _value9 = value);
  // void _value10Changed(bool value) => setState(() => _value10 = value);
  // void _value11Changed(bool value) => setState(() => _value11 = value);
  // void _value12Changed(bool value) => setState(() => _value12 = value);

  //--------------------------------------list of Conditions-----------------------------//
  List<String> listConditions;
  List<String> conds;
  bool _valuec1 = true;
  bool _valuec2 = true;
  bool _valuec3 = false;
  //---------------------------list of restTools--------------------------------//
  List<String> restTools;
  //--------------------------------------Add Value Description-----------------------------//
  double _descriptionValue0 = 0;
  double _descriptionValue1 = 0;
  double _descriptionValue2 = 0;
  double _descriptionValue3 = 0;
  double _descriptionValue4 = 0;
  double _descriptionValue5 = 0;

  ///-----------permission--------------//
  Geolocator _geolocator;

  //--------Pick Image--------------//
  List<Asset> images = List<Asset>();
  List<List<int>> resultedList = [];
  List<String> resultedListNames = [];
  String _error = 'No Error Dectected';

  String imagePrevio;

  //----------------Data Source for Department----------------//
  final List<String> _itemsTypeBuildingDepartment =
      ['متاح للافراد و العائلات', "افراد", "عوائل فقط"].toList();

  //----------------Data Source for Kind----------------//
  final List<String> _itemsTypeKind =
      ['شاليه', 'منتجع', 'مخيم', 'منزل', "شقه", "استراحه"].toList();

  String _selectionTypeDepartment = "";
  String _selectionTypeKind = "";

  String StartDate = ' ';
  String endDate = ' ';

  String startTime = ' ';
  String endTime = ' ';
  String lat1;
  String long1;

  String locationName = "السعوديه";

  double percentage = 0.0;
  ProgressDialog pr;

  @override
  void initState() {
    print(restStuff.length);
    restVals = List.generate(restStuff.length, (_) => false);
    _selectionTypeDepartment = _itemsTypeBuildingDepartment.first;
    _selectionTypeKind = _itemsTypeKind.first;
    additions.addAll([
      {'name': 'المبيت', 'price': 0, 'add': false},
      {'name': 'تجهيز عرسان', 'price': 0, 'add': false},
      {'name': 'ملعب صابونى', 'price': 0, 'add': false}
    ]);

    _scopedModelMainPageAdvertiser.stopLoadingHomePage();

    _geolocator = Geolocator();
    checkPermission();

    listConditions = List<String>();
    restTools = List<String>();

    getNameLocation();
    super.initState();
  }

  Widget _buildAdditions() {
    return Directionality(
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
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    //-------------------------------header(Title)------------------------//
                    header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5, right: 15),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "اضافات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'DinNextRegular',
                                color: Color(0xff2E0063),
                                fontSize: 20,
                              ),
                            )),
                      ),
                    ),
                    // collapsed: Text("وصف وهوا مقفول", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    expanded: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        // height: 222,
                        color: Colors.grey.shade50,
                        child: Column(
                          // shrinkWrap: true,
                          children: List.generate(additions.length, (index) {
                            return InkWell(
                              onLongPress: () =>
                                  setState(() => additions.removeAt(index)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: additions[index]['add'],
                                        onChanged: (b) {
                                          setState(() {
                                            additions[index]['add'] = b;
                                            print(additions[index]);
                                          });
                                        },
                                        activeColor: ColorsV.defaultColor,
                                        checkColor: Colors.white,
                                      ),
                                      Container(
                                          width: 100,
                                          child: Text(additions[index]['name']))
                                    ],
                                  ),
                                  Container(
                                      width: 50,
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: TextField(
                                        onChanged: (s) {
                                          additions[index]['price'] =
                                              int.parse(s);
                                          print(additions[index]);
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                0, 8, 0, 8)),
                                      ))
                                ],
                              ),
                            );
                          })
                            ..add(Row(
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      additions.add({
                                        'name': additionController.text,
                                        'price': 0,
                                        'add': false,
                                      });
                                      additionController.text = '';
                                    });
                                  },
                                  icon: Icon(Icons.add),
                                ),
                                Container(
                                  width: 100,
                                  child: TextField(
                                    controller: additionController,
                                    decoration: InputDecoration(
                                        hintText: 'اضافات اخرى',
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorsV.defaultColor)),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(5)),
                                  ),
                                )
                              ],
                            )),
                        ),
                      ),
                    ),

                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
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
    );
  }

  //------------------------------ Controller For Days ---------------------------------//
  TextEditingController _textFieldControllerSaturday = TextEditingController();
  TextEditingController _textFieldControllerSunday = TextEditingController();
  TextEditingController _textFieldControllerMonday = TextEditingController();
  TextEditingController _textFieldControllerTuesday = TextEditingController();
  TextEditingController _textFieldControllerWednesday = TextEditingController();
  TextEditingController _textFieldControllerThursday = TextEditingController();
  TextEditingController _textFieldControllerFriday = TextEditingController();

  TextEditingController _textFieldControllerAbout = TextEditingController();
  //_textFieldControllerPriceNight
  //------------------------------ Controller For Price ---------------------------------//
  TextEditingController _textFieldControllerPriceNight =
      TextEditingController();
  double spinnerPrice = 0;

  //------------------------------Add new Conditions------------------------------//
  TextEditingController _textFieldAddNewConditions = TextEditingController();

  //-------------------------cancel---------------------------//
  String _radioValue; //Initial definition of radio button value
  String choicePolicy = "0";

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case '0':
          setState(() {
            choicePolicy = value;
          });
          break;
        case '1':
          setState(() {
            choicePolicy = value;
          });
          break;
        case '2':
          setState(() {
            choicePolicy = value;
          });
          break;
        default:
          choicePolicy = null;
      }
      debugPrint(choicePolicy); //Debug the choice in console
    });
  }

  @override
  void dispose() {
    _textFieldChaletName.dispose();
    //---------------------Days---------------------//
    _textFieldControllerSaturday.dispose();
    _textFieldControllerSunday.dispose();
    _textFieldControllerMonday.dispose();
    _textFieldControllerTuesday.dispose();
    _textFieldControllerWednesday.dispose();
    _textFieldControllerThursday.dispose();
    _textFieldControllerFriday.dispose();
    //-----------------------
    _textFieldControllerAbout.dispose();
    __textFieldControllerAreaOfbuilding.dispose();
    _textFieldControllerNumberRooms.dispose();
    _textFieldAddNewConditions.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Download);
    pr.style(
      message: 'تحميل البيانات...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    final dropdownMenuOptionsKind = _itemsTypeKind.map((String item) {
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

    final dropdownMenuOptionsDepartment =
        _itemsTypeBuildingDepartment.map((String item) {
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

    return ScopedModel<ScopedModelMainPageAdvertiser>(
      model: _scopedModelMainPageAdvertiser,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ScopedModelDescendant<ScopedModelMainPageAdvertiser>(builder:
              (BuildContext context, Widget child,
                  ScopedModelMainPageAdvertiser model) {
            return Stack(
              children: <Widget>[
                ///============================ Content Page ==========================//
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 85,
                      ),

                      ///==================================================  Choose multiple Image Chalet =============================================//
                      InkWell(
                        onTap: () {
                          print(
                              "======================Click==================");
                          loadAssets();
                        },
                        child: Card(
                          elevation: 4,
                          color: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 150,
                            child: Stack(
                              children: <Widget>[
                                //------------------------- Image Chalet- -----------------------//
                                imagePrevio == null
                                    ? Container(
                                        // padding: EdgeInsets.symmetric(horizontal: 5),
                                        width: double.infinity,
                                        height: 150,
                                        color: Colors.white,
                                      )
                                    : Container(
                                        // padding: EdgeInsets.symmetric(horizontal: 5),
                                        width: double.infinity,
                                        height: 150,
                                        child: Image.asset(
                                          imagePrevio,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                //-------------------Icon "Choose multiple Image"--------------------------------//
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 45,
                                    width: 53,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/icons/23.png"),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      ///===================================================== Price For Day-===================================================-//
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 5),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "قم بأضافه الاسعار المحدد لكل يوم من ايام الاسبوع تذكر بأمكانك التعديل عليها فى أى وقت",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'DinNextRegular',
                                color: Color(0xff2E0063),
                                fontSize: 20,
                              ),
                            )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  //---------LEFT Row----//
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 150,
                                      child: Column(
                                        children: <Widget>[
                                          //--------------Saturday----------//
                                          ListTile(
                                            leading: Container(
                                              width: 60,
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                controller:
                                                    _textFieldControllerSaturday,
                                                keyboardType:
                                                    TextInputType.number,
                                                //  textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                //--------------------------------===== decoration =====-----------------------------//
                                                decoration: InputDecoration(
                                                  //Add th Hint text here.
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8,
                                                          right: 17,
                                                          bottom: 9,
                                                          top: 9),
                                                  hintText: "450",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  //-----------------Decoration no Active Click---------------//
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: ColorsV
                                                                .defaultColor,
                                                            width: 0.0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  //----------------- Decoration Active Click ---------------//
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorsV
                                                            .defaultColor),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text('السبت'),
                                          ),
                                          //---------------Sunday-----------//
                                          ListTile(
                                            leading: Container(
                                              width: 60,
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                controller:
                                                    _textFieldControllerSunday,
                                                keyboardType:
                                                    TextInputType.number,
                                                //  textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                //--------------------------------===== decoration =====-----------------------------//
                                                decoration: InputDecoration(
                                                  //Add th Hint text here.
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8,
                                                          right: 17,
                                                          bottom: 9,
                                                          top: 9),
                                                  hintText: "500",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  //-----------------Decoration no Active Click---------------//
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: ColorsV
                                                                .defaultColor,
                                                            width: 0.0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  //----------------- Decoration Active Click ---------------//
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorsV
                                                            .defaultColor),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text('الاحد'),
                                          ),
                                          //---------------Monday----------//
                                          ListTile(
                                            leading: Container(
                                              width: 60,
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                controller:
                                                    _textFieldControllerMonday,
                                                keyboardType:
                                                    TextInputType.number,
                                                //  textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                //--------------------------------===== decoration =====-----------------------------//
                                                decoration: InputDecoration(
                                                  //Add th Hint text here.
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8,
                                                          right: 17,
                                                          bottom: 9,
                                                          top: 9),
                                                  hintText: "500",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  //-----------------Decoration no Active Click---------------//
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: ColorsV
                                                                .defaultColor,
                                                            width: 0.0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  //----------------- Decoration Active Click ---------------//
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorsV
                                                            .defaultColor),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text('الاثنين'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //------Right Right--------//
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: 155,
                                      child: Column(
                                        children: <Widget>[
                                          //------------------ Tuesday -------------------//
                                          ListTile(
                                            leading: Container(
                                              width: 60,
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                controller:
                                                    _textFieldControllerTuesday,
                                                keyboardType:
                                                    TextInputType.number,
                                                //  textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                //--------------------------------===== decoration =====-----------------------------//
                                                decoration: InputDecoration(
                                                  //Add th Hint text here.
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8,
                                                          right: 17,
                                                          bottom: 9,
                                                          top: 9),
                                                  hintText: "500",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  //-----------------Decoration no Active Click---------------//
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: ColorsV
                                                                .defaultColor,
                                                            width: 0.0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  //----------------- Decoration Active Click ---------------//
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorsV
                                                            .defaultColor),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text('الثلاثاء'),
                                          ),
                                          //------------------ Wednesday -------------------//
                                          ListTile(
                                            leading: Container(
                                              width: 60,
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                controller:
                                                    _textFieldControllerWednesday,
                                                keyboardType:
                                                    TextInputType.number,
                                                //  textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                //--------------------------------===== decoration =====-----------------------------//
                                                decoration: InputDecoration(
                                                  //Add th Hint text here.
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8,
                                                          right: 17,
                                                          bottom: 9,
                                                          top: 9),
                                                  hintText: "500",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  //-----------------Decoration no Active Click---------------//
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: ColorsV
                                                                .defaultColor,
                                                            width: 0.0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  //----------------- Decoration Active Click ---------------//
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorsV
                                                            .defaultColor),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text('الاربعاء'),
                                          ),
                                          //------------------ Thursday -------------------//
                                          ListTile(
                                            leading: Container(
                                              width: 60,
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                controller:
                                                    _textFieldControllerThursday,
                                                keyboardType:
                                                    TextInputType.number,
                                                //  textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                //--------------------------------===== decoration =====-----------------------------//
                                                decoration: InputDecoration(
                                                  //Add th Hint text here.
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8,
                                                          right: 17,
                                                          bottom: 9,
                                                          top: 9),
                                                  hintText: "500",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  //-----------------Decoration no Active Click---------------//
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: ColorsV
                                                                .defaultColor,
                                                            width: 0.0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  //----------------- Decoration Active Click ---------------//
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorsV
                                                            .defaultColor),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              'الخميس',
                                              softWrap: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //------------------ Friday --------------------//
                            Container(
                              width: 150,
                              child: ListTile(
                                leading: Container(
                                  width: 60,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: _textFieldControllerFriday,
                                    keyboardType: TextInputType.number,
                                    //  textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.black),
                                    //--------------------------------===== decoration =====-----------------------------//
                                    decoration: InputDecoration(
                                      //Add th Hint text here.
                                      contentPadding: EdgeInsets.only(
                                          left: 8,
                                          right: 17,
                                          bottom: 9,
                                          top: 9),
                                      hintText: "400",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      //-----------------Decoration no Active Click---------------//
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: ColorsV.defaultColor,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      //----------------- Decoration Active Click ---------------//
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorsV.defaultColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text('الجمعه'),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      /// ============================== ADDitions =========================//
                      _buildAdditions(),

                      ///====================================================== Chalet Name ============================================//
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
                                        //--------------Name --------//
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 2),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                width: 160,
                                                height: 50,
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                      _textFieldChaletName,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  //  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  //--------------------------------===== decoration =====-----------------------------//
                                                  decoration: InputDecoration(
                                                    //Add th Hint text here.
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 8,
                                                            right: 5,
                                                            bottom: 5,
                                                            top: 9),
                                                    hintText: "السعوديه",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    //-----------------Decoration no Active Click---------------//
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: ColorsV
                                                                  .defaultColor,
                                                              width: 0.0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),
                                                    //----------------- Decoration Active Click ---------------//
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorsV
                                                              .defaultColor),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // _buildAdditions(),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  //============== Additions=========================//

                                  //--------------Text Price of Night------------//
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 5, right: 15),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "اسم العقار",
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

                      ///============================================================== Location =============================================//
                      InkWell(
                        onTap: () {
                          //MapPage
//                    Navigator.push(context,
//                        SlideRightRoute(page: MapPage()));

                          // getNameLocation();
                          getNameLocationForUser();
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) => MyApp()),
//                            );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Card(
                            elevation: 3,
                            child: Container(
                                decoration: new BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Color(0xffE1E1E1)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          5.0) //    <--- border radius here
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
                                          image:
                                              AssetImage("assets/icons/20.png"),
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
                                      padding:
                                          EdgeInsets.only(bottom: 5, right: 15),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "${locationName}",
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
                      ),

                      ///=============================================================== Type of building Kind===============================================//
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
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
                                      buttonTheme:
                                          ButtonTheme.of(context).copyWith(
                                        alignedDropdown:
                                            true, //If false (the default), then the dropdown's menu will be wider than its button.
                                      )),
                                  child: DropdownButtonHideUnderline(
                                    // to hide the default underline of the dropdown button
                                    child: new DropdownButton<String>(
                                        iconEnabledColor: Color(0xff2E0063),
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
                                            _selectionTypeKind, // displaying the selected value
                                        items: dropdownMenuOptionsKind,
                                        onChanged: (s) {
                                          setState(() {
                                            _selectionTypeKind =
                                                s; // saving the selected value
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

                      ///================================================================== Type of Department ===========================================//
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
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
                                      buttonTheme:
                                          ButtonTheme.of(context).copyWith(
                                        alignedDropdown:
                                            true, //If false (the default), then the dropdown's menu will be wider than its button.
                                      )),
                                  child: DropdownButtonHideUnderline(
                                    // to hide the default underline of the dropdown button
                                    child: new DropdownButton<String>(
                                        iconEnabledColor: Color(0xff2E0063),
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
                                            _selectionTypeDepartment, // displaying the selected value
                                        items: dropdownMenuOptionsDepartment,
                                        onChanged: (s) {
                                          setState(() {
                                            _selectionTypeDepartment =
                                                s; // saving the selected value
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
                              _selectionTypeDepartment,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'DinNextRegular',
                                color: Color(0xff2E0063),
                                fontSize: 20,
                              ),
                            )),
                      ),

                      ///=================================================================== Area of building ===================================================//
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
                                              child: Container(
                                                width: 60,
                                                height: 50,
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                      __textFieldControllerAreaOfbuilding,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  //  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  //--------------------------------===== decoration =====-----------------------------//
                                                  decoration: InputDecoration(
                                                    //Add th Hint text here.
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 8,
                                                            right: 17,
                                                            bottom: 9,
                                                            top: 9),
                                                    hintText: "200",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    //-----------------Decoration no Active Click---------------//
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: ColorsV
                                                                  .defaultColor,
                                                              width: 0.0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),
                                                    //----------------- Decoration Active Click ---------------//
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorsV
                                                              .defaultColor),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
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
                                    padding:
                                        EdgeInsets.only(bottom: 5, right: 15),
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

                      ///==================================================================== Minimum number of nights ===========================================//
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
                                                "ريال سعودي",
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
                                              child: Container(
                                                width: 60,
                                                height: 50,
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                      _textFieldControllerPriceNight,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  //  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  //--------------------------------===== decoration =====-----------------------------//
                                                  decoration: InputDecoration(
                                                    //Add th Hint text here.
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 8,
                                                            right: 17,
                                                            bottom: 9,
                                                            top: 9),
                                                    hintText: "4",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    //-----------------Decoration no Active Click---------------//
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: ColorsV
                                                                  .defaultColor,
                                                              width: 0.0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),
                                                    //----------------- Decoration Active Click ---------------//
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorsV
                                                              .defaultColor),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
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
                                    padding:
                                        EdgeInsets.only(bottom: 5, right: 15),
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

                      ///========================================================= Out and Enter  ========================================//
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
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //o-------------------------- Out ----------------------//
                            Visibility(
                            visible: endDate != null,
                              // onTap: () {
                              //   // DatePicker.showDateTimePicker(context,
                              //   //     showTitleActions: true,
                              //   //     // minTime: DateTime(2019, 9, 5),
                              //   //     // maxTime: DateTime(3019, 6, 7),
                              //   //     onChanged: (date) {
                              //   //   //2019-10-25
                              //   // }, onConfirm: (date) {
                              //   //   setState(() {
                              //   //     endDate = date.year.toString() +
                              //   //         "-" +
                              //   //         date.month.toString() +
                              //   //         "-" +
                              //   //         date.day.toString();
                              //   //     endTime = date
                              //   //         .toString()
                              //   //         .split(' ')[1]
                              //   //         .split('.')[0];
                              //   //     print(
                              //   //         "=====================end ${endDate}");
                              //   //   });
                              //   //  print('====================confirm $date');
                              //   // },
                              //   // currentTime: DateTime.now(),
                              //   // locale: LocaleType.ar);
                              // },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2019),
                                          lastDate: DateTime(2100),
                                          // locale: Locale('ar', 'EG'),
                                        ).then((date) {
                                          setState(() {
                                            endDate = date.year.toString() +
                                                "-" +
                                                date.month.toString() +
                                                "-" +
                                                date.day.toString();
                                            endTime = date
                                                .toString()
                                                .split(' ')[1]
                                                .split('.')[0];
                                            print(
                                                "=====================end ${endDate}");
                                          });
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ///---------------   ---------------------//
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "الي",
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
                                                "متاح",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'DinNextRegular',
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '$endDate',
                                          style: TextStyle(
                                            color: ColorsV.defaultColor,
                                            fontSize: 16,
                                            fontFamily: 'DinNextRegular',
                                          ),
                                        ),
                                        Icon(Icons.date_range, color: ColorsV.defaultColor,)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        DatePicker.showTimePicker(context,
                                            onConfirm: (d) {
                                          endTime = TimeOfDay(
                                                  hour: d.hour,
                                                  minute: d.minute)
                                              .format(context);

                                          setState(() {});
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            '$endTime',
                                            style: TextStyle(
                                              color: ColorsV.defaultColor,
                                              fontSize: 16,
                                              fontFamily: 'DinNextRegular',
                                            ),
                                          ),
                                          Icon(Icons.access_time, color: ColorsV.defaultColor),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //--------------------------- Enter --------------------//
                            Visibility(
                              visible: StartDate != null,
                              // onTap: () {
                                // DatePicker.showTimePicker(context);
                                // DatePicker.showDateTimePicker(context,
                                //     showTitleActions: true,

                                //     // minTime: DateTime(2019, 9, 5),
                                //     // maxTime: DateTime(3019, 6, 7),
                                //     onChanged: (date) {
                                //   //2019-10-25
                                //   // setState(() {
                                //   //   StartDate = date.year.toString() +
                                //   //       "-" +
                                //   //       date.month.toString() +
                                //   //       "-" +
                                //   //       date.day.toString();
                                //   //   print(
                                //   //       "=====================TTT ${StartDate}");
                                //   // });
                                // }, onConfirm: (date) {
                                //   setState(() {
                                //     StartDate = date
                                //         .toString()
                                //         .split(' ')[0]
                                //         .replaceAll('/', '-');
                                //     startTime = date
                                //         .toString()
                                //         .split(' ')[1]
                                //         .split('.')[0];
                                //   });

                                //   print(
                                //       '====================confirm $startTime');
                                // },
                                //     currentTime: DateTime.now(),
                                //     locale: LocaleType.ar);
                              // },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2019),
                                          lastDate: DateTime(2100),
                                        ).then((date) {
                                          setState(() {
                                            StartDate = date
                                                .toString()
                                                .split(' ')[0]
                                                .replaceAll('/', '-');
                                            startTime = date
                                                .toString()
                                                .split(' ')[1]
                                                .split('.')[0];
                                          });

                                          print(
                                              '====================confirm $startTime');
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          ///---------------   ---------------------//
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "من",
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
                                                "متاح",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'DinNextRegular',
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '${StartDate ?? ' '}',
                                          style: TextStyle(
                                            color: ColorsV.defaultColor,
                                            fontSize: 16,
                                            fontFamily: 'DinNextRegular',
                                          ),
                                        ),
                                        Icon(Icons.date_range, color: ColorsV.defaultColor),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        DatePicker.showTimePicker(context,
                                            onConfirm: (d) {
                                          startTime = TimeOfDay(
                                                  hour: d.hour,
                                                  minute: d.minute)
                                              .format(context);
                                          setState(() {});
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            '${startTime ?? ' '}',
                                            style: TextStyle(
                                              color: ColorsV.defaultColor,
                                              fontSize: 16,
                                              fontFamily: 'DinNextRegular',
                                            ),
                                          ),
                                          Icon(Icons.access_time, color: ColorsV.defaultColor),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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

                      ///===================================================================== Description of building =============================================//
                      //-------------------Name of building-------------//
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
                                          ExpandablePanelHeaderAlignment.center,
                                      //-------------------------------header(Title)------------------------//
                                      header: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 5, right: 15),
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
                                      ),
                                      // collapsed: Text("وصف وهوا مقفول", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                      expanded: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          color: Colors.grey.shade50,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  //---------------Description 0------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        //      Text("2"),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image(
                                                          image: AssetImage(
                                                              "assets/icons/16.png"),
                                                          height: 30,
                                                          width: 30,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text(
                                                          "سرير مزدوج",
                                                          style: TextStyle(
                                                              color: ColorsV
                                                                  .defaultColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //------------------Counter----------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Counter(
                                                      initialValue:
                                                          _descriptionValue0,
                                                      minValue: 0,
                                                      maxValue: 200,
                                                      step: 1,
                                                      decimalPlaces: 1,
                                                      onChanged: (value) {
                                                        // get the latest value from here
                                                        setState(() {
                                                          _descriptionValue0 =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Stack(
                                                children: <Widget>[
                                                  //---------------Description------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        //      Text("2"),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image(
                                                          image: AssetImage(
                                                              "assets/icons/16.png"),
                                                          height: 30,
                                                          width: 30,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text(
                                                          "عدد الغرف",
                                                          style: TextStyle(
                                                              color: ColorsV
                                                                  .defaultColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //------------------Counter----------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Counter(
                                                      initialValue:
                                                          _descriptionValue1,
                                                      minValue: 0,
                                                      maxValue: 200,
                                                      step: 1,
                                                      decimalPlaces: 1,
                                                      onChanged: (value) {
                                                        // get the latest value from here
                                                        setState(() {
                                                          _descriptionValue1 =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Stack(
                                                children: <Widget>[
                                                  //---------------Description------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        //      Text("2"),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image(
                                                          image: AssetImage(
                                                              "assets/icons/16.png"),
                                                          height: 30,
                                                          width: 30,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text(
                                                          "سرير ��ردي",
                                                          style: TextStyle(
                                                              color: ColorsV
                                                                  .defaultColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //------------------Counter----------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Counter(
                                                      initialValue:
                                                          _descriptionValue2,
                                                      minValue: 0,
                                                      maxValue: 200,
                                                      step: 1,
                                                      decimalPlaces: 1,
                                                      onChanged: (value) {
                                                        // get the latest value from here
                                                        setState(() {
                                                          _descriptionValue2 =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Stack(
                                                children: <Widget>[
                                                  //---------------Description------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        //      Text("2"),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image(
                                                          image: AssetImage(
                                                              "assets/icons/16.png"),
                                                          height: 30,
                                                          width: 30,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text(
                                                          "المجالس الداخليه",
                                                          style: TextStyle(
                                                              color: ColorsV
                                                                  .defaultColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //------------------Counter----------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Counter(
                                                      initialValue:
                                                          _descriptionValue3,
                                                      minValue: 0,
                                                      maxValue: 200,
                                                      step: 1,
                                                      decimalPlaces: 1,
                                                      onChanged: (value) {
                                                        // get the latest value from here
                                                        setState(() {
                                                          _descriptionValue3 =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Stack(
                                                children: <Widget>[
                                                  //---------------Description------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        //      Text("2"),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image(
                                                          image: AssetImage(
                                                              "assets/icons/16.png"),
                                                          height: 30,
                                                          width: 30,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text(
                                                          "الجلسات الخارجيه",
                                                          style: TextStyle(
                                                              color: ColorsV
                                                                  .defaultColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //------------------Counter----------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Counter(
                                                      initialValue:
                                                          _descriptionValue4,
                                                      minValue: 0,
                                                      maxValue: 200,
                                                      step: 1,
                                                      decimalPlaces: 1,
                                                      onChanged: (value) {
                                                        // get the latest value from here
                                                        setState(() {
                                                          _descriptionValue4 =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Stack(
                                                children: <Widget>[
                                                  //---------------Description------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        //      Text("2"),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image(
                                                          image: AssetImage(
                                                              "assets/icons/16.png"),
                                                          height: 30,
                                                          width: 30,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        SizedBox(
                                                          width: 7,
                                                        ),
                                                        Text(
                                                          "دورات المياه",
                                                          style: TextStyle(
                                                              color: ColorsV
                                                                  .defaultColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //------------------Counter----------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Counter(
                                                      initialValue:
                                                          _descriptionValue5,
                                                      minValue: 0,
                                                      maxValue: 200,
                                                      step: 1,
                                                      decimalPlaces: 1,
                                                      onChanged: (value) {
                                                        // get the latest value from here
                                                        setState(() {
                                                          _descriptionValue5 =
                                                              value;
                                                        });
                                                      },
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
                                              left: 5, right: 5, bottom: 5),
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

                      ///====================================================================== About the property ====================================================//
                      Center(
                        child: Padding(
                          //Add padding around textfield
                          padding:
                              EdgeInsets.only(right: 18, left: 18, top: 18),
                          child: Card(
                            semanticContainer: false,
                            elevation: 2,
                            color: Colors.white, //Background for EditText
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextField(
                              maxLines: 8,
                              textAlign: TextAlign.right,
                              textInputAction: TextInputAction.next,
                              controller: _textFieldControllerAbout,
                              keyboardType: TextInputType.emailAddress,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Color(0xff1F1B62)),
                              maxLength: 250,
                              //--------------------------------=====decoration=====-----------------------------//
                              decoration: InputDecoration(
                                //Add th Hint text here.
                                contentPadding: EdgeInsets.only(
                                    left: 8, right: 17, bottom: 5, top: 5),
                                hintText: "عن الملكية",
                                hintStyle: TextStyle(
                                    color: ColorsV.defaultColor,
                                    fontFamily: 'DinNextMedium',
                                    fontSize: 19),
                                //-----------------Decoration no Active Click---------------//
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE6E6E6), width: 0.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                //-----------------Decoration Active Click---------------//
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffE4E4E4)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //================================================ وسائل الراحه meansComfort ===============================================/
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
                                          ExpandablePanelHeaderAlignment.center,
                                      //-------------------------------header(Title)------------------------//
                                      header: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 5, right: 15),
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
                                            ),
                                          ),
                                        ),
                                      ),
                                      // collapsed: Text("وصف وهوا مقفول", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                      expanded: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          color: Colors.grey.shade50,
                                          child: GridView.count(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 0,
                                            childAspectRatio: 2.5,
                                            padding: EdgeInsets.all(0),
                                            children: List.generate(
                                                restStuff.length, (index) {
                                              return Container(
                                                height: 50,
                                                width: 50,
                                                child: CheckboxListTile(
                                                  value: restVals[index],
                                                  onChanged: (b) =>
                                                      _value1Changed(b, index),
                                                  title: Text(restStuff[index]),
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  // subtitle: new Text('Subtitle'),
                                                  // secondary: new Icon(
                                                  //   Icons
                                                  //       .valu airline_seat_recline_extra,
                                                  //   color: ColorsV.defaultColor,
                                                  // ),
                                                  activeColor:
                                                      ColorsV.defaultColor,
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),

                                      builder: (_, collapsed, expanded) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5, bottom: 5),
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

                      ///======================================================================== N of WCعدد دورات المياه ================================================//
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
                                              child: Container(
                                                width: 60,
                                                height: 50,
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                      _textFieldControllerNumberRooms,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  //  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  //--------------------------------===== decoration =====-----------------------------//
                                                  decoration: InputDecoration(
                                                    //Add th Hint text here.
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 8,
                                                            right: 17,
                                                            bottom: 9,
                                                            top: 9),
                                                    hintText: "4",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    //-----------------Decoration no Active Click---------------//
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: ColorsV
                                                                  .defaultColor,
                                                              width: 0.0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),
                                                    //----------------- Decoration Active Click ---------------//
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorsV
                                                              .defaultColor),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
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
                                    padding:
                                        EdgeInsets.only(bottom: 5, right: 15),
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
                                          ExpandablePanelHeaderAlignment.center,
                                      //-------------------------------header(Title)------------------------//
                                      header: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 5, right: 15),
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
                                      ),
                                      // collapsed: Text("وصف وهوا مقفول", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                      expanded: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorsV.defaultColor,
                                              borderRadius:
                                                  new BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15))),
                                          //   color: ColorsV.defaultColor,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  //---------------Description------------//
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                    // width: 100
                                                    // ,
                                                    child: Text(
                                                      "دفع عربون مقداره",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'DinNextMedium',
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 60,
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: TextField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          inputFormatters: [
                                                            LengthLimitingTextInputFormatter(
                                                                2)
                                                          ],
                                                          controller: depoCtrl,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(),
                                                          decoration:
                                                              InputDecoration(
                                                            // contentPadding: EdgeInsets.only(bottom:5),

                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '%',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24),
                                                      ),
                                                    ],
                                                  ),
                                                  //------------------True  or False----------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _valuec2 = !_valuec2;
                                                        });
                                                      },
                                                      child: Container(
                                                        //decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: _valuec2
                                                              ? Icon(
                                                                  Icons.check,
                                                                  size: 30.0,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : Icon(
                                                                  Icons.cancel,
                                                                  size: 30.0,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  //---------------Description------------//
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                    // width: 100
                                                    // ,
                                                    child: Text(
                                                      "دفع تامين مقداره يدفع عند الوصول\n و يستر��ع عند الخروج في حاله سلامة المكان",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'DinNextMedium',
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 60,
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: TextField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          inputFormatters: [
                                                            LengthLimitingTextInputFormatter(
                                                                2)
                                                          ],
                                                          controller:
                                                              insuranceCtrl,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style: TextStyle(),
                                                          decoration:
                                                              InputDecoration(
                                                            // contentPadding: EdgeInsets.only(bottom:5),

                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '%',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24),
                                                      ),
                                                    ],
                                                  ),
                                                  //------------------True  or False----------------//
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _valuec3 = !_valuec3;
                                                        });
                                                      },
                                                      child: Container(
                                                        //decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: _valuec2
                                                              ? Icon(
                                                                  Icons.check,
                                                                  size: 30.0,
                                                                  color: Colors
                                                                      .green,
                                                                )
                                                              : Icon(
                                                                  Icons.cancel,
                                                                  size: 30.0,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]
                                              ..addAll(List.generate(
                                                  listConditions.length,
                                                  (index) {
                                                return Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                            listConditions[
                                                                index],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'DinNextMedium',
                                                                fontSize: 17)),
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.cancel,
                                                              size: 30.0,
                                                              color:
                                                                  Colors.red),
                                                          onPressed: () {
                                                            listConditions
                                                                .removeAt(
                                                                    index);
                                                            setState(() {});
                                                          },
                                                          color: Colors.red,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }))
                                              ..addAll(
                                                [
                                                  //--------------Condition Standart--------------//

                                                  //------------Add new Condition-------------//
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      //------btn add-------//
                                                      InkWell(
                                                        onTap: () {
                                                          _onAlertAddNewConditions(
                                                              context);
                                                        },
                                                        child: Container(
                                                          //decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Icon(
                                                                Icons
                                                                    .add_circle,
                                                                size: 35.0,
                                                                color: Colors
                                                                    .green,
                                                              )),
                                                        ),
                                                      ),
                                                      Text(
                                                        "اضافه",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'DinNextMedium',
                                                            fontSize: 17),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                          ),
                                        ),
                                      ),

                                      builder: (_, collapsed, expanded) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 0, right: 0, bottom: 0),
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

                      ///============================================================= Cancel ===================================================//
                      SizedBox(
                        height: 20,
                      ),

                      Center(
                        child: Text(
                          "اختر سياسه من سياسات الالغاء",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'DinNextRegular',
                              color: Color(0xff2E0063),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "سياسه الالغاء  المرنه",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'DinNextRegular',
                                    color: Color(0xff2E0063),
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Radio(
                                  value: '0',
                                  groupValue: _radioValue,
                                  onChanged: radioButtonChanges,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "سياسه الالغاء المعتدله",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'DinNextRegular',
                                    color: Color(0xff2E0063),
                                    fontSize: 20,
                                  ),
                                ),
                                Radio(
                                  value: '1',
                                  groupValue: _radioValue,
                                  onChanged: radioButtonChanges,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "سياسه الالغاء الصارمه",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'DinNextRegular',
                                    color: Color(0xff2E0063),
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Radio(
                                  value: '2',
                                  groupValue: _radioValue,
                                  onChanged: radioButtonChanges,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      ///===================================btn Done===============================//
                      InkWell(
                        onTap: () {
                          //model.uploadCategory(context: context,listImages: images);
                          print("---------------------");
                          addDataForChalets(
                              about: _textFieldControllerAbout.text,
                              chaletname: _textFieldChaletName.text,
                              kind: _selectionTypeKind,
                              departMintName:
                                  _selectionTypeDepartment.toString(),
                              nightNUmber: _textFieldControllerPriceNight.text,
                              NumberBathRooms:
                                  _textFieldControllerNumberRooms.text,
                              space: __textFieldControllerAreaOfbuilding.text,
                              cancelNumber: choicePolicy);
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
                                "تم",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'DinNextLight'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///================================ AppBar =================================//
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
                        //-------------Title----------//
                        ListTile(
                          leading: Container(
                            width: 28,
                            height: 28,
                          ),
                          title: Center(
                              child: Text(
                            "بيانات العقار",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'DinNextLight'),
                          )),
                          trailing: ClipOval(
                            child: Material(
                              color: Colors.transparent, // button color
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

                Visibility(
                  visible: ScopedModelMainPageAdvertiser.loadingHomePage,
                  child: Align(
                      alignment: Alignment.center,
                      child: SpinKitCircle(color: ColorsV.defaultColor)),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
  static Future<List<dynamic>> getImageListFromAssets(
      List<Asset> _images) async {
    List<Future<ByteData>> futures = [];
    _images.forEach((img) {
      futures.add(img.getByteData());
    });

    return Future.wait(futures).then((list) {
      // final list = await Future.wait(futures);
      final imgList = List.generate(list.length, (i) {
        print(list[i].buffer.asUint8List().cast<int>());
        return list[i].buffer.asUint8List().cast<int>();
      });
      final imageNames = List.generate(_images.length, (i) => _images[i].name);
      return [imgList, imageNames];
    });
  }
  //----------------Get List of Images----------------------//
  Future<void> loadAssets() async {
    print(
        "--------------------------------------------------------------------");
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 100,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#1F1B62",
          actionBarTitle: "الصور الخاصه بالشاليه",
          allViewTitle: "عدد الصور المطلوبه",
          useDetailsView: false,
          selectCircleStrokeColor: "#1F1B62",
          selectionLimitReachedText: "تم اختيار العدد المسموح به من الصور",
        ),
      );

      for (var r in resultList) {
        var t = await r.filePath;
        print(t);
      }
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
      print("----------------${images.length}-------------------");
      if (images.length < 6) {
        images[0]..then((onValue) {
          imagePrevio = onValue.. toString();
        });

        Utility.showToast("من فضلك اختر 6 صور للشاليه",
            context: context,
            duration: Toast.LENGTH_LONG,
            chooseColor: 1,
            gravity: Toast.BOTTOM);
      }
    });
  }
  

  //-----------------------Location----------------------------------//
  getNameLocation() async {
    //call this async method from whereever you need

    checkPermission();
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(
        "=========postion=======${position.latitude} : ${position.longitude}=====================");

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        "=========testM=======${first.featureName} : ${first.addressLine}=====================");

    setState(() {
      lat1 = position.latitude.toString();
      long1 = position.longitude.toString();
      locationName = first.featureName.toString();
    });
  }

  ///-----------------------Location----------------------------------//
  getNameLocationForUser() async {
    //call this async method from whereever you need
    var lat;
    var long;

    checkPermission();

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
            msg: "للحصول على الموقع الحالي يجب تفعيل الموقع الجغرافي");
      } else {
        print("-------------Lat${lat}");

        final coordinates = new Coordinates(
            double.parse(lat1 ?? lat), double.parse(long1 ?? long));
        var addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        print(
            "=========testM=======${first.featureName} : ${first.addressLine}=====================");

        String fullName = first.featureName + "-" + first.addressLine;

        setState(() {
          lat1 = lat;
          long1 = long;
          locationName = first.addressLine.toString();
        });
        print("=========${lat1}+${long1}-------lat1");
        Navigator.push(
          context,
          SlideRightRoute(
            page: MapTypes(
                lat: double.parse(lat1),
                long: double.parse(long1),
                namelocation: fullName),
          ),
        ).then((s) {
          setState(() {
            lat1 = s[0].toString();
            long1 = s[1].toString();
            locationName = s[2];
          });
        });
      }
    } else {
      print("--------------------not Active-----------");
      Utility.shawAlertDialogFailedLocation(
          context: context,
          title: "خدمات مطلوبه",
          msg: "للحصول على الموقع الحالي يجب تفعيل الموقع الجغرافي");
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

  Future addDataForChalets({
    String chaletname,
    String kind,
    String departMintName,
    String space,
    String nightNUmber,
    String about,
    String NumberBathRooms,
    String cancelNumber,
  }) async {
    print("================${cancelNumber}============");
    //-------------------------Chalets Name-------------------------//
    if (chaletname == null || chaletname.isEmpty) {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "من فضلك ادخل اسم الشاليه");
      return null;
    }
    if (space == null || space.isEmpty) {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "من فضلك ادخل مساحه العقار");
      return null;
    }
    final List addedList = additions
        .where(
          (addition) => addition['add'] == true,
        )
        .toList();
    Map<String, dynamic> detailsOfChalets = {
      "name": "${chaletname}",
      "startDate": "${StartDate}",
      "endDate": "${endDate}",

      "startTime": "$startTime",
      "endTime": "$endTime",

      "lat": "${lat1}",
      "lng": "${long1}",
      "kind": "${kind}",
      "department": "${departMintName}",
      "space": "${space}",
      "nightNumber": "${nightNUmber}",
      "about": "${about}",
      "bathrooms": "${NumberBathRooms}",
      "cancel": "${cancelNumber}",
      "days": [],
      "descriptions": [],
      "tools": [],
      "images": [],
      "conditions": [],
      "additions": addedList ?? [{}],
      "deposit": deposit ?? "" //---List String
    };

    if (lat1 == null || long1 == null) {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "اضغط على علامه الموقع لتحديد خطوط الطول و العرض");
      return null;
    }
    //----------------------------start ,end-----------------------//
    if (StartDate == null) {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "من فضلك ادخل بدايه الفتره المتاحه فيها الشاليه");
      return null;
    }
    if (endDate == null) {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "من فضلك ادخل نهايه الفتره المتاح فيها الشاليه");
      return null;
    }

    //------------------------Space---------------------------//

    //--------------------nightNumber-------------------//
    if (nightNUmber.isEmpty || nightNUmber == null) {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانا�� غير مكتمله",
          msg: "من فضلك ادخل سعر الليله");
      return null;
    }

    //---------------------bathrooms-----------------------//
    if (NumberBathRooms.isEmpty || NumberBathRooms == null) {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "من فضلك ادخل عدد دورات المياه");
      return null;
    }
    //---------------------شﻻخعف-----------------------//
    if (about.isEmpty || about == null) {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "من فضلك ادخل تفاصيل الملكيه");
      return null;
    }

    //-----------------------Images---------------------//
    if (images.length >= 6) {
      for (var s in images) {
        var pathImage = await s.filePath;

        var filename = await s.name;

        var gg = await MultipartFile.from((pathImage));

        detailsOfChalets["images"].add({"image": gg});
      }
    } else {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "من فضلك ادخل 6 صور");
      return null;
    }

    //-----------------------------------Days-------------------------------//
    if (_textFieldControllerSaturday.text.toString().isNotEmpty &&
        _textFieldControllerSunday.text.toString().isNotEmpty &&
        _textFieldControllerMonday.text.toString().isNotEmpty &&
        _textFieldControllerTuesday.text.toString().isNotEmpty &&
        _textFieldControllerWednesday.text.toString().isNotEmpty &&
        _textFieldControllerThursday.text.toString().isNotEmpty &&
        _textFieldControllerFriday.text.toString().isNotEmpty) {
      //--------------------------------  Days --------------------------//
      detailsOfChalets["days"]
          .add({'day': "0", 'price': '${_textFieldControllerSaturday.text}'});
      detailsOfChalets["days"]
          .add({'day': "1", 'price': '${_textFieldControllerSunday.text}'});
      detailsOfChalets["days"]
          .add({'day': "2", 'price': '${_textFieldControllerMonday.text}'});
      detailsOfChalets["days"]
          .add({'day': "3", 'price': '${_textFieldControllerTuesday.text}'});
      detailsOfChalets["days"]
          .add({'day': "4", 'price': '${_textFieldControllerWednesday.text}'});
      detailsOfChalets["days"]
          .add({'day': "5", 'price': '${_textFieldControllerThursday.text}'});
      detailsOfChalets["days"]
          .add({'day': "6", 'price': '${_textFieldControllerFriday.text}'});
    } else {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "من فضلك اكمل سعر اليوم");
      return null;
    }

    //------------------------------------- descriptions ------------------------//
    detailsOfChalets["descriptions"].add(
        {'key': "سرير مزدوج", 'value': '${_descriptionValue0}'}); //سرير مزدوج
    detailsOfChalets["descriptions"].add(
        {'key': "عدد الغرف", 'value': '${_descriptionValue1}'}); //عدد الغرف
    detailsOfChalets["descriptions"].add(
        {'key': "سرير فردي", 'value': '${_descriptionValue2}'}); //سرير فردي
    detailsOfChalets["descriptions"].add({
      'key': "مجالس داخليه",
      'value': '${_descriptionValue3}'
    }); //المجالس الداخليه
    detailsOfChalets["descriptions"].add({
      'key': "مجالس خارجيه",
      'value': '${_descriptionValue4}'
    }); //الجلسات الخارجيه
    detailsOfChalets["descriptions"].add({
      'key': "دورات المياه",
      'value': '${_descriptionValue5}'
    }); //دورات المياه

    //--------------------------------------Rest Tools---------------------------------//
    for (int i = 1; i <= restStuff.length; i++) {
      if (restVals[i - 1]) restTools.add('$i');
    }

    if (restTools.length > 0) {
      for (int i = 0; i < restTools.length; i++) {
        detailsOfChalets["tools"].add("${restTools[i]}");
      }
    } else {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "من فضلك اكمل وسائل الراحه");
      return null;
    }

    //------------------------Conditions--------------------//
    // if (_valuec1) {
    //   listConditions.add("دفع عربون مقداره 30% من قيمه الحجز");
    //   deposit = 30;
    // }

    if (_valuec2) {
      deposit = int.parse(depoCtrl.text ?? '0');
      detailsOfChalets['deposit'] = deposit;
      print(deposit);
      listConditions.insert(0, "دفع عربون مقداره  $deposit% من قيمه الحجز");
      listConditions.insert(1,
          "دفع تامين مقداره $insuranceCtrl% عند الوصول و يستترجع بعد الخروج في حال سلامةالمكان");
    }
    if (_valuec3) {
      int insurance = int.parse(insuranceCtrl.text ?? '0');
      //detailsOfChalets['insurance'] = deposit;
      listConditions.insert(1,
          "دفع تامين مقداره $insurance% عند الوصول و يستترجع بعد الخروج في حال سلامةالمكان");
    }
    // if (_valuec3) {
    //   listConditions.add("يوجد تأمين بمبلغ 500 ريال يدفع");
    // }
    if (listConditions.length > 0) {
      for (int i = 0; i < listConditions.length; i++) {
        detailsOfChalets["conditions"].add("${listConditions[i]}");
      }
    } else {
      Utility.shawAlertDialogFailed(
          context: context,
          title: "بيانات غير مكتمله",
          msg: "من فضلك اكمل الشروط");
      return null;
    }

    print("${detailsOfChalets.toString()}");
    // WaveProgress(180.0, Colors.blue, Colors.blueAccent,);
    //pr.show();
    return _scopedModelMainPageAdvertiser
        .uploadCategory(context: context, detailsOfChalets: detailsOfChalets)
        .then((_) {
      Navigator.of(context).pop();
    });
    //todo scoped model
  }

  // Alert custom content
  _onAlertAddNewConditions(context) {
    Alert(
        context: context,
        title: "شرط جديد",
        content: Column(
          children: <Widget>[
            TextField(
              controller: _textFieldAddNewConditions,
              decoration: InputDecoration(
                icon: Icon(Icons.add_circle),
                labelText: 'Username',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
              if (_textFieldAddNewConditions.text.toString().isEmpty ||
                  _textFieldAddNewConditions.text.toString() == null) {
                Utility.showToast("لم يتم ادخال شروط !!",
                    context: context,
                    duration: Toast.LENGTH_LONG,
                    chooseColor: 1,
                    gravity: Toast.BOTTOM);
              } else {
                listConditions.add(_textFieldAddNewConditions.text.toString());
                Utility.showToast("تم ادخال شرط جديد",
                    context: context,
                    duration: Toast.LENGTH_LONG,
                    chooseColor: 2,
                    gravity: Toast.BOTTOM);
              }
            },
            child: Text(
              "اضافه",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show().then((_) {
      setState(() {});
    });
  }
}

//----------------Model   For Radio--------------------//
class GroupModel {
  String text;
  int index;
  GroupModel({this.text, this.index});
}
