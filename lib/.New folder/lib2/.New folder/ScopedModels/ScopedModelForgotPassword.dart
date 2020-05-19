import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/model/TokenModel/TokenFromLogin/TokenFailedLogin.dart';
import 'package:vacatiion/pages/login_signup/login_page.dart';
import 'package:vacatiion/pages/mainPages/FirstPage.dart';
import 'package:vacatiion/utility/api_utilites.dart';
import 'package:vacatiion/utility/utility_class.dart';

class ScopedModelForgetPassword extends Model
{
  static bool isLoading ;

  String apiForgotPassword=ApiUtilities.baseApi+ApiUtilities.forgotPassword;

  showLoading()
  {
    isLoading=true;
    notifyListeners();
  }
  stopLoading()
  {
    isLoading=false;
    notifyListeners();
  }



  forgotPasswordByEmail (String email,BuildContext context)async
  {

    //------------------- Send Request in Server ---------------------//
    var response = await http.post(apiForgotPassword, body: {'email': email.trim(),});

    //------------------- Receive Response in Server ---------------------//
    var data=json.decode(response.body);

       print("==================forgotPassword============${data["data"]}====================");


   ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {

      var msgJ=data['data'];
      stopLoading();
      //--------------- Fetch Code from Json --------------//
      shawAlertDialogSuccessful(msg:msgJ,context: context );

    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {

      var resultFailed = TokenFailedLogin.fromJson(data);

      var contentError=resultFailed.error;

      print("=======VERIFICATION_CODE_FAILED======== Done ${contentError} ==================");
      stopLoading();

      //-------------- Shaw Dialog ---------------//
      shawAlertDialogFaild(context: context,msg: contentError,);

    }else
    {
      stopLoading();
      print("=========================== VERIFICATION_CODE Not compatible with schema =======================");
    }


  }


  void shawAlertDialogSuccessful({BuildContext context,String msg,})
  {
    Alert(
      context: context,
      type: AlertType.success,
      title: "تم الارسال بنجاح",
      desc: "تم ارسال كلمه مرور جديده للبريد الالكتروني"+"\n"+"سجل الدخول بكلمه المرور الجديده"+"\n"+msg,
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
            _openLoginPage(context);
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

  void shawAlertDialogFaild({BuildContext context,String msg,})
  {
    Alert(
      context: context,
      type: AlertType.error,
      title: "خطأ فى المصادقه",
      desc: "هذا البريد غير مسجل"+"\n"+msg,
      style: Utility.alertStyle,
      buttons: [

        DialogButton(
          child: Text(
            "تسجيل جديد ",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()
          {
            //------------ Dismiss Dialog ------------//
            Navigator.pop(context);
            //------------- open First PAGE -------------//
            _openFirstPage(context);
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

  void _openLoginPage(BuildContext context)
  {
    Navigator
        .of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context)
    {
      return  LoginPage();
    }));
  }

  void _openFirstPage(BuildContext context)
  {
    Navigator
        .of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context)
    {
      return  FirstPage();
    }));
  }

}