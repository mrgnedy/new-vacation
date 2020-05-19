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
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';

import 'package:vacatiion/utility/api_utilites.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'dart:core' as prefix0;
import 'dart:core';



class ScopedModeFavorites extends Model
{
  static bool loadingHomePage;
  static bool checkFavorites=false;

//-----------Get All Data by Token---------------//
  String _apiAllFavorites=ApiUtilities.baseApi+ApiUtilities.allFavorites;
  String _apiRemoveFavorites=ApiUtilities.baseApi+ApiUtilities.removeFavorites;

  ///-------------------------------------------------------- StreamController Chalet -------------------------------------------//
  StreamController<AllChaletsAndOffersModel>  streamControllerUserFavorites;

  //----------Start stream-----------//
  initialStreamControllerFavorites()
  {
    streamControllerUserFavorites=StreamController<AllChaletsAndOffersModel>.broadcast();
  }
  //---------------------- Input and Output Stream Get All Chalet ----------------------//
  Stream <AllChaletsAndOffersModel>  get outAllFavorites => streamControllerUserFavorites.stream;
  Sink<AllChaletsAndOffersModel>  get inPutAllFavorites=> streamControllerUserFavorites.sink;
  //----------Stop stream----------//
  void disposeStreamControllerChalet()
  {
    streamControllerUserFavorites.close();
  }



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
  checkExistFavorites()
  {
    checkFavorites=true;
    notifyListeners();
  }

  checkNotExistFavorites()
  {
    checkFavorites=false;
    notifyListeners();
  }



  Future getAllFavorites({BuildContext context}) async
  {
    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    final response =
    await http.get(_apiAllFavorites+token, headers: {"Accept": "application/json"});

    var   data  =json.decode(response.body);
     //print("--------------------${data.toString()}-------------------");
    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      checkExistFavorites();

      inPutAllFavorites.add(AllChaletsAndOffersModel.fromJson(data));
      print("-------------------------Test----------------${AllChaletsAndOffersModel.fromJson(data).data.length}");
      stopLoadingHomePage();
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {
      checkNotExistFavorites();
      var error =AdvertiserNoChalets.fromJson(data);
      print("============================ Get All ChALET ${error.error} =================");
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
  Future removeFavorites({BuildContext context,String chaletId}) async
  {
    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    //------------------- Send Request in Server ---------------------//
    var response = await http.post(_apiRemoveFavorites+token, body: {'chalet_id': chaletId.trim(),});


    var   data  =json.decode(response.body);
     print("--------------------${data.toString()}-------------------");
    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      checkExistFavorites();
      Utility.showToast("تم الحذف من المفضله",context: context,duration:Toast.LENGTH_LONG,chooseColor: 2,gravity:Toast.BOTTOM);
      stopLoadingHomePage();
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {
      checkNotExistFavorites();
      var error =AdvertiserNoChalets.fromJson(data);
      print("============================ remove Favorites ${error.error} =================");
      stopLoadingHomePage();
      Utility.showToast("تم الحذف بالفعل",context: context,duration:Toast.LENGTH_LONG,chooseColor: 1,gravity:Toast.BOTTOM);
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