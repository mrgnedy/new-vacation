import 'package:dio/dio.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

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
import 'package:vacatiion/model/ShowChaletModel.dart';
import 'package:vacatiion/model/SuccessAvailableModel.dart';
import 'package:vacatiion/model/user/UpdateUser.dart';
import 'package:vacatiion/pages/SubPages/OffersPage.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Payments/PageCoupon.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Search/NoChalets.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Search/ResultSearchPage.dart';
import 'package:vacatiion/utility/api_utilites.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';



class ScopedModeResultSearchPage extends Model
{
  static bool loadingPage=false;


  //------------------------------------ Loading Home PAGE ----------------------------//
  showLoadingPage()
  {
    loadingPage=true;
    notifyListeners();
  }
  stopLoadingPage()
  {
    loadingPage=false;
    notifyListeners();
  }


  String _apiGetSearchByName=ApiUtilities.baseApi+ApiUtilities.searchByName;
  String _apiGetSearchByLocation=ApiUtilities.baseApi+ApiUtilities.searchByLocation;
  String _apiGetSearchByFilter=ApiUtilities.baseApi+ApiUtilities.searchByFilter;
  String _apiGetSearchByCity = ApiUtilities.baseApi+ApiUtilities.searchByCity;
  String _apiGetSearchBtDate = ApiUtilities.baseApi+ApiUtilities.searchByDate;

  void getResultSearchByName({BuildContext context,String chaletName}) async {
    showLoadingPage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);

    var response = await http.post(
        _apiGetSearchByName + token, body: {"name": "${chaletName}"},
        headers: {"Accept": "application/json"});


    var data = json.decode(response.body);

    print("------------------------------Test--------------------${data
        .toString()}");

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
      stopLoadingPage();
      openResultSearchPage(
          context: context, model: AllChaletsAndOffersModel.fromJson(data));
    }

    ///========================================= Check the Status Response (FAILED)====================================//
    else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
      var error = AdvertiserNoChalets.fromJson(data);
      openNotResultSearchPage(context: context, error: error.error.toString());

      stopLoadingPage();
      //------------Shaw Dialog ---------------//
      //shawAlertDialog(context: context,msg:error.error[0]);
    } else {
      stopLoadingPage();
      print(
          "=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
      if (data["message"] == "Unauthenticated.") {
        shawAlertDialogLogin(context: context,
            msg: "برجاء تسجيل الدخول",
            title: data["message"]);
      }
    }
  }

  void getResultSearchByDate({BuildContext context,String date}) async {
    showLoadingPage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    print("THIS IS $date");
    var response = await http.post(
        _apiGetSearchBtDate + token, body: {"date": "${date}"},
        headers: {"Accept": "application/json"});


    var data = json.decode(response.body);

    print("------------------------------Test--------------------${data
        .toString()}");

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
      stopLoadingPage();
      openResultSearchPage(
          context: context, model: AllChaletsAndOffersModel.fromJson(data));
    }

    ///========================================= Check the Status Response (FAILED)====================================//
    else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
      var error = AdvertiserNoChalets.fromJson(data);
      openNotResultSearchPage(context: context, error: error.error.toString());

      stopLoadingPage();
      //------------Shaw Dialog ---------------//
      //shawAlertDialog(context: context,msg:error.error[0]);
    } else {
      stopLoadingPage();
      print(
          "=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
      if (data["message"] == "Unauthenticated.") {
        shawAlertDialogLogin(context: context,
            msg: "برجاء تسجيل الدخول",
            title: data["message"]);
      }
    }
  }
    void getResultSearchByCity({BuildContext context,String cityName}) async {

      showLoadingPage();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(Utility.TOKEN);

      var response = await http.post(_apiGetSearchByCity+token, body:{"city":"$cityName"},headers: {"Accept": "application/json"});



      var   data  =json.decode(response.body);

      print("------------------------------Testtttt--------------------${data.toString()}");
      ///========================================= Check the Status Response (SUCCESS)====================================//
      if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
      {
        stopLoadingPage();
        openResultSearchPage(context: context,model: AllChaletsAndOffersModel.fromJson(data));

      }
      ///========================================= Check the Status Response (FAILED)====================================//
      else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
      {
        var error =AdvertiserNoChalets.fromJson(data);
        openNotResultSearchPage(context: context,error: error.error.toString());

        stopLoadingPage();
        //------------Shaw Dialog ---------------//
        //shawAlertDialog(context: context,msg:error.error[0]);
      }else
      {
        stopLoadingPage();
        print("=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
        if(data["message"]=="Unauthenticated.")
        {
          shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:data["message"]);
        }

      }




    }


 void  getResultSearchByLocation({BuildContext context,String lat,String long}) async {
         showLoadingPage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);

    var response = await http.post(_apiGetSearchByLocation+token, body:{"lat":"${lat}",
                                                                         "long":"${long}"
                                                                        },headers: {"Accept": "application/json"});



    var   data  =json.decode(response.body);

    print("------------------------------Test--------------------${data.toString()}");
    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      stopLoadingPage();
      openResultSearchPage(context: context,model: AllChaletsAndOffersModel.fromJson(data));
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {
      stopLoadingPage();
      var error =AdvertiserNoChalets.fromJson(data);
      openNotResultSearchPage(context: context,error: error.error.toString());

      print("============================ Get All ChALET ${error.error[0]} =================");

    }else
    {
      stopLoadingPage();
      print("=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
      if(data["message"]=="Unauthenticated.")
      {
        shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:data["message"]);
      }

    }




  }

  void getResultSearchByFilter({BuildContext context , Map <String,dynamic> detailsOfChalets })async
  {
    showLoadingPage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);

    Response response;

    Dio dio = new Dio();

    FormData formData =FormData.fromMap(detailsOfChalets);
    try{

      response = await dio.post(_apiGetSearchByFilter+token
        ,
        data: await formData,
        onSendProgress: (received, total)
        {
          if (total != -1) {
            print("=========================Basuony Mahmoud========================="+(received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      );


      ///========================================= Check the Status Response (SUCCESS)====================================//
      if(response.data["status"]==Utility.VERIFICATION_CODE_SUCCESS)
      {
         stopLoadingPage();
         openResultSearchPage(context: context,model: AllChaletsAndOffersModel.fromJson(response.data));

      }
      ///========================================= Check the Status Response (FAILED)====================================//
      else if(response.data["status"]==Utility.VERIFICATION_CODE_FAILED)
      {

        stopLoadingPage();
        var error =AdvertiserNoChalets.fromJson(response.data);
        openNotResultSearchPage(context: context,error: error.error.toString());

        //------------Shaw Dialog ---------------//
        //shawAlertDialog(context: context,msg:error.error[0]);
      }else
      {
        stopLoadingPage();
        print("=========================== VERIFICATION_CODE Not compatible with schema${response.data["message"]} =======================");
        if(response.data["status"]=="Unauthenticated.")
        {
          shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:response.data["message"]);
        }


      }



    }catch(e)
    {
      stopLoadingPage();
      print(e.response.data.toString());
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

  void openResultSearchPage({BuildContext context,AllChaletsAndOffersModel model})
  {
    Navigator.push(
        context, SizeRoute(page: ResultSearchPage(modelResulet:model)));
  }

  void openNotResultSearchPage({BuildContext context,String error})
  {
    Navigator.push(
        context, SizeRoute(page: NoChalets(msg: error,)));
  }
}