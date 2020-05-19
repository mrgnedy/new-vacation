import 'dart:async';

import 'package:toast/toast.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacatiion/model/Advertiser/UpdateAdvertiser.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';
import 'package:vacatiion/model/BannerModel.dart';
import 'package:vacatiion/model/ReservationsAdvertiser.dart';
import 'package:vacatiion/pages/SubPages/OffersPage.dart';
import 'package:vacatiion/utility/api_utilites.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';


class ScopedModelStatistics extends Model
{
  static bool loadingHomePage=false;
  static bool showhintAddCategory=true;
  static bool checkExistChalet=false;
  static int numbersOfChalets=3;
  static  bool checkExistOffers=false;
  ///-------------------------------------------------------- StreamController Reservations. -------------------------------------------//
  StreamController<ReservationsAdvertiser>  streamControllerReservations;
  //----------Start stream-----------//
  initialStreamChaletReservations()
  {
    streamControllerReservations=StreamController<ReservationsAdvertiser>.broadcast();
  }
  //---------------------- Input and Output Stream Get All Chalet ----------------------//
  Stream <ReservationsAdvertiser>  get outAllChaletReservations => streamControllerReservations.stream;
  Sink<ReservationsAdvertiser>  get inPutAllChaletReservations => streamControllerReservations.sink;
  //----------Stop stream----------//
  void disposeStreamChaletReservations()
  {
    streamControllerReservations.close();
  }


  int totalStatisticPrice= 0;
  set setTotal(s)=> totalStatisticPrice=s;


  //---------------------------Month-------------------------------//
  String _apiMonthReservations=ApiUtilities.baseApi+ApiUtilities.monthReservations;
  //---------------------------year-------------------------------//
  String _apiYearReservations=ApiUtilities.baseApi+ApiUtilities.yearReservations;


  //-------------- Loading Home PAGE ----------------//
  showLoadingHomePage()
  {
    loadingHomePage=true;
    notifyListeners();
  }
  stopLoadingHomePage()
  {
    loadingHomePage=false;
    notifyListeners();
  }

  //------------------ Check Chalet available -------------//
  checkExistChaletV()
  {
    checkExistChalet=true;
    notifyListeners();
  }
  checkNotExistChaletV()
  {
    checkExistChalet=false;
    notifyListeners();
  }
  //-------------------- Check Offers available ------------------------//
  methdcheckExistOffers()
  {
    checkExistOffers=true;
  }
  methdcheckNotExistOffers()
  {
    checkExistOffers=false;
  }



  Future getAllMonthReservationsRecent({BuildContext context}) async {
    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    final response =
    await http.get(_apiMonthReservations+token, headers: {"Accept": "application/json"});

    var   data  =json.decode(response.body);

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      checkExistChaletV();

      inPutAllChaletReservations.add(ReservationsAdvertiser.fromJson(data));
      print("------------------------- Test ---------------- ${ReservationsAdvertiser.fromJson(data)}------------------------");
      stopLoadingHomePage();
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {
      checkNotExistChaletV();

       stopLoadingHomePage();
      //------------Shaw Dialog ---------------//

    }else
    {
      stopLoadingHomePage();
      print("=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
      if(data["message"]=="Unauthenticated.")
      {
        shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:data["message"]);
      }

    }




  }

  Future getAllYearReservationsPrevious({BuildContext context}) async {

    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    final response =
    await http.get(_apiYearReservations+token, headers: {"Accept": "application/json"});

    var   data  =json.decode(response.body);

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      checkExistChaletV();

      inPutAllChaletReservations.add(ReservationsAdvertiser.fromJson(data));

      stopLoadingHomePage();
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {
      checkNotExistChaletV();
      var error =ReservationsAdvertiser.fromJson(data);

      stopLoadingHomePage();
      //------------Shaw Dialog ---------------//
      //shawAlertDialog(context: context,msg:error.error[0]);
    }else
    {
      stopLoadingHomePage();
      print("=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
      if(data["message"]=="Unauthenticated.")
      {
        shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:data["message"]);
      }

    }




  }







  void shawAlertDialogLogin({BuildContext context,String msg,String title})
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
            "تسجيل الدخول ",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()
          {
            //------------ Dismiss Dialog ------------//
            Navigator.pop(context);
            //------------- open First PAGE -------------//
            Utility.openLoginAccount(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
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
}