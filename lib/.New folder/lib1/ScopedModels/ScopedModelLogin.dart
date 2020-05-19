import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/model/TokenModel/TokenFromLogin/TokenFailedLogin.dart';
import 'package:vacatiion/model/TokenModel/TokenFromLogin/TokenSuccessfulLogin.dart';
import 'package:vacatiion/pages/mainPages/FirstPage.dart';
import 'package:vacatiion/utility/api_utilites.dart';
import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacatiion/model/CodeVerificationFailed.dart';
import 'package:vacatiion/model/CodeVerificationSuccess.dart';
import 'package:vacatiion/model/TokenModel/TokenFromRegister/TokenFailedRegister.dart';
import 'package:vacatiion/model/TokenModel/TokenFromRegister/TokenSuccessfulRegister.dart';
import 'package:vacatiion/pages/login_signup/PinEntryPages.dart';
import 'package:vacatiion/pages/login_signup/login_page.dart';
import 'package:vacatiion/pages/mainPages/MainPageUser.dart';
import 'package:vacatiion/pages/mainPages/MainPageAdvertiser.dart';
import 'package:vacatiion/utility/api_utilites.dart';
import 'package:http/http.dart' as http;
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:rflutter_alert/rflutter_alert.dart';




class ScopedModelLogin extends Model
{
  static bool isLoading ;



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

  String apilogin=ApiUtilities.baseApi+ApiUtilities.loginApi;


  loginAndGetToken (String email,String password,BuildContext context)async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
     var os=pref.getString(Utility.OS_Platform);
     var devic_token=pref.getString(Utility.Device_Token);
    
    //------------------- Send Request in Server ---------------------//
    var response = await http.post(apilogin, body: {'email': email.trim(),
                                                    'password': password.trim(),
                                                    'os':os.trim(),
                                                    'device_token':devic_token.trim()
    });
    //------------------- Receive Response in Server ---------------------//
    var data=json.decode(response.body);


    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {

      //--------------- Fetch Code from Json --------------//
      var resultCode = TokenSuccessfulLogin.fromJson(data);

      var role=resultCode.data.role;
      var token=resultCode.data.accessToken;

      if(role=="user")
        {
           saveTokenAndRoleId(roleId: 2,token: token);
            stopLoading();
           _openUserPage(context);

        }
      else if(role=="advertiser")
        {
           saveTokenAndRoleId(roleId: 3,token: token);
           stopLoading();
          _openadvertiserPage(context);
        }else
          {
            print("=====================Error in loginAndGetToken not user,not advertiser=================================");
          }



    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {

      var resultFailed = TokenFailedLogin.fromJson(data);

      var contentError=resultFailed.error;

      print("=======VERIFICATION_CODE_FAILED======== Done ${contentError} ==================");
      stopLoading();

      //-------------- Shaw Dialog ---------------//
      shawAlertDialog(context: context,msg: contentError,);

    }else
    {
      stopLoading();
      print("=========================== VERIFICATION_CODE Not compatible with schema =======================");
    }


  }



  void saveTokenAndRoleId({String token,int roleId})async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Utility.TOKEN, token);
    pref.setInt(Utility.ROLE_ID, roleId);

  }

  void shawAlertDialog({BuildContext context,String msg,})
  {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "خطأ في المصادقة",
      desc: "تأكد من ادخال كلمه المرور"+"\n"+"او ان هذا البريد غير مسجل",
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



  void _openFirstPage(BuildContext context)
  {
    Navigator
        .of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context)
    {
      return  FirstPage();
    }));
  }
  void _openUserPage(BuildContext context)
  {
    Navigator
        .of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context)
    {
      return  MainWidgetUser();
    }));
  }
  void _openadvertiserPage(BuildContext context)
  {
    Navigator
        .of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context)
    {
      return  MainWidgetAdvertiser();
    }));
  }

}