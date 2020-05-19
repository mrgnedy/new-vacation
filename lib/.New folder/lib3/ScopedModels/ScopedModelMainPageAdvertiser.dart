import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vacatiion/model/Advertiser/UpdateAdvertiser.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';
import 'package:vacatiion/model/UploadCategory.dart';
import 'package:vacatiion/pages/SubPages/OffersPage.dart';
import 'package:vacatiion/utility/api_utilites.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:progress_dialog/progress_dialog.dart';

class ScopedModelMainPageAdvertiser extends Model {
  static bool loadingHomePage;
  static bool showhintAddCategory = true;
  static bool checkExistChalet = false;
  static int numbersOfChalets = 3;
  static bool checkExistOffers = false;

//-------------- Show or not Hint Text ----------------//
  trueHintAddCategory() {
    showhintAddCategory = true;
    notifyListeners();
  }

  falseHintAddCategory() {
    showhintAddCategory = false;
    notifyListeners();
  }

  //-------------- Loading Home PAGE ----------------//
  showLoadingHomePage() {
    loadingHomePage = true;
    notifyListeners();
  }

  stopLoadingHomePage() {
    loadingHomePage = false;
    notifyListeners();
  }

  //---------------change Number Items-------------//
  changeNumberItems(int i) {
    numbersOfChalets = i;
    notifyListeners();
  }

  //------------------Check Chalet available-------------//
  checkExistChaletV() {
    checkExistChalet = true;
    notifyListeners();
  }

  checkNotExistChaletV() {
    checkExistChalet = false;
    notifyListeners();
  }

  //--------------------Check Offers available------------------------//
  methdcheckExistOffers() {
    checkExistOffers = true;
  }

  methdcheckNotExistOffers() {
    checkExistOffers = false;
  }

  ///-------------------------------------------------------- StreamController Chalet -------------------------------------------//
  StreamController<AllChaletsAndOffersModel> streamControllerAdvertiserChalets;
  //----------Start stream-----------//
  initialStreamControllerChalet() {
    streamControllerAdvertiserChalets =
        StreamController<AllChaletsAndOffersModel>.broadcast();
  }

  //---------------------- Input and Output Stream Get All Chalet ----------------------//
  Stream<AllChaletsAndOffersModel> get outAllChaletAdvertiser =>
      streamControllerAdvertiserChalets.stream;
  Sink<AllChaletsAndOffersModel> get inPutAllChaletAdvertiser =>
      streamControllerAdvertiserChalets.sink;

  //----------Stop stream----------//
  void disposeStreamControllerChalet() {
    streamControllerAdvertiserChalets.close();
  }

  ///===================================================== StreamController Offers ============================================//
  StreamController<AllChaletsAndOffersModel> streamControllerAdvertiserOffers;
  //---------------------- Input and Output Stream Get All Chalet ----------------------//
  Stream<AllChaletsAndOffersModel> get outAllOffersAdvertiser =>
      streamControllerAdvertiserChalets.stream;
  Sink<AllChaletsAndOffersModel> get inPutAllOffersAdvertiser =>
      streamControllerAdvertiserChalets.sink;
  //------------  Start stream -----------//
  initialStreamControllerOffers() {
    streamControllerAdvertiserChalets =
        StreamController<AllChaletsAndOffersModel>.broadcast();
  }

  //------------- Stop stream ------------//
  void disposeStreamControllerOffers() {
    streamControllerAdvertiserChalets.close();
  }

  static bool isLoading;

  //-----------Get All Data by Token---------------//
  String _apiGetAllChalets =
      ApiUtilities.baseApi + ApiUtilities.advertiserChalets;
  String _apiGetAllOffers =
      ApiUtilities.baseApi + ApiUtilities.advertiserOffers;
  //------------------------- Add Data --------------------------//
  String _apiAddChalets =
      ApiUtilities.baseApi + ApiUtilities.advertiserADDChalets;

  String _apiRemoveChalet = ApiUtilities.baseApi + ApiUtilities.removeChalet;

  Future getAllChalet({BuildContext context}) async {
    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    final response = await http.get(_apiGetAllChalets + token,
        headers: {"Accept": "application/json"});

    var data = json.decode(response.body);

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
      checkExistChaletV();
      falseHintAddCategory(); // heading text
      changeNumberItems(AllChaletsAndOffersModel.fromJson(data).data.length);
      inPutAllChaletAdvertiser.add(AllChaletsAndOffersModel.fromJson(data));
      print(
          "-------------------------Test----------------${AdvertiserChaletsResulet.fromJson(data).data.length}");
      stopLoadingHomePage();
    }

    ///========================================= Check the Status Response (FAILED)====================================//
    else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
      checkNotExistChaletV();
      trueHintAddCategory(); // show text
      var error = AdvertiserNoChalets.fromJson(data);
      print(
          "============================ Get All ChALET ${error.error[0]} =================");
      stopLoadingHomePage();
      //------------Shaw Dialog ---------------//
      //shawAlertDialog(context: context,msg:error.error[0]);
    } else {
      stopLoadingHomePage();
      print(
          "=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
      if (data["message"] == "Unauthenticated.") {
        shawAlertDialogLogin(
            context: context,
            msg: "برجاء تسجيل الدخول",
            title: data["message"]);
      }
    }
  }

  Future getAllOffers({BuildContext context}) async {
    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    final response = await http
        .get(_apiGetAllOffers + token, headers: {"Accept": "application/json"});

    var data = json.decode(response.body);

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
      methdcheckExistOffers();
      changeNumberItems(AllChaletsAndOffersModel.fromJson(data).data.length);
      inPutAllOffersAdvertiser.add(AllChaletsAndOffersModel.fromJson(data));
      print(
          "-------------------------Test----------------${AllChaletsAndOffersModel.fromJson(data).data.length}");
      stopLoadingHomePage();
    }

    ///========================================= Check the Status Response (FAILED)====================================//
    else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
      methdcheckNotExistOffers();
      var error = AdvertiserNoChalets.fromJson(data);
      print(
          "============================ Get All ChALET ${error.error[0]} =================");
      stopLoadingHomePage();
      //------------Shaw Dialog ---------------//
      //shawAlertDialog(context: context,msg:error.error[0]);
    } else {
      stopLoadingHomePage();
      print(
          "=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
      if (data["message"] == "Unauthenticated.") {
        shawAlertDialogLogin(
            context: context,
            msg: "برجاء تسجيل الدخول",
            title: data["message"]);
      }
    }
  }

  Future removeChalet({BuildContext context, String chaletId}) async {
    showLoadingHomePage();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString(Utility.TOKEN);

    var uri = Uri.parse(_apiRemoveChalet + chaletId.trim() + "?token=" + token);

    var request = new http.MultipartRequest(
      "POST",
      uri,
    );

    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      //------------------- Receive Response in Server ---------------------//
      var data = json.decode(value);

      print("=========Remove CHALIET=====" +
          data.toString() +
          "======================");

      ///========================================= Check the Status Response (SUCCESS)====================================//
      if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
        stopLoadingHomePage();
        Utility.showToast("تم حذف الشاليه بنجاح !!",
            context: context,
            duration: Toast.LENGTH_LONG,
            chooseColor: 4,
            gravity: Toast.BOTTOM);
      }

      ///========================================= Check Refer ====================================//
      else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
        stopLoadingHomePage();
        Utility.showToast("تم حذفه من قبل !!",
            context: context,
            duration: Toast.LENGTH_LONG,
            chooseColor: 1,
            gravity: Toast.BOTTOM);
      } else {
        stopLoadingHomePage();
        print(
            "=========================== VERIFICATION_CODE Not compatible with schema =======================");
      }
    });
  }

//  Future uploadCategory({BuildContext context,String chaletname,String startDate,String endDate,
//                                              String lat,String long,
//                                              String kind,
//                                              String departMintName,String space,
//                                              String nightNUmber,String about,
//                                              String NumberBathRooms,String cancelNumber
//                                               ,List<Asset> listImages
//                                               ,UploadDays listDayes,UploadDescriptions listDescription,
//                                               List<String>restTools,List<String>conditions})async
//  {
//
////  final imagesBytes = {};
////
////  for (Asset a in listImages)
////  {
////  //final bytes = await a.requestOriginal();
////  final bytes = await a.getByteData();
////  imagesBytes[a.identifier] = bytes.buffer.asUint8List();
////
////  }
//
//
//
//
//    chaletname="basuony";
//    startDate="2019-12-1";
//    endDate="2019-12-28";
//    lat="31.005445545";
//    long="32.005454516";
//    kind="شاليه";
//    departMintName="عائلي";
//    space="120";
//    nightNUmber="150";
//    about="ملكيه جديده خاصه بتطبيق فاكشن";
//    NumberBathRooms="12";
//    cancelNumber="2";
//
//    //-------------Dayes
//    for(int i=0;i<6;i++)
//    {
//
//    }
//
//
//
//
//
//   ///-----------------List Image---------------//
// // final imagesData = listImages.map((a) => UploadFileInfo.fromBytes(imagesBytes[a.identifier], a.name)).toList();
//  final imagesData = listImages.map((a) => UploadImages(image: a.identifier).toJson());
//
//
//
//
//
//
//    Response response;
//    Dio dio = new Dio();
//
//    FormData formData =FormData.fromMap({
//      "name": "${chaletname}",
//      "startDate": "${startDate}",
//      "endDate":"${endDate}",
//
//      "startTime":"10:12:5",
//      "endTime":"10:12:5",
//
//       "lat":"${lat}",
//       "lng":"${long}",
//       "kind":"${kind}",
//       "department":"${departMintName}",
//        "space":"${space}",
//        "nightNumber":"${nightNUmber}",
//        "about":"${about}",
//        "bathrooms":"${NumberBathRooms}",
//        "cancel":"${cancelNumber}",
//
//        "days[]":listDayes,
//        "descriptions[]":listDescription,
//
//         "tools[]":restTools,
//         "conditions[]": conditions,
//
//         "images[]":imagesData,
//
////      //"file": await MultipartFile.fromFile("./text.txt",filename: "upload.txt"),
////      "images": [
////        await MultipartFile.fromFile("./text1.txt", filename: "text1.txt"),
////        await MultipartFile.fromFile("./text2.txt", filename: "text2.txt"),
////      ]
//    });
//
//
//
//    response = await dio.post(_apiAddChalets
//        ,
//      data: await formData,
//      onSendProgress: (received, total) {
//        if (total != -1) {
//          print("=========================Basuony Mahmoud========================="+(received / total * 100).toStringAsFixed(0) + "%");
//        }
//      },
//    );
//
//    print(response);
//
//
//    //    final imagesBytes = {};
////    for (Asset a in images) {
////      final bytes = await a.requestOriginal();
////      imagesBytes[a.identifier] = bytes.buffer.asUint8List();
////    }
//
//
//
////    var stream ;
////    var length;
////    var multipartFile;
////
////    UploadImages   uploadImages;
////
////    listImages.forEach((file) => {
////
//////      request.files.add(http.MultipartFile.fromBytes(
//////        fieldName,
//////        file.readAsBytesSync(),
//////        filename: file.path.split('/').last,
//////      ))
////
////        stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
////         length = await imageFile.length();
////
////
////    multipartFile = new http.MultipartFile('image', stream, length,filename: basename(imageFile.path));
////
////    uploadImages  =UploadImages();
//
//    //  });
//
//  }
//
//
//
//
//

  Future uploadCategory(
      {BuildContext context, Map<String, dynamic> detailsOfChalets}) async {
    showLoadingHomePage();

    ///-----------------List Image---------------//
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);

    Response response;
    Dio dio = new Dio();

    print(detailsOfChalets);

    FormData formData = FormData.fromMap(detailsOfChalets);

    try {
      response = await dio.post(
        _apiAddChalets + token,
        data: await formData,
        onSendProgress: (received, total) {
          if (total != -1) {
            print(
                "=========================Basuony Mahmoud=========================" +
                    (received / total * 100).toStringAsFixed(0) +
                    "%");
          }
        },
      );
      stopLoadingHomePage();
      print(response.data.toString());
    } catch (e) {
      stopLoadingHomePage();
      print(e.response.data.toString());
    }
  }

  void shawAlertDialogLogin({BuildContext context, String msg, String title}) {
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
          onPressed: () {
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

//  addNewChalet({List<Map> days,List<File> images})async
//  {
//
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    var token = prefs.getString(Utility.TOKEN);
//
//     var stream1 = new http.ByteStream(DelegatingStream.typed(images[0].openRead()));
//     var length2 = await images[0].length();
//
//
//    var uri = Uri.parse(_apiAddChalets+token);
//    var request = new http.MultipartRequest("POST", uri,);
//
//
//
//
//
//
//    var multipartFileImages1 = new http.MultipartFile('image',images,);
//
//    var multipartFileImages = new http.MultipartFile('days', stream, length,filename: basename(imageFile.path));
//
//    List<http.MultipartFile>imagesList=List<http.MultipartFile>();
//    imagesList.add(value)
//
//
//    request.fields['days'] = "${days}";
//
//
//    request.files.;
//    request.
//
//    //----------------------Send Request for Server-----------------------//
//    var response = await request.send();
//
//    print(response.statusCode);
//
//    ///===================================================================  Response ======================================================================//
//    response.stream.transform(utf8.decoder).listen((value)
//    {
//      print("===============ResponseUPDATEUser 2=======${value}=============================");
//      //------------------- Receive Response in Server ---------------------//
//      var data=json.decode(value);
//
//      print("=========Status for Create Adver 2======"+data['status']+"======================");
//
//      ///========================================= Check the Status Response (SUCCESS)====================================//
//      if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
//      {
//        notifyListeners();
//        stopLoading();
//
//        openAccount(context);
//
//      }
//      ///========================================= Check the Status Response (=====FAILED===) ====================================//
//      else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
//      {
//        stopLoading();
//
//      }else
//      {
//        stopLoading();
//        print("=========================== VERIFICATION_CODE Not compatible with schema =======================");
//
//      }
//
//    });
//
//
//  }

//    Future getAllChalet({BuildContext context}) async {
//
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    var token = prefs.getString(Utility.TOKEN);
//
//    var response   =  await http.get(_apiGetAllChalets+token);
//
//    //----------------------Send Request for Server-----------------------//
//    var data=json.decode(response.body);
//
//
//
//     return data;
//  }

////  getAllChalet({BuildContext context})async
////  {
////    SharedPreferences prefs = await SharedPreferences.getInstance();
////    var token = prefs.getString(Utility.TOKEN);
////
////
////
////
////
////
//////    var uri = Uri.parse(_apiGetAllChalets+token);
//////
//////    var request = new http.Request("GET", uri,);
//////
//////
//////    //----------------------Send Request for Server-----------------------//
//////    var response = await request.send();
//////
//////    print(response.statusCode);
//////    ///===================================================================  Response ======================================================================//
//////    response.stream.transform(utf8.decoder).listen((value)async
//////    {
//////    //  print("===============Respons Test=======${value}=============================");
//////      //------------------- Receive Response in Server ---------------------//
//////      var data=await json.decode(value);
//////
//////      print("=========Status for Create Test======"+data['data']+"======================");
//////
//////      ///========================================= Check the Status Response (SUCCESS)====================================//
//////      if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
//////      {
//////
////////        (data['data'] as List).forEach((f)
////////        {
////////          AdvertiserChalets Advertise=AdvertiserChalets.fromJson(f);
////////
////////          print("=========index Test=========${Advertise.status}==================");
////////        });
//////
//////
//////
//////      }
//////      ///========================================= Check the Status Response (=====FAILED===) ====================================//
//////      else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
//////      {
//////
//////      //  var error =AdvertiserNoChalets.fromJson(data);
//////     //   print("============================ Get All ChALET ${error.error[0]} =================");
//////        //------------Shaw Dialog ---------------//
//////        //shawAlertDialog(context: context,msg:error.error.email[0]);
//////
////////        print("========================== aasss ======= ${data.toString()} ========================");
////////        var resultFailed = TokenFailed.fromJson(data);
////////        var contentError=resultFailed.error.email[0];
////////
////////        print("======= VERIFICATION_CODE_FAILED ======== Done ${contentError} ==================");
////////        stopLoading();
////////
////////        //------------Shaw Dialog ---------------//
////////        //----TODO alert
////////        shawAlertDialog(context: context,msg: contentError,flagTypeUser: "3");
//////
//////      }else
//////      {
//////        stopLoading();
//////        print("=========================== VERIFICATION_CODE Not compatible with schema =======================");
//////      }
//////
////
////
////    });
//
//
////    //------------------- Send Request in Server ---------------------//
////    Map<String, String> headers = {"Accept": "application/json"};
////    var response = await http.get(_apiGetAllChalets+token,headers: headers ,);
////     //------------------- Receive Response in Server ---------------------//
////    var data=json.decode(response.body);
////
////    print("==================================== Print Response Chalet = ${data.toString()}=======================");
////
////
////  //   List<AdvertiserChalets>dataAdvertiserList;
////    ///========================================= Check the Status Response (SUCCESS)====================================//
////    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
////    {
////
//////      dataAdvertiserList = new List<AdvertiserChalets>();
//////      dataAdvertiserList =( data['data']as List).map((item)=>AdvertiserChalets.fromJson(item)).toList();
////
////
////            (data['data'] as List).forEach((f)
////            {
////              AdvertiserChalets Advertise=AdvertiserChalets.fromJson(f);
////
////              print("=========index=========${data['data']}==================");
////            });
////
////         // (json["descriptions"] as List).map((item)=>Images.fromJson(item)).toList()
////
////      print("======================Test==Length  ==========================");
////
////     // inPutAllChaletAdvertiser.add(dataAdvertiserList);
////
////
////
////    }
////    ///========================================= Check the Status Response (FAILED)====================================//
////    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
////    {
////      var error =AdvertiserNoChalets.fromJson(data);
////      print("============================ Get All ChALET ${error.error[0]} =================");
////      //------------Shaw Dialog ---------------//
////      //shawAlertDialog(context: context,msg:error.error.email[0]);
////    }else
////    {
////      stopLoading();
////      print("=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
////      if(data["message"]=="Unauthenticated.")
////      {
////        shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:data["message"]);
////      }
////
////    }
//
//    //notifyListeners();
//  }

//  getAllOffers({BuildContext context})async
//  {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    var token = prefs.getString(Utility.TOKEN);
//
//    //------------------- Send Request in Server ---------------------//
//    Map<String, String> headers = {"Accept": "application/json"};
//    var response = await http.post(_apiGetAllOffers+token,headers: headers ,body: {});
//
//    //------------------- Receive Response in Server ---------------------//
//    var data=json.decode(response.body);
//
//    print("==================================== Print Response Chalet = ${data}=======================");
//
//
//    ///========================================= Check the Status Response (SUCCESS)====================================//
//    if(data['status']==Utility.VERIFICATION_CODE_SUCCESS)
//    {
//
//      inPutAllOffersAdvertiser.add(AdvertiserChalets.fromJson(data));
//
//      // notifyListeners();
//    }
//    ///========================================= Check the Status Response (FAILED)====================================//
//    else if(data['status']==Utility.VERIFICATION_CODE_FAILED)
//    {
//      var error =AdvertiserNoChalets.fromJson(data);
//      print("============================ Get All ChALET ${error.error[0]} =================");
//      //------------Shaw Dialog ---------------//
//      //shawAlertDialog(context: context,msg:error.error.email[0]);
//    }else
//    {
//      stopLoading();
//      print("=========================== VERIFICATION_CODE Not compatible with schema${data["message"]} =======================");
//      if(data["message"]=="Unauthenticated.")
//      {
//        shawAlertDialogLogin(context: context,msg: "برجاء تسجيل الدخول",title:data["message"]);
//      }
//
//    }
//
//    //notifyListeners();
//  }

}
