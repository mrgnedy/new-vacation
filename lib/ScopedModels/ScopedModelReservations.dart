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


class ScopedModelReservations extends Model
{
  static bool loadingHomePage=false;
  static bool showhintAddCategory=true;
  static bool checkExistChalet=false;
  static int numbersOfChalets=3;
  static  bool checkExistOffers=false;
  ///-------------------------------------------------------- StreamController Reservations. -------------------------------------------//
  StreamController<AllChaletsAndOffersModel>  streamControllerReservations;
  //----------Start stream-----------//
  initialStreamChaletReservations()
  {
    streamControllerReservations=StreamController<AllChaletsAndOffersModel>.broadcast();
  }
  //---------------------- Input and Output Stream Get All Chalet ----------------------//
  Stream <AllChaletsAndOffersModel>  get outAllChaletReservations => streamControllerReservations.stream;
  Sink<AllChaletsAndOffersModel>  get inPutAllChaletReservations => streamControllerReservations.sink;
  //----------Stop stream----------//
  void disposeStreamChaletReservations()
  {
    streamControllerReservations.close();
  }





  //---------------------------الحاليه-------------------------------
  String _apiReservationsRecent=ApiUtilities.baseApi+ApiUtilities.apiReservationsRecent;
  //---------------------------قادمه-------------------------------
  String _apiReservationsFuture=ApiUtilities.baseApi+ApiUtilities.apiReservationsFuture;
  //---------------------------سابقه-------------------------------
  String _apiReservationPast=ApiUtilities.baseApi+ApiUtilities.apiReservationsPast;

  //---------------------------cancel-------------------------------
  String _apiReservationCancel=ApiUtilities.baseApi+ApiUtilities.cancelReservations;
  //----------------------------Add Comment---------------------------//
  String _apiAddComment=ApiUtilities.baseApi+ApiUtilities.addRatingComment;
  String _apiGetComment=ApiUtilities.baseApi+ApiUtilities.getRates;
  //---------------------------Report----------------------------------//
  String _apiReport=ApiUtilities.baseApi+ApiUtilities.reportReservations;


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

  //------------------Check Chalet available-------------//
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
  //--------------------Check Offers available------------------------//
  methdcheckExistOffers()
  {
    checkExistOffers=true;
  }
  methdcheckNotExistOffers()
  {
    checkExistOffers=false;
  }



  Future getAllReservationsRecent({BuildContext context}) async {
    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    final response =
    await http.get(_apiReservationsRecent+token, headers: {"Accept": "application/json"});

    var   data  =json.decode(response.body);

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      checkExistChaletV();

      inPutAllChaletReservations.add( AllChaletsAndOffersModel.fromJson(data));
      print("-------------------------Test----------------${AllChaletsAndOffersModel.fromJson(data).data.length}");
      stopLoadingHomePage();
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {
      checkNotExistChaletV();
      var error =AdvertiserNoChalets.fromJson(data);
      print("============================ Get All ChALET ${error.error[0]} =================");
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

  Future getAllReservationsPrevious({BuildContext context}) async {
    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    final response =
    await http.get(_apiReservationPast+token, headers: {"Accept": "application/json"});

    var   data  =json.decode(response.body);

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      checkExistChaletV();

      inPutAllChaletReservations.add( AllChaletsAndOffersModel.fromJson(data));
      print("-------------------------Test----------------${AllChaletsAndOffersModel.fromJson(data).data.length}");
      stopLoadingHomePage();
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {
      checkNotExistChaletV();
      var error =AdvertiserNoChalets.fromJson(data);
      print("============================ Get All ChALET ${error.error[0]} =================");
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

  Future getAllReservationsFuture({BuildContext context}) async {
    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    final response =
    await http.get(_apiReservationsFuture+token, headers: {"Accept": "application/json"});

    var   data  =json.decode(response.body);

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      checkExistChaletV();

      inPutAllChaletReservations.add( AllChaletsAndOffersModel.fromJson(data));
      print("-------------------------Test----------------${AllChaletsAndOffersModel.fromJson(data).data.length}");
      stopLoadingHomePage();
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {
      checkNotExistChaletV();
      var error =AdvertiserNoChalets.fromJson(data);
      print("============================ Get All ChALET ${error.error[0]} =================");
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

  Future cancelReservations({BuildContext context,String chaletId}) async{

    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);

    print("----chaletId-----${chaletId}");
    final response =
    await http.post(_apiReservationCancel+chaletId+"?token="+token, headers: {"Accept": "application/json"});

    var   data  =json.decode(response.body);

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      print("Successfull----------${data.toString()}");
      Utility.showToast("تم الغاء الحجز بنجاح",context: context,duration:Toast.LENGTH_LONG,chooseColor: 2,gravity:Toast.BOTTOM);

      stopLoadingHomePage();
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {
      Utility.showToast("لم يتم الغاء الحجز",context: context,duration:Toast.LENGTH_LONG,chooseColor: 1,gravity:Toast.BOTTOM);
      print("failed----------${data.toString()}");
      stopLoadingHomePage();
      //shawAlertDialog(context: context,msg:error.error[0]);
    }else
    {
      stopLoadingHomePage();
      print("=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
      print("${data}");
      if(data["message"]=="Unauthenticated.")
      {
        shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:data["message"]);

      }

    }




  }

  Future getComments(){
    
  }
  Future addCommentForChalet({BuildContext context,String chaletId ,int rate,String comment})async
  {
    showLoadingHomePage();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString(Utility.TOKEN);

    var uri = Uri.parse(_apiAddComment+token);
    var request = new http.MultipartRequest("POST", uri,);

    request.fields['chalet_id'] = "${chaletId}";
    request.fields['rate'] = "${rate}";
    request.fields['comment'] = "${comment}";

    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value)
    {

      //------------------- Receive Response in Server ---------------------//
      var data=json.decode(value);

      print("=========Add RateComment======"+value.toString()+"======================");

      ///========================================= Check the Status Response (SUCCESS)====================================//
      if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
      {
        stopLoadingHomePage();
        Utility.shawAlertDialogSuccess(context: context,title: "تقييم الشاليه",msg: "شكرا لابداء رايكم.");

      }
      ///========================================= Check Refer ====================================//
      else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
      {

        stopLoadingHomePage();
        Utility.shawAlertDialogFailed(context: context,title: "تقييم الشاليه",msg: "لقد قمت بتقييم هذا الشاليه من قبل");
      }
      else
      {
        stopLoadingHomePage();
        print("=========================== VERIFICATION_CODE Not compatible with schema =======================");

      }

    });





  }

  Future addReportingForChalet({BuildContext context,String chaletId ,String comment})async
   {
    showLoadingHomePage();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString(Utility.TOKEN);
    print("dddddd${chaletId}");
    var uri = Uri.parse(_apiReport+chaletId+"?token="+token);
    var request = new http.MultipartRequest("POST", uri,);

    request.fields['chalet_id'] = "${chaletId}";
    request.fields['text'] = "${comment}";

    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value)
    {

      //------------------- Receive Response in Server ---------------------//
      var data=json.decode(value);

      print("=========Add RateComment======"+value.toString()+"======================");

      ///========================================= Check the Status Response (SUCCESS)====================================//
      if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
      {
        stopLoadingHomePage();

        Utility.shawAlertDialogSuccess(context: context,title: "الاداره",msg: "تم ارسال الشكوي سيتم حلها فى اقرب وقت ");


      }
      ///========================================= Check Refer ====================================//
      else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
      {

        stopLoadingHomePage();
        Utility.showToast("حاول مره اخري",context: context,duration:Toast.LENGTH_LONG,chooseColor: 1,gravity:Toast.BOTTOM);
      }
      else
      {
        stopLoadingHomePage();
        print("=========================== VERIFICATION_CODE Not compatible with schema =======================");

      }

    });





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