import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:countdown/countdown.dart';
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
import 'package:vacatiion/model/SuccessReservationModel.dart';
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart';
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart'
as prefix2;
import 'package:vacatiion/pages/mainPages/MainPageUser.dart';
import 'package:vacatiion/utility/PickImage/ImagePickerHandler.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:geocoder/geocoder.dart';

import 'ReservationPaymentPageVisa.dart';



class ReservationPaymentPageBank extends StatefulWidget {

  SuccessReservationModel m;

  ReservationPaymentPageBank({this.m});



  @override
  _ReservationPaymentPageBankState createState() => _ReservationPaymentPageBankState();
}

class _ReservationPaymentPageBankState extends State<ReservationPaymentPageBank>with TickerProviderStateMixin,ImagePickerListener {

  ScopedModelShowChalet get _scopedModelShowChalet =>GetIt.I<ScopedModelShowChalet>();


  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  bool checkValidate=false;

  //---------------- Variable Inputs -----------------//
  final _formKeyInputs = GlobalKey<FormState>();

  void validateAndSave()
  {
    final form = _formKeyInputs.currentState;

    if(form.validate())
    {

      if(_image==null)
      {
            shawAlertDialog("من فضلك ادخل صوره ايصال الدفع","اكمل بيانات الدفع");
      }else
      {
        //----------Shaw Loading------------//
        //scopedModelVerification.showLoading();
        form.save();
        print ('=================== Form is valid Sucessful =====================');
          ///-------------------- send Data to Verification ---------------------//
        _scopedModelShowChalet.reservationsBill(context: context,
                                                chaletId: widget.m.data.reservationData.id.toString(),
                                                accountName:accountName,bankName: bankNameText ,imageFile: _image);
      }


    }
    else
    {
      print('====================form is invalid=================');
    }
  }

  CountDown cd ;
  var count=0;

  @override
  void initState() {
    // _scopedModelShowChalet.showLoadingPage();
    _scopedModelShowChalet.initialStreamControllerShowChalet();


    bool checkValidate=false;
    //-------------------------------------------For PickImage-------------------------//
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();
   //-----------------------------------------------
    cd = CountDown(Duration(hours: 1));
    cd.stream.listen((onData)
    {
      if(!mounted) return;
         setState(()
         {
           count=onData.inMinutes;

           if(count==1)
           {
             openMainPage();
           }
         });

    });

    super.initState();
  }


  @override
  void dispose()
  {
    _scopedModelShowChalet.disposeStreamControllerShowChalet();
    _controller.dispose();

    super.dispose();
  }



  String accountName='';
  String bankNameText='';


  @override
  Widget build(BuildContext context) {


    //  print("----------TesSta-------${widget.m.data.price}");

    return ScopedModel<ScopedModelShowChalet>(
        model: _scopedModelShowChalet,
        child:  Scaffold(
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
                          body: Form(
                            key: _formKeyInputs,
                            child: ListView(
                              children: <Widget>[

                                SizedBox(
                                  height: 100,
                                ),

                             //--------------------------- Timer -----------------------------//
                              ListTile(trailing:Text(
                                "حجزك الان بأنتظار السداد",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'DinNextRegular',
                                    color: Color(0xff2E0063),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ) ,
                                        title: Text(
                                          " ${count} ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'DinNextRegular',
                                              color: Colors.red,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15,bottom: 15),
                                  child: Align(
                                    alignment:Alignment.centerRight ,
                                    child: Text(
                                      "لديك مهله ساعه لتأكد فيها حجزك",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 22,
                                          fontWeight: FontWeight.normal),
                                    ),
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
                              //---------------------------------------  Text Help   ----------------------------------//
                                Padding(
                                  padding: const EdgeInsets.only(right: 15,top: 5),
                                  child: Align(
                                    alignment:Alignment.centerRight ,
                                    child: Text(
                                      "كيف تأكد حجزك ؟",
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 22,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5,top: 5,bottom: 15,left: 5),
                                  child: Align(
                                    alignment:Alignment.centerRight ,
                                    child: Text(
                                      "حول العربون 200 ريال سعودي على حساباتنا البنكيه عبي نموذج التأكيد الحواله وارسل ايصال العربون ",
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 22,
                                          fontWeight: FontWeight.normal),
                                    ),
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
                   //--------------------------------Payment1----------------------------------//
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15,top: 5),
                                    child: Text(
                                      "الدفع بواسطه ",
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: ()
                                  {
                                          //ReservationConfirmationPage
                                    Navigator.push(
                                        context, SizeRoute(page:  ReservationConfirmationPage()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15,top: 15,bottom: 15),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Chip(
                                        avatar: CircleAvatar(backgroundColor: Colors.green, child: Text('V', style: TextStyle(color: Colors.white))),
                                        label: Padding(
                                          padding: const EdgeInsets.only(right: 5,bottom: 2,left: 15,top: 2),
                                          child: Text('الدفع اون لاين',style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.normal),),
                                        ),
                                        backgroundColor: Color(0xff2E0063),
                                      ),
                                    ),
                                  ),
                                ),

                 //-------------------------------------------------------- Payment 2 ----------------------------------//
                               Padding(
                                  padding: EdgeInsets.only(right: 16,bottom: 5),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "الحسابات البنكيه",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                               //----------------Bank Name----------------------//
                                Text(
                                  "مؤسسه السحابه العاشره لتقنيه المعلومات",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal),
                                ),

                        //----------------Bank Number----------------------//
                                ListTile(trailing:Text(
                                  "رقم الحساب",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal),
                                ) ,
                                  title: Text(
                                    "${widget.m.data.accountNumber}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Colors.red,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),),

                        //-------------------Iban Number--------------------//
                                ListTile(trailing:Text(
                                  "رقم الايبان",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal),
                                ) ,
                                  title: Text(
                                    "${widget.m.data.iban}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Colors.red,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),),
                  ///=============================================================== Confirem ===============================================//
                                Padding(
                                  padding: EdgeInsets.only(right: 16,bottom: 5),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "تأكيد الحواله",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
            //----------------------------- Choose Image User ------------------------------//
                                InkWell(
                                  onTap: ()
                                  {
                                    imagePicker.showDialog(context);
                                  },
                                  child: Card(
                                    elevation: 3,
                                    child: _image==null?Container(
                                      height: 125,
                                      width: 200,
                                      padding: EdgeInsets.only(
                                          left: 38.0, right: 38.0, top: 35.0, bottom: 35.0),
                                      child: Image.asset("assets/icons/23.png"),
                                      decoration: BoxDecoration(
                                          border: new Border.all(
                                              color: Color(0xffD4D4D4),
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 5.0,
                                              // has the effect of softening the shadow
                                              spreadRadius: 1.0,
                                              // has the effect of extending the shadow
                                              offset: Offset(
                                                0.0, // horizontal, move right 10
                                                5.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          color: Colors.white),

                                    ):Image.file(_image,fit: BoxFit.cover,height: 150,width: 150,),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
            //----------------------------------
                                Center(
                                  child: Padding(
                                    //Add padding around textfield
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: TextFormField(
                                        autovalidate: checkValidate,
                                        validator: (value)
                                        {
                                          if(value.isEmpty)
                                          {
                                            return 'اسم البنك مطلوب';
                                          }

                                          return null;
                                        },
                                        onSaved: (String value)
                                        {
                                          bankNameText  = value;
                                        },

                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        textAlign: TextAlign.right,

                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(color: Color(0xff1F1B62)),

                                        //--------------------------------=====decoration=====-----------------------------//
                                        decoration: InputDecoration(
                                          //Add th Hint text here.
                                          contentPadding: EdgeInsets.only(
                                              left: 8, right: 17, bottom: 9, top: 9),
                                          hintText: "اسم البنك",
                                          hintStyle: TextStyle(color: Colors.grey),
                                          //-----------------Decoration no Active Click---------------//
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
                                            borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                          ),
                                          //-----------------Decoration Active Click---------------//
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                                //phone
                                SizedBox(
                                  height: 3,
                                ),
                                //-------------------------------TextField Iban Number--------------------//
                                Center(
                                  child: Padding(
                                    //Add padding around textfield
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: TextFormField(
                                        autovalidate: checkValidate,
                                        validator: (value)
                                        {
                                          if(value.isEmpty)
                                          {
                                            return 'رقم الايبان مطلوب';
                                          }

                                          return null;
                                        },
                                        onSaved: (String value)
                                        {
                                          accountName  = value;
                                        },

                                        textAlign: TextAlign.right,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,

                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(color: Color(0xff1F1B62)),

                                        //--------------------------------=====decoration=====-----------------------------//
                                        decoration: InputDecoration(
                                          //Add th Hint text here.
                                          contentPadding: EdgeInsets.only(
                                              left: 8, right: 17, bottom: 9, top: 9),
                                          hintText: "رقم الايبان",
                                          hintStyle: TextStyle(color: Colors.grey),
                                          //-----------------Decoration no Active Click---------------//
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
                                            borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                          ),
                                          //-----------------Decoration Active Click---------------//
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Padding(
                                  padding: EdgeInsets.only(right: 16,bottom: 5),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "تفاصيل الحجز",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DinNextRegular',
                                          color: Color(0xff2E0063),
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ListTile(trailing:Text(
                                  "تاريخ بدأ الحجز",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal),
                                ) ,
                                  title: Text(
                                    "${widget.m.data.reservationData.startDate}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Colors.green,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),),
                                ListTile(trailing:Text(
                                  "تاريخ نهايه الحجز",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal),
                                ) ,
                                  title: Text(
                                    "${widget.m.data.reservationData.endDate}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Colors.green,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),),
                                ListTile(trailing:Text(
                                  "السعر بعد الخصم",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal),
                                ) ,
                                  title: Text(
                                    "${widget.m.data.reservationData.price}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Colors.green,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),),

                                ListTile(trailing:Text(
                                  "الخصم",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal),
                                ) ,
                                  title: Text(
                                    "${widget.m.data.discount}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'DinNextRegular',
                                        color: Colors.green,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),),
                                SizedBox(
                                  height: 70,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      //------------------------------ btn Next --------------------------//
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {

                            Utility.checkInternetConnection(context).then((onValue)
                            {
                              if(onValue)
                              {
                                print("================UUU=====${Utility.checkInternetConnection(context)==false}======================");
                                setState(()
                                {
                                  checkValidate=true;
                                });
                                validateAndSave();

                              }
                            });
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
                                  "تأكيد الدفع",
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

                      Visibility(visible: ScopedModelShowChalet.loadingPage,
                        child: Align(
                            alignment: Alignment.center,
                            child: SpinKitCircle(color: ColorsV.defaultColor)),
                      )
                    ],
                  );
                }))));



  }
  @override
  userImage(File _image)
  {
    setState(()
    {
      this._image = _image;

      print("========path======${_image.path}==================");
    });
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

  void openMainPage()
  {

    return exit(0);
  }
}
