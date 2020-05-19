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
import 'package:vacatiion/ScopedModels/ScopedModelShowChalet.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart'
    as prefix0;
import 'package:vacatiion/model/ShowChaletModel.dart';
import 'package:vacatiion/model/ShowChaletModel.dart' as prefix1;
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart';
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart'
    as prefix2;
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:geocoder/geocoder.dart';

//روئيه الشاليه فى حاله انه غير مشترك فيه--------
class PageCoupon extends StatefulWidget {
  String chaletId;

  String chaletName;
  String totalPrice;
  String startDate;
  String endDate;

  PageCoupon(
      {this.chaletId,
      this.chaletName,
      this.endDate,
      this.startDate,
      this.totalPrice});

  @override
  _PageCouponState createState() => _PageCouponState();
}

class _PageCouponState extends State<PageCoupon> {
  ScopedModelShowChalet get _scopedModelShowChalet =>
      GetIt.I<ScopedModelShowChalet>();

  @override
  void initState() {
    // _scopedModelShowChalet.showLoadingPage();
    _scopedModelShowChalet.initialStreamControllerShowChalet();

    super.initState();
  }

  @override
  void dispose() {
    _scopedModelShowChalet.disposeStreamControllerShowChalet();
    super.dispose();
  }

  //---------------- Variable Inputs -----------------//
  final _formKeyInputs = GlobalKey<FormState>();

  bool checkValidate = false;

  void validateAndSave(BuildContext context) {
    final form = _formKeyInputs.currentState;

    if (form.validate()) {
//      //----------Shaw Loading------------//
//      _scopedModelUpdateUser.showLoading();
//      form.save();
//      _scopedModelUpdateUser.updateAccountUser(name: nameText,
//          phone: phoneText,
//          email: emailText,
//          context: context
      //   );
    } else {
      print('====================form is invalid=================');
    }
  }

  @override
  Widget build(BuildContext context) {
    String copoun;

    return ScopedModel<ScopedModelShowChalet>(
        model: _scopedModelShowChalet,
        child: Form(
          key: _formKeyInputs,
          child: Scaffold(
              body: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: ScopedModelDescendant<ScopedModelShowChalet>(builder:
                      (BuildContext context, Widget child,
                          ScopedModelShowChalet model) {
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
                                  height: 160,
                                ),
                                Center(
                                  child: Text(
                                    "${widget.chaletName}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Color(0xff2E0063),
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
//-------------------------------------Price------------------------//
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${widget.totalPrice}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "ريال سعودي",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
//-------------------------------------START DATE------------------------//
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${widget.startDate}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "يوم الدخول",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
//-------------------------------------END DATE------------------------//
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${widget.endDate}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "يوم المغادره",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 30,
                                ),

                                ///--------------------------------------Copune-------------------------------//
                                Center(
                                  child: Padding(
//Add padding around textfield
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50.0),
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
// autovalidate: checkValidate,
                                        validator: (value) {
                                          String message =
                                              Utility.validateName(value);

                                          return message;
                                        },
                                        onSaved: (String value) {
                                          copoun = value;
                                        },
                                        textInputAction: TextInputAction.next,
// controller: _textFieldControllerName,
                                        keyboardType: TextInputType.text,
                                        textDirection: TextDirection.rtl,
                                        style:
                                            TextStyle(color: Color(0xff1F1B62)),
//--------------------------------=====decoration=====-----------------------------//
                                        decoration: InputDecoration(
//Add th Hint text here.
                                          contentPadding: EdgeInsets.only(
                                              left: 8,
                                              right: 17,
                                              bottom: 12,
                                              top: 12),
                                          hintText: "كود الخصم",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
//-----------------Decoration no Active Click---------------//
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xff1F1B62),
                                                width: 0.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                          ),
//-----------------Decoration Active Click---------------//
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff1F1B62)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70),
                                  child: Container(
                                    width: 295,
                                    child: RaisedButton(
                                      onPressed: () {
                                        if(!mounted) return;
                                        setState(() {
                                          checkValidate = true;
                                        });
                                        validateAndSave(context);
                                      },
                                      padding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      color: Color(0xee201D5F),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text("تطبيق الكوبون",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontFamily: 'DinNextLight')),
                                      ),
                                    ),
                                  ),
                                ),

                                ///---------------------
                              ],
                            ),
                          ),
                        ),
                        //------------------------------ btn Next --------------------------//
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () async {
                              _formKeyInputs.currentState;
                              if (await confirmReservPolicy(
                                  'هل توافق على سياسة الحجز؟', 'تأكيد الحجز')) {
                                if (copoun == null) {
                                  _scopedModelShowChalet.addReservationChalet(
                                      context: context,
                                      chaletId: widget.chaletId,
                                      end: widget.endDate,
                                      Start: widget.startDate,
                                      coupon: "");
                                } else {
                                  _scopedModelShowChalet.addReservationChalet(
                                    
                                      context: context,
                                      chaletId: widget.chaletId,
                                      end: widget.endDate,
                                      Start: widget.startDate,
                                      coupon: copoun);
                                }
                              } else
                                Navigator.pop(context);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
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
                                    "التالى",
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
                                    "الحجز",
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

                        Visibility(
                          visible: ScopedModelShowChalet.loadingPageCopun,
                          child: Align(
                              alignment: Alignment.center,
                              child:
                                  SpinKitCircle(color: ColorsV.defaultColor)),
                        )
                      ],
                    );
                  }))),
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

  Future confirmReservPolicy(title, msg) {
    return Alert(
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
          onPressed: () {
            Navigator.pop(context, false);
            // return false;
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        ),
        DialogButton(
          child: Text(
            "تأكيد",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context,true);
            // return true;
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}
