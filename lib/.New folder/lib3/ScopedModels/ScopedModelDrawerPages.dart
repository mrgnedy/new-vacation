import 'dart:async';

import 'package:dio/dio.dart';
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
import 'package:vacatiion/model/ModelDrawer.dart';
import 'package:vacatiion/model/NotificationsModel.dart';
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


class ScopedModelDrawerPages extends Model
{


  ///-------------------------------------------------------- StreamController Chalet -------------------------------------------//
  StreamController<NotificationsModel>  streamControllerNotifications;
  //----------Start stream-----------//
  initialStreamControllerBanner()
  {
    streamControllerNotifications=StreamController<NotificationsModel>.broadcast();
  }
  //---------------------- Input and Output Stream Get All Chalet ----------------------//
  Stream <NotificationsModel>  get outAllNotifications => streamControllerNotifications.stream;
  Sink<NotificationsModel>  get inPutAllNotifications => streamControllerNotifications.sink;
  //----------Stop stream----------//
  void disposeStreamControllerBanner()
  {
    streamControllerNotifications.close();
  }




  ModelDrawer _modelDrawer;
  NotificationsModel notificationsModel;

  bool loadingHomePage=false;
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



  String _apiGetTerms=ApiUtilities.baseApi+ApiUtilities.termsApi;
  String _apiPolicy=ApiUtilities.baseApi+ApiUtilities.apiUsePolicy;
  String _apiAbout=ApiUtilities.baseApi+ApiUtilities.apiAboutUs;
  String _apiContact=ApiUtilities.baseApi+ApiUtilities.apiContact;
  String _apiNotifications=ApiUtilities.baseApi+ApiUtilities.apiNotifications;


  Future<ModelDrawer> getTermsAndConditions({BuildContext context}) async {


    Response response;
    Dio dio = new Dio();
    response = await dio.get(_apiGetTerms);
    print(response.data.toString());

    //final response =await http.get(_apiGetTerms, headers: {"Accept": "application/json"});

   print("===============${response.data["status"]}=================");

     //  var   data  = jsonDecode(response.data);


    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(response.data["status"]==Utility.VERIFICATION_CODE_SUCCESS)
    {
      print("-------------------------Test Drwer----------------${ModelDrawer.fromJson(response.data).data.length}");
      stopLoadingHomePage();
     return ModelDrawer.fromJson(response.data);
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(response.data["status"]==Utility.VERIFICATION_CODE_FAILED)
    {

      stopLoadingHomePage();
      return null;
      //------------Shaw Dialog ---------------//
      //shawAlertDialog(context: context,msg:error.error[0]);
    }else
    {
      stopLoadingHomePage();
      print("=========================== VERIFICATION_CODE Not compatible with schema${response.data["message"]} =======================");
      if(response.data["status"]=="Unauthenticated.")
      {
        shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:response.data["message"]);
      }


    }


    return null;

  }
  Future<ModelDrawer> getUsePolicyPage({BuildContext context}) async {

    _modelDrawer=ModelDrawer();

    final response =
    await http.get(_apiPolicy, headers: {"Accept": "application/json"});

    var   data  =json.decode(response.body);

    print("============================PRint------${data.toString()}----------------------");
    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      print("-------------------------Test Drwer----------------${ModelDrawer.fromJson(data).data.length}");
      stopLoadingHomePage();
      return _modelDrawer= ModelDrawer.fromJson(data);
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {

      stopLoadingHomePage();
      return null;
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


    return null;

  }
  Future<ModelDrawer> getAboutUsPage({BuildContext context}) async {

    _modelDrawer=ModelDrawer();

    final response =
    await http.get(_apiAbout, headers: {"Accept": "application/json"});

    var   data  =json.decode(response.body);

    print("============================PRint------${data.toString()}----------------------");
    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      print("-------------------------Test Drwer----------------${ModelDrawer.fromJson(data).data.length}");
      stopLoadingHomePage();
      return _modelDrawer= ModelDrawer.fromJson(data);
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {

      stopLoadingHomePage();
      return null;
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


    return null;

  }

  Future<NotificationsModel> getNotifications({BuildContext context}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);



    final response =await http.get(_apiNotifications+"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwMFwvXC9hcGlcL2F1dGhcL3JlZ2lzdGVyQWR2ZXJ0IiwiaWF0IjoxNTY5NDk1MzcwLCJuYmYiOjE1Njk0OTUzNzAsImp0aSI6IjRsZTBpT3BVcXFHZldkbWQiLCJzdWIiOjQsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.JMj2kvRi92H6jAR-lyI4kJlvaAlgKFmfUJ-rbaE24vE", headers: {"Accept": "application/json"});


    var   data  =json.decode(response.body);

    print("============================Notifications PRint------${data.toString()}----------------------");

    ///========================================= Check the Status Response (SUCCESS)====================================//

    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      print("-------------------------Notifications----------------${NotificationsModel.fromJson(data).data.length}");
      stopLoadingHomePage();
      return notificationsModel= NotificationsModel.fromJson(data);
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {

      stopLoadingHomePage();
      return null;
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


    return null;

  }




  Future setContactMessage({BuildContext context,String msg}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString(Utility.TOKEN);
    final response =await http.post(_apiContact+token, headers: {"Accept": "application/json"},body: {'message': "${msg}",});


    var   data  =json.decode(response.body);

    print("============================Contact------${data.toString()}----------------------");
    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      Utility.shawAlertDialogSuccess(context: context,title: "الاداره",msg: "تم ارسال الرساله بنجاح شكرا لكم");

      stopLoadingHomePage();

    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {

      stopLoadingHomePage();
      //------------Shaw Dialog ---------------//
      Utility.shawAlertDialogFailed(context: context,title: "الاداره",msg: "نأسف تعذر ارسال الرساله حاول فى وقت لاحق");
    }else
    {
      stopLoadingHomePage();
      print("=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
      if(data["message"]=="Unauthenticated.")
      {
        shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:data["message"]);
      }


    }


    return null;

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