import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacatiion/model/Advertiser/UpdateAdvertiser.dart';
import 'package:vacatiion/model/user/UpdateUser.dart';
import 'package:vacatiion/pages/SubPages/AdvertiserPages/account/EditPersonalAccountAdvertiser.dart';
import 'package:vacatiion/pages/SubPages/UserPages/account/EditPersonalAccountUser.dart';
import 'package:vacatiion/pages/login_signup/login_page.dart';
import 'package:vacatiion/utility/api_utilites.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:http/http.dart' as http;
import 'package:vacatiion/utility/page-route-transition.dart';
import 'dart:core' as prefix0;
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';





class ScopedModelUpdateUser extends Model
{

  ///-----------StreamController Advertiser------------------------//
  StreamController<UpdateAdvertiser>    streamControllerUpdateAdvertiser;
  initialStreamControllerAdvertiser()
  {
    streamControllerUpdateAdvertiser=StreamController<UpdateAdvertiser>.broadcast();
  }
  Stream<UpdateAdvertiser> get outUpdateAdvertiser =>streamControllerUpdateAdvertiser.stream;
  Sink<UpdateAdvertiser> get inPutUpdateAdvertiser => streamControllerUpdateAdvertiser.sink;
  void disposeAdvertiser()
  {
    streamControllerUpdateAdvertiser.close();
  }
  ///-----------StreamController User------------------------//
  StreamController<UpdateUser>    streamControllerUpdateUser;
  initialStreamControllerUser()
  {
    streamControllerUpdateUser=StreamController<UpdateUser>.broadcast();
  }
  Stream<UpdateUser> get outUpdateUser =>streamControllerUpdateUser.stream;
  Sink<UpdateUser> get inPutUpdateUser => streamControllerUpdateUser.sink;
  void disposeUser()
  {
    streamControllerUpdateUser.close();
  }

  
  
  static bool isLoading ;
  static String _apiUpdateInformation=ApiUtilities.baseApi+ApiUtilities.updateInformationUser;



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

///----------------------------------------------------Advertiser------------------------------------//
  //------------Get All Data for Advertiser--------//
   getUpdateAdvertiser({BuildContext context})async
   {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var token = prefs.getString(Utility.TOKEN);

     //------------------- Send Request in Server ---------------------//
     Map<String, String> headers = {"Accept": "application/json"};
     var response = await http.post(_apiUpdateInformation+token,headers: headers ,body: {});
     print("================================AAAAAA==========================");
     //------------------- Receive Response in Server ---------------------//
     var data=json.decode(response.body);

     print("==================================== Print Response = ${data}=======================");


     ///========================================= Check the Status Response (SUCCESS)====================================//
     if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
     {

        inPutUpdateAdvertiser.add(UpdateAdvertiser.fromJson(data));

      // notifyListeners();
     }
     ///========================================= Check the Status Response (FAILED)====================================//
     else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
     {
        var error =FailedUpdate.fromJson(data);
          print("============================fffff=================");
       //------------Shaw Dialog ---------------//
      shawAlertDialog(context: context,msg:error.error.email[0]);
     }else
     {
       stopLoading();
       print("=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
       if(data["message"]=="Unauthenticated.")
       {
         shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:data["message"]);
       }

     }

     //notifyListeners();
   }
  updateAccountAdvertiserWithImage(
      {String name,
     String email,
     String phone,
    String bankName,String accountNumber,
    String accountName,String ibanNumber,
    File imageFile,BuildContext context})async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    var os=prefs.getString(Utility.OS_Platform);

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(_apiUpdateInformation+token);
    var request = new http.MultipartRequest("POST", uri,);


    var multipartFile = new http.MultipartFile('image', stream, length,filename: basename(imageFile.path));
    request.fields['name'] = "${name}";
    request.fields['email'] = "${email}";
    request.fields['phone'] = "${phone}";
    request.fields['bank'] = "${bankName}";
    request.fields['eban']="${ibanNumber}";
    request.fields['account_name'] = "${accountName}";
    request.fields['account_number'] ="${accountNumber}";
    request.fields['os']=os.trim();
    request.fields['role_id'] = '3';

    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);

    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    ///===================================================================  Response ======================================================================//
    response.stream.transform(utf8.decoder).listen((value)
    {
      print("===============ResponseUPDATEUser 2=======${value}=============================");
      //------------------- Receive Response in Server ---------------------//
      var data=json.decode(value);

      print("=========Status for Create Adver 2======"+data['status']+"======================");

      ///========================================= Check the Status Response (SUCCESS)====================================//
      if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
      {
          notifyListeners();
          stopLoading();

        backAccount(context);

      }
      ///========================================= Check the Status Response (=====FAILED===) ====================================//
      else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
      {
        stopLoading();

      }else
      {
        stopLoading();
        print("=========================== VERIFICATION_CODE Not compatible with schema =======================");

      }

    });


  }
  updateAccountAdvertiser(
      {String name,
        String email,
        String phone,
        String bankName,String accountNumber,
        String accountName,String ibanNumber,
        BuildContext context})async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    var os=prefs.getString(Utility.OS_Platform);


    var uri = Uri.parse(_apiUpdateInformation+token);

    var request = new http.MultipartRequest("POST", uri,);

     request.fields['name'] = "${name}";
    request.fields['email'] = "${email}";
    request.fields['phone'] = "${phone}";
    request.fields['bank'] = "${bankName}";
    request.fields['eban']="${ibanNumber}";
    request.fields['account_name'] = "${accountName}";
    request.fields['account_number'] ="${accountNumber}";
    request.fields['os']=os.trim();
    request.fields['role_id'] = '3';
    //contentType: new MediaType('image', 'png'));


    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    ///===================================================================  Response ======================================================================//
    response.stream.transform(utf8.decoder).listen((value)
    {
      print("=============== ResponseUPDATEUser =======${value}=============================");
      //------------------- Receive Response in Server ---------------------//
      var data=json.decode(value);

      print("=========Status for Create Adver======"+data['status']+"======================");
      ///------------------------------------------------------------------------------------------------Refresh Data------------------------//
      getUpdateAdvertiser(context: context);
      ///========================================= Check the Status Response (SUCCESS)====================================//
      if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
      {
        ///=========================================getUpdate ====================================//

     //   notifyListeners();

        stopLoading();
        backAccount(context);

      }
      ///========================================= Check the Status Response (=====FAILED===) ====================================//
      else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
      {
        var msg =UpdateUserFailed.fromJson(data);
        stopLoading();

        shawAlertDialog(context: context,msg:msg.error.email[0]);
      }else
      {
        stopLoading();
        print("=========================== VERIFICATION_CODE Not compatible with schema =======================");

      }

    });





  }
  void openEditAccountAdvertiser(BuildContext context)
  {
  Navigator.push(
      context, SizeRoute(page: EditPersonalAccountAdvertiser()));
  }
  ///----------------------------------------------------User------------------------------------//
  //------------Get All Data for User--------//
  getUpdateUser({BuildContext context})async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);

    //------------------- Send Request in Server ---------------------//
    Map<String, String> headers = {"Accept": "application/json"};
    var response = await http.post(_apiUpdateInformation+token,headers: headers ,body: {});
    print("================================AAAAAA==========================");
    //------------------- Receive Response in Server ---------------------//
    var data=json.decode(response.body);
    print("==================================== Print Response = ${data}=======================");


    ///========================================= Check the Status Response (SUCCESS)====================================//
    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
    {

      inPutUpdateUser.add(UpdateUser.fromJson(data));

      // notifyListeners();
    }
    ///========================================= Check the Status Response (FAILED)====================================//
    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
    {
      var error =FailedUpdate.fromJson(data);
      print("============================fffff=================");
      //------------Shaw Dialog ---------------//
      shawAlertDialog(context: context,msg:error.error.email[0]);
    }else
    {
      stopLoading();
      print("=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
      if(data["message"]=="Unauthenticated.")
      {
        shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:data["message"]);
      }

    }

    //notifyListeners();
  }
  updateAccountUser(
      {String name,
        String email,
        String phone,
        BuildContext context})async
  {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    var os=prefs.getString(Utility.OS_Platform);


    var uri = Uri.parse(_apiUpdateInformation+token);

    var request = new http.MultipartRequest("POST", uri,);

    request.fields['name'] = "${name}";
    request.fields['email'] = "${email}";
    request.fields['phone'] = "${phone}";
    request.fields['os']=os.trim();
    request.fields['role_id'] = '2';



    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    ///===================================================================  Response ======================================================================//
    response.stream.transform(utf8.decoder).listen((value)
    {
      print("=============== ResponseUPDATEUser =======${value}=============================");
      //------------------- Receive Response in Server ---------------------//
      var data=json.decode(value);

      print("=========Status for Create Adver======"+data['status']+"======================");
      getUpdateUser(context: context);
      ///========================================= Check the Status Response (SUCCESS)====================================//
      if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
      {
        ///=========================================getUpdate ====================================//

        stopLoading();
        backAccount(context);

      }
      ///========================================= Check the Status Response (=====FAILED===) ====================================//
      else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
      {
        var msg =UpdateUserFailed.fromJson(data);
        stopLoading();

        shawAlertDialog(context: context,msg:msg.error.email[0]);
      }else
      {
        stopLoading();
        print("=========================== VERIFICATION_CODE Not compatible with schema =======================");

      }

    });





  }


  void openEditAccountUser(BuildContext context)
  {
    Navigator.push(
        context, SizeRoute(page: EditPersonalAccountUser()));
  }





  void shawAlertDialog({BuildContext context,String msg,})
  {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "خطأ في المصادقة",
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

  void backAccount(BuildContext context)
  {
    Navigator.pop(context);
  }








}