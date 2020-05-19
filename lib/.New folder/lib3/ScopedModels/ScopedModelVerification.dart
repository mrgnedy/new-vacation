
import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:io';
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
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';



class ScopedModelVerification extends Model
{

  static bool isLoading ;

  String apiRegisterVerification=ApiUtilities.baseApi+ApiUtilities.codeVerificationApi;
  String apiNewRegisterUser=ApiUtilities.baseApi+ApiUtilities.registerUserApi;
  String apiNewRegisterAdvertiser=ApiUtilities.baseApi+ApiUtilities.registerAdvertiserApi;


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

  //==================================== User ===================================//
  getVerificationUser (String name,String email,String phone,String password,BuildContext context)async
  {

    SharedPreferences pref = await SharedPreferences.getInstance();
    var os=pref.getString(Utility.OS_Platform);
    var device_token=pref.getString(Utility.Device_Token);


    //------------------- Send Request in Server ---------------------//
    var response = await http.post(apiRegisterVerification, body: {'email': email.trim(),
                                                                   'name': name.trim(),
                                                                    'os':os.trim(),
                                                                      'device_token':device_token.trim()
    });
    //------------------- Receive Response in Server ---------------------//
    var data=json.decode(response.body);


    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {
      //-----------------Save User Local Data ----------------//
      saveUserDatainLocal(email: email,name: name,phone:phone ,password:password);

      //--------------- Fetch Code from Json --------------//
      var resultCode = CodeVerificationSuccess.fromJson(data);
      var code=resultCode.data.code;
      print("======= ScopedModel ======== CodeVerifi ${code} ==================");

      if(code!=null)
      {
        stopLoading();
        //---------------Page VERIFICATION--------------//
         File fileTest;
        _openPinEntryPage(context,code,"2",fileTest);
      }


    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status'] == Utility.VERIFICATION_CODE_FAILED)
    {

      var resultFailed = CodeVerificationFailed.fromJson(data);
      var contentError=resultFailed.error.email[0];

      print("================== VERIFICATION_CODE_FAILED =========== Done ${contentError} ==========================");
      stopLoading();

      //------------Shaw Dialog ---------------//
      //-----------------  TODO alert -----------------//
      shawAlertDialog(context: context,msg: contentError,flagTypeUser: "2");

    }else
    {
      stopLoading();
      print("=========================== VERIFICATION_CODE Not compatible with schema =======================");
    }


  }

  createNewAccountUser({String name,String email,String phone,String password,BuildContext context})async
  {
    showLoading();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var os=pref.getString(Utility.OS_Platform);
    var device_token=pref.getString(Utility.Device_Token);
     //---------------------Create New Account for user--------------------------//
    //------------------- Send Request in Server ---------------------//
     var responsUser = await http.post(apiNewRegisterUser, body:
      { 'name':"${name}",
        'email': email,
        'password':password,
        'password_confirmation':password,
        'phone':phone,
        'os':os.trim(),
        'device_token':device_token.trim(),
        'role_id':"2"
      },
      );

    //------------------- Receive Response in Server ---------------------//
     var data=json.decode(responsUser.body);
    print("==================================== Print Response = ${data}=======================");


   ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {

      //--------------- Fetch Code from Json --------------//
      var resultCode = TokenSuccessfulRegister.fromJson(data);
      var token=resultCode.data;


      print("=============================== VERIFICATION_CODE_SUCCESS ======== Token ${token} ==================");

      if(token!=null)
      {
        saveTokenAndRoleId(token: token,roleId: 2);
        stopLoading();
        openMainPageForUser(context);
      }


    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {

      var resultFailed = TokenFailed.fromJson(data);
      var contentError=resultFailed.error.email[0];

      print("=======VERIFICATION_CODE_FAILED========   ${contentError} ==================");
      stopLoading();

      //------------Shaw Dialog ---------------//
      shawAlertDialog(context: context,msg: contentError,flagTypeUser: "2");

    }else
    {
      stopLoading();
      print("=========================== VERIFICATION_CODE Not compatible with schema =======================");
    }

  }

 // ========================================== Advertiser =====================================//
  getVerificationAdvertiser({String name,String email,
                            String phone,String password,
                            File image,BuildContext context})async
  {
    showLoading();


    SharedPreferences pref = await SharedPreferences.getInstance();
    var os=pref.getString(Utility.OS_Platform);
    var device_token=pref.getString(Utility.Device_Token);
    //------------------- Send Request in Server ---------------------//
    var response = await http.post(apiRegisterVerification, body: {'email': email.trim(),
                                                                    'name': name.trim(),
                                                                     'os':os.trim(),
                                                                     'device_token':device_token.trim()});
    //------------------- Receive Response in Server ---------------------//
    var data=json.decode(response.body);

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {

      //-----------------Save User Local Data ----------------//
      saveAdvertiserDatainLocal(name: name,password: password,
                                phone: phone,email: email, );

      //--------------- Fetch Code from Json --------------//
      var resultCode = CodeVerificationSuccess.fromJson(data);
      var code=resultCode.data.code;
      print("======= ScopedModel ======== CodeVerifi ${code} ==================");

      if(code!=null)
      {
        stopLoading();
        //---------------Page VERIFICATION--------------//
        _openPinEntryPage(context,code,"3",image);

      }


    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {

      var resultFailed = CodeVerificationFailed.fromJson(data);

      var contentError=resultFailed.error.email[0];

      print("=======VERIFICATION_CODE_FAILED======== Done ${contentError} ==================");
      stopLoading();

      //------------Shaw Dialog ---------------//
      //TODO alert
      shawAlertDialog(context: context,msg: contentError,flagTypeUser: "2");

    }else
    {
      stopLoading();
      print("=========================== VERIFICATION_CODE Not compatible with schema =======================");
    }


  }

  createNewAccountAdvertiser({String name,String email,
    String phone,String password,
    String bankName,String accountNumber,
    String accountName,String ibanNumber,
    File imageFile,BuildContext context})async
  {


    SharedPreferences pref = await SharedPreferences.getInstance();
    var os=pref.getString(Utility.OS_Platform);
    var device_token=pref.getString(Utility.Device_Token);

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(apiNewRegisterAdvertiser);

    var request = new http.MultipartRequest("POST", uri,);


    var multipartFile = new http.MultipartFile('image', stream, length,filename: basename(imageFile.path));


    request.fields['name'] = "${name}";
    request.fields['email'] = "${email}";
    request.fields['password'] = "${password}";
    request.fields['password_confirmation'] = "${password}";
    request.fields['phone'] = "${phone}";
    request.fields['bank'] = "${bankName}";
    request.fields['account_name'] = "${accountName}";
    request.fields['account_number'] ="${accountNumber}";
    request.fields['eban'] = "${password}";
    request.fields['os']=os.trim();
    request.fields['device_token']=device_token.trim();
    request.fields['role_id'] = '3';


    request.files.add(multipartFile);

    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    ///===================================================================  Response ======================================================================//
    response.stream.transform(utf8.decoder).listen((value)
    {
      print("===============Response=======${value}=============================");
      //------------------- Receive Response in Server ---------------------//
      var data=json.decode(value);

      print("=========Status for Create Adver======"+data['status']+"======================");

    ///========================================= Check the Status Response (SUCCESS)====================================//
      if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
      {

        //--------------- Fetch Code from Json --------------//
        var resultCode = TokenSuccessfulRegister.fromJson(data);
        var token=resultCode.data;


        print("======= VERIFICATION_CODE_SUCCESS ======== Token ${token} ==================");

        if(token!=null)
        {
          saveTokenAndRoleId(token: token,roleId: 3);
          stopLoading();
          openMainPageForAdvertiser(context);
        }


      }
      ///========================================= Check the Status Response (=====FAILED===) ====================================//
      else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
      {

      print("========================== aasss ======= ${data.toString()} ========================");
      var resultFailed = TokenFailed.fromJson(data);
      var contentError=resultFailed.error.email[0];

      print("======= VERIFICATION_CODE_FAILED ======== Done ${contentError} ==================");
      stopLoading();

      //------------Shaw Dialog ---------------//
      //----TODO alert
      shawAlertDialog(context: context,msg: contentError,flagTypeUser: "3");

      }else
      {
        stopLoading();
        print("=========================== VERIFICATION_CODE Not compatible with schema =======================");
      }



    });





  }








  //---------------open PinEntry Page--------------------//
  void _openPinEntryPage(BuildContext context,var code,String flag,File image)
  {
    Navigator
        .of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context)
    {
      return  PinEntryPage(codeVerify: code,flag: flag,image: image,);
    }));
  }

  //---------------open_open LoginPage and Send Flag--------------------//
  void _openLoginPage(BuildContext context)
  {
    Navigator.push(context, SizeRoute(page: LoginPage()));
  }

  void openMainPageForUser(BuildContext context)
  {
    Navigator
        .of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context)
    {
      return  MainWidgetUser();
    }));
  }

  void openMainPageForAdvertiser(BuildContext context)
  {
    Navigator
        .of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context)
    {
      return  MainWidgetAdvertiser();
    }));
  }


  //---------------Save User Data Offline ------------------//
  void saveUserDatainLocal({String name,String email,String phone,String password}) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Utility.ShARED_USER_NAME, name);
    pref.setString(Utility.ShARED_USER_EMAIL, email);
    pref.setString(Utility.ShARED_USER_PHONE, phone);
    pref.setString(Utility.ShARED_USER_PASSWORD, password);

  }

  void saveAdvertiserDatainLocal({String name, String email,
    String phone, String password,
    String bankName, String accountName,
    String accountNumber, String ibanNumber
  }) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Utility.ShARED_Advertiser_NAME, name);
    pref.setString(Utility.ShARED_Advertiser_EMAIL, email);
    pref.setString(Utility.ShARED_Advertiser_PHONE, phone);
    pref.setString(Utility.ShARED_Advertiser_PASSWORD, password);
    pref.setString(Utility.ShARED_Advertiser_BANK_NAME, bankName);
    pref.setString(Utility.ShARED_Advertiser_Account_NAME, accountName);
    pref.setString(Utility.ShARED_Advertiser_ACCOUNT_NUMBER, accountNumber);
    pref.setString(Utility.ShARED_Advertiser_IBAN_NUMBER, ibanNumber);

  }

  void saveTokenAndRoleId({String token,int roleId})async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.setString(Utility.TOKEN, token);
                      pref.setInt(Utility.ROLE_ID, roleId);

  }

  void shawAlertDialog({BuildContext context,String msg,String flagTypeUser})
{
  Alert(
    context: context,
    type: AlertType.warning,
    title: "خطأ في المصادقة",
    desc: " هذا البريد مسجل من قبل يمكنك تسجيل الدخول"+"\n"+msg,
    style: Utility.alertStyle,
    buttons: [
      DialogButton(
        child: Text(
          "تسجيل دخول",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: ()
        {
          //----------Dismiss Dialog---------//
          Navigator.pop(context);
          //---------open Login PAGE----------//
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


}