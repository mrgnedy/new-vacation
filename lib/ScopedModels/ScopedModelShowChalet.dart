import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
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
import 'package:vacatiion/model/ShowChaletModel.dart';
import 'package:vacatiion/model/SuccessAvailableModel.dart';
import 'package:vacatiion/model/SuccessReservationModel.dart';
import 'package:vacatiion/model/user/UpdateUser.dart';
import 'package:vacatiion/pages/SubPages/OffersPage.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Payments/PageCoupon.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Payments/Payment_info.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Payments/ReservationPaymentPageBank.dart';
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

class ScopedModelShowChalet extends Model {
  static bool loadingPage = false;
  static bool loadingPageCopun = false;

  //-------------- Loading Home PAGE ----------------//
  showLoadingPage() {
    loadingPage = true;
    notifyListeners();
  }

  stopLoadingPage() {
    loadingPage = false;
    notifyListeners();
  }

  //------------------------------//
  showLoadingPageCopun() {
    loadingPageCopun = true;
    notifyListeners();
  }

  stopLoadingPageCopun() {
    loadingPageCopun = false;
    notifyListeners();
  }

  ///-------------------------------------------------------- StreamController Chalet -------------------------------------------//
  StreamController<ShowChalet> streamControllerShowChalet;
  //----------Start stream-----------//
  initialStreamControllerShowChalet() {
    streamControllerShowChalet = StreamController<ShowChalet>.broadcast();
  }

  //---------------------- Input and Output Stream Get All Chalet ----------------------//
  Stream<ShowChalet> get outStreamShowChalet =>
      streamControllerShowChalet.stream;
  Sink<ShowChalet> get inPutStreamShowChalet => streamControllerShowChalet.sink;
  //----------Stop stream----------//
  void disposeStreamControllerShowChalet() {
    streamControllerShowChalet.close();
  }

  ///----------------------------------Api-----------------------------------//
  String _apiGetShowChalet = ApiUtilities.baseApi + ApiUtilities.showChalet;
  String _apiCheckChlet =
      ApiUtilities.baseApi + ApiUtilities.checkChaletAvailable;
  String _apiCheckReservations =
      ApiUtilities.baseApi + ApiUtilities.couponReservations;
  String _apiEndreservations =
      ApiUtilities.baseApi + ApiUtilities.reservationsBill;
  String _apiPaymentInfo = ApiUtilities.baseApi + ApiUtilities.paymentInfo;
  String _apiCheckStatus = ApiUtilities.baseApi + ApiUtilities.checkStatus;
  String _apiAddChaletToOffers =
      ApiUtilities.baseApi + ApiUtilities.addChaletToOffers;

  String _apiRemoveOffers = ApiUtilities.baseApi + ApiUtilities.removeOffer;
  String _apiShowSkipeChalets =
      ApiUtilities.baseApi + ApiUtilities.skipShowhalehat;
  String _apiConfirmPaymentVisa =
      ApiUtilities.baseApi + ApiUtilities.payWithVisa;

  String chName = '';
  String advNum = '';
  String advName = '';
  String advEmail = '';
  Future getDataForChalet({BuildContext context, int chaletId}) async {
    //showLoadingPage();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    final response = await http.get(
        _apiGetShowChalet + "${chaletId}?token=" + token,
        headers: {"Accept": "application/json"});

    var data = json.decode(response.body);

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
      inPutStreamShowChalet.add(ShowChalet.fromJson(data));
      Chalet chalet = ShowChalet.fromJson(data).data.chalet;
      chName = chalet.name;
      advNum = chalet.advNum;
      advName = chalet.advName;
      advEmail = chalet.advEmail;

      print(
          "-------------------------Show Chalet----------------${ShowChalet.fromJson(data).data.chalet.id}");
      //stopLoadingPage();
    }

    ///========================================= Check the Status Response (FAILED)====================================//
    else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
      var error = AdvertiserNoChalets.fromJson(data);
      print(
          "============================ Get All ChALET ${error.error[0]} =================");
      stopLoadingPage();
      //------------Shaw Dialog ---------------//
      //shawAlertDialog(context: context,msg:error.error[0]);
    } else {
      stopLoadingPage();
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

  Future editChaletStatus({
    context,
    int chaletID,
    String startDate,
    String endDate,
    int status,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);
    final request = await http.MultipartRequest(
        'POST', Uri.parse('$_apiCheckStatus+$token'));
    prefix0.print(chaletID);
    request.fields['chalet_id'] = chaletID.toString();
    request.fields['status'] = status.toString();
    request.fields['startDate'] = startDate.toString();
    request.fields['endDate'] = endDate.toString();
    // request.fields['total_price'] = '0';
    // final response = await http.post('$_apiCheckStatus$token',
    //     body: json.encode({
    //       'chalet_id': chaletID.toString(),
    //       'status': status.toString(),
    //       'startDate': startDate,
    //       'endDate': endDate,
    //     }),
    //     headers: {"Accept": "application/json"});
    final response = await request.send();
    print('THIS IS MESSAGE ${(response.reasonPhrase)}');
    // if(response.statusCode.toString().startsWith('2'));
    Utility.shawAlertDialogSuccess(context: context, msg: 'تم تغيير حالة الشاليه الى ${status==1? 'محجوز': 'متاح'}');
    // Utility.showToast('تم تعديل حالة الشاليه', gravity: Toast.BOTTOM, chooseColor: 1);
    // else
    // Utility.showToast('تم تعديل حالة الشاليه', gravity: Toast.BOTTOM, chooseColor: 2);
  }

  Future getDataForChaletSkipe({BuildContext context, int chaletId}) async {
    //showLoadingPage();

    final response = await http.get('$_apiShowSkipeChalets${chaletId.toString().trim()}',
        headers: {"Accept": "application/json"});

    var data = json.decode(response.body);

    print("${data}");

    ///========================================= Check the Status Response (SUCCESS)====================================//
    if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
      inPutStreamShowChalet.add(ShowChalet.fromJson(data));
      print(
          "-------------------------Show Chalet----------------${ShowChalet.fromJson(data).data.chalet.id}");
      //stopLoadingPage();
    }

    ///========================================= Check the Status Response (FAILED)====================================//
    else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
      var error = AdvertiserNoChalets.fromJson(data);
      print(
          "============================ Get All ChALET ${error.error[0]} =================");
      stopLoadingPage();
      //------------Shaw Dialog ---------------//
      //shawAlertDialog(context: context,msg:error.error[0]);
    } else {
      stopLoadingPage();
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

  set setPrice(p) => price = p;
  num price;
  Future getCheckChalet(
      {BuildContext context, String chaletId, String Start, String end}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);

    var uri = Uri.parse(_apiCheckChlet + token);

    var request = new http.MultipartRequest(
      "POST",
      uri,
    );
    print(Start);
    print(end);
    request.fields['chalet_id'] = chaletId;
    request.fields['startDate'] = Start;
    request.fields['endDate'] = end;
    request.fields['total_price'] = "$price";

    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      //------------------- Receive Response in Server ---------------------//
      var data = json.decode(value);

      print("=========Status for Create Adver======" +
          value.toString() +
          "======================");

      ///========================================= Check the Status Response (SUCCESSs)====================================//
      if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
        var re = SuccessAvailable.fromJson(data);
        openEditPageCoupon(
            chaletName: re.data.chalet,
            context: context,
            end: re.data.endDate,
            chaletId: chaletId,
            price: price.toString(),
            start: re.data.startDate);
      }

      ///========================================= Check the Status Response (=====FAILED===) ====================================//
      else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
        shawAlertFailed(
            context: context,
            msg: "الشاليه غير متاح فى هذه الفتره",
            title: "فتره الحجز");
      } else {
        print(
            "=========================== VERIFICATION_CODE Not compatible with schema =======================");
      }
    });
  }

  Future getPaymentInfo(
      {SuccessReservationModel reservBill, String id, context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(Utility.TOKEN);
    var uri = Uri.parse(_apiPaymentInfo + token);
    var request = new http.MultipartRequest(
      "POST",
      uri,
    );
    request.fields['total_price'] = price.toString();
    request.fields['chalet_id'] = id;
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {
      var data = json.decode(value);

      print("=========Status for Create Adver======" +
          value.toString() +
          "======================");

      ///========================================= Check the Status Response (SUCCESS)====================================//
      if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
        stopLoadingPageCopun();
        // var re = SuccessReservationModel.fromJson(data);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentInfo(
                      chaletID: id.toString(),
                      discount:
                          data['data']['infodata'][0]['discount'].toString(),
                      arboon: data['data']['infodata'][0]['deposit'] == null
                          ? '0'
                          : data['data']['infodata'][0]['deposit'].totring(),
                      total:
                          data['data']['infodata'][0]['total_price'].toString(),
                      s: reservBill,
                    )));
        // openConfirmationPageBank(context: context, m: re);
      }

      ///========================================= Check Refer ====================================//
      else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
        stopLoadingPageCopun();
        shawAlertFailed(context: context, msg: "", title: "");
      } else {
        print(
            "=========================== VERIFICATION_CODE Not compatible with schema =======================");
      }
    });
  }

  Future confirmPayment(context,
      {String amount,
      String currency,
      String brand,
      String number,
      String holder,
      String expiryMonth,
      String expiryYear,
      String cvv,
      String reservationId}) async {
    showLoadingPage();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString(Utility.TOKEN);
    return http.post('$_apiConfirmPaymentVisa+$token', body: {
      'amount': amount,
      'currency': currency,
      'brand': brand,
      'number': number,
      'holder': holder,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvv': cvv,
      'reservation_id': reservationId,
    }).then((response) {
        stopLoadingPage();
      if (response.statusCode.toString().startsWith('2')) {
        sendEmail();
        Utility.shawAlertDialogSuccess(
            context: context,
            msg: 'تم اتمام عملية الدفع بنجاح',
            title: 'نجحت العملية');
      } else
        Utility.shawAlertDialogFailed(
            context: context,
            msg: 'تعذرت عملية الدفع من فضلك اعد المحاولة',
            title: 'فشلت العملية');

      // final Map data = json.decode(response.body);
      // print(data);
    });
  }

  Future addReservationChalet(
      {BuildContext context,
      String chaletId,
      String Start,
      String end,
      String coupon}) async {
    showLoadingPageCopun();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString(Utility.TOKEN);

    var uri = Uri.parse(_apiCheckReservations + token);
    var request = new http.MultipartRequest(
      "POST",
      uri,
    );

    request.fields['chalet_id'] = "${chaletId}";
    request.fields['coupon'] = "${coupon}";
    request.fields['startDate'] = "${Start}";
    request.fields['endDate'] = "${end}";
    request.fields['total_price'] = '${price.toString()}';

    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      //------------------- Receive Response in Server ---------------------//
      var data = json.decode(value);

      print("=========Status for Create Adver======" +
          value.toString() +
          "======================");

      ///========================================= Check the Status Response (SUCCESS)====================================//
      if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
        stopLoadingPageCopun();
        var re = SuccessReservationModel.fromJson(data);
        getPaymentInfo(context: context, id: chaletId, reservBill: re);
        print('re re ${re.data.iban}');
        return re;
        // Navigator.push(context, MaterialPageRoute(builder:(context)=>PaymentInfo() ));
        // openConfirmationPageBank(context: context, m: re);
      }

      ///========================================= Check Refer ====================================//
      else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
        stopLoadingPageCopun();
        shawAlertFailed(context: context, msg: "", title: "");
      } else {
        print(
            "=========================== VERIFICATION_CODE Not compatible with schema =======================");
      }
    });
  }

  reservationsBill(
      {String accountName,
      String bankName,
      String chaletId,
      File imageFile,
      BuildContext context}) async {
    showLoadingPage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Utility.TOKEN);

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(_apiEndreservations + token);

    var request = new http.MultipartRequest(
      "POST",
      uri,
    );

    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    request.fields['account'] = "${accountName}";
    request.fields['bank'] = "${bankName}";
    request.fields['reservation_id'] = "${chaletId}";

    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);

    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    ///===================================================================  Response ======================================================================//
    response.stream.transform(utf8.decoder).listen((value) async {
      print(
          "===============تأكيد الدفع=======${value.toString()}=============================");
      //------------------- Receive Response in Server ---------------------//
      var data = json.decode(value);

      print("=========Status for Create Adver======" +
          data['status'] +
          "======================");

      ///========================================= Check the Status Response (SUCCESS)====================================//

      if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
        shawAlertSuccess(
            context: context,
            title: "بيانات الحجز",
            desc: "تم حجز الشاليه بنجاح");
        await sendEmail();
        stopLoadingPage();
      }

      ///========================================= Check the Status Response (=====FAILED===) ====================================//
      else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
        stopLoadingPage();
      } else {
        stopLoadingPage();
        print(
            "=========================== VERIFICATION_CODE Not compatible with schema =======================");
      }
    });
  }

  Future addChaletToOffers(
      {BuildContext context,
      String chaletId,
      int discount,
      String startOffer,
      String endOffer}) async {
    showLoadingPage();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString(Utility.TOKEN);

    var uri = Uri.parse(
        _apiAddChaletToOffers + chaletId.trim() + "/addOffer?token=" + token);

    var request = new http.MultipartRequest(
      "POST",
      uri,
    );

    request.fields['discount'] = "${discount.toString()}";
    request.fields['offerstart_date'] = startOffer;
    request.fields['offerend_date'] = endOffer;

    //----------------------Send Request for Server-----------------------//
    var response = await request.send();

    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      //------------------- Receive Response in Server ---------------------//
      var data = json.decode(value);

      print("=========Add Chalet to Offers======" +
          data.toString() +
          "======================");

      ///========================================= Check the Status Response (SUCCESS)====================================//
      if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
        stopLoadingPage();
        shawAlertSuccess(
            context: context, title: "العروض", desc: "تم اضافه العرض بنجاح");
      }

      ///========================================= Check Refer ====================================//
      else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
        stopLoadingPage();
        shawAlertFailed(
            context: context,
            title: "العروض",
            msg: "لقد قمت بأضافه العرض من قبل");
      } else {
        stopLoadingPage();
        print(
            "=========================== VERIFICATION_CODE Not compatible with schema =======================");
      }
    });
  }

  Future removeOffer({BuildContext context, String chaletId}) async {
    showLoadingPage();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString(Utility.TOKEN);

    var uri = Uri.parse(
        _apiRemoveOffers + chaletId.trim() + "/removeOffer?token=" + token);

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

      print("=========Remove Offers=====" +
          data.toString() +
          "======================");

      ///========================================= Check the Status Response (SUCCESS)====================================//
      if (data['status'] == Utility.VERIFICATION_CODE_SUCCESS) {
        stopLoadingPage();
        shawAlertSuccess(
            context: context,
            title: "العروض",
            desc: "تم الحذف من العروض بنجاح");
      }

      ///========================================= Check Refer ====================================//
      else if (data['status'] == Utility.VERIFICATION_CODE_FAILED) {
        stopLoadingPage();
        shawAlertFailed(
            context: context,
            title: "العروض",
            msg: "لا توجد عروض او تم حذفه من قبل");
      } else {
        stopLoadingPage();
        print(
            "=========================== VERIFICATION_CODE Not compatible with schema =======================");
      }
    });
  }

  ///-----------------------------------Alert Massage---------------------------------//
  void shawAlertFailed({BuildContext context, String msg, String title}) {
    Alert(
      context: context,
      type: AlertType.info,
      title: title,
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

  void shawAlertSuccess({BuildContext context, String title, String desc}) {
    Alert(
      context: context,
      type: AlertType.success,
      title: title,
      desc: desc,
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

  ///-----------------------------------Open Ather PAge----------------------//
  void openEditPageCoupon(
      {BuildContext context,
      String price,
      String start,
      String end,
      String chaletId,
      String chaletName}) {
    Navigator.push(
        context,
        SizeRoute(
            page: PageCoupon(
          chaletId: chaletId,
          chaletName: chaletName,
          endDate: end,
          startDate: start,
          totalPrice: price,
        )));
  }

  void openConfirmationPageBank(
      {BuildContext context, SuccessReservationModel m}) {
    //ReservationConfirmationPage
    Navigator.pushReplacement(
        context,
        SizeRoute(
            page: ReservationPaymentPageBank(
          m: m,
        )));
  }

  sendEmail() async {
    final pref = await SharedPreferences.getInstance();
    final roleid = pref.get(Utility.ROLE_ID);

    String username = 'mrgnedy@gmail.com';
    String password = 'bgcf5kdww';
    String userEmail = pref.get(roleid == 2
        ? Utility.ShARED_USER_EMAIL
        : Utility.ShARED_Advertiser_EMAIL);
    String phoneNum = pref.get(roleid == 2
        ? Utility.ShARED_USER_PHONE
        : Utility.ShARED_Advertiser_PHONE);
    String userName = pref.get(roleid == 2
        ? Utility.ShARED_USER_NAME
        : Utility.ShARED_Advertiser_NAME);
    print('${pref.getString(Utility.ShARED_USER_EMAIL)}\n$advEmail');
    final smtp = gmail(username, password);
    final msg = Message()
      ..from = Address(username, 'AhmedGnedy')
      ..recipients = [userEmail, advEmail]
      ..text =
          'تم حجز شاليه $chName \nباسم: $userName\nجوال طالب الخدمة: $phoneNum\nاسم مقدم الخدمة:$advName \nجوال مقدم الخدمة: $advNum\n'
      ..subject = 'حجز شاليه';

    try {
      final sendr = await send(msg, smtp);
      print('Message sent: ' + sendr.toString());
    } catch (e) {
      print('Message not setn: ');
    }
  }
}
