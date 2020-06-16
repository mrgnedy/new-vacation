import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:core';

import 'dart:io';
import 'dart:ui';
// import 'package:access_settings_menu/access_settings_menu.dart';
import 'package:app_settings/app_settings.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:collection/collection.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vacatiion/pages/login_signup/login_page.dart';

import 'colors.dart';



class Utility {


  //===================Status for Verification Code================//
  static String VERIFICATION_CODE_SUCCESS="success";
  static String VERIFICATION_CODE_FAILED="failed";

  //=====================Constant for Save private data for login or Register====================//
  static String ROLE_ID="role_id";
  static String TOKEN="token";
  static String OS_Platform="Platform";
  static String Device_Token="DeviceToken";
  //=========================Variable for SharedPreferences type "User"=======================//
   static String  ShARED_USER_NAME="nameUser";
   static String  ShARED_USER_EMAIL="emailUser";
   static String  ShARED_USER_PHONE="phoneUser";
   static String  ShARED_USER_PASSWORD="passwordUser";
  //=========================Variable for SharedPreferences type "Adver"=======================//
   static String ShARED_Advertiser_NAME='AdvertiserName';
  static String ShARED_Advertiser_EMAIL='AdvertiserEmail';
  static String ShARED_Advertiser_PHONE='AdvertiserPhone';
  static String ShARED_Advertiser_BANK_NAME='AdvertiserBankName';
  static String ShARED_Advertiser_Account_NAME='AdvertiserAccountName';
  static String ShARED_Advertiser_ACCOUNT_NUMBER='AdvertiserNumber';
  static String ShARED_Advertiser_IBAN_NUMBER='AdvertiserIbanNumber';
  static String ShARED_Advertiser_PASSWORD='AdvertiserPassword';
  static String ShARED_Advertiser_IMAGEUSER='AdvertiserImageUser';
  static String ShARED_Advertiser_UpdateAt='UpdateAt';



  //========================Validation for Input====================//
  static Function eq = const ListEquality().equals;
  static String validateName(String value)
  {
    if (value.isEmpty)
      return 'الاسم مطلوب';
//    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
//    if (!nameExp.hasMatch(value))
//      return 'من فضلك ادخل حروف';
    return null;
  }
  static String validateEmail(String value)
  {
    if (value.isEmpty) return 'الايميل مطلوب';
    final RegExp nameExp = new RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
    if (!nameExp.hasMatch(value)) return 'الايميل غير صحيح';
    return null;
  }
  static String validatePassword(String value)
  {
    if (value.isEmpty)
      return 'كلمة المرور مطلوبه';
    else if (value.length < 8)
      return 'يجب أن تتألف كلمه المرور من 8 أحرف أو أكثر';
    return null;
  }




  //=======================Shaw Loading Progress========================//
 static Widget buildLoading()
  {
//    return CircularProgressIndicator(
//      valueColor: new AlwaysStoppedAnimation<Color>(
//          ColorsV.defaultColor),
//    );

     return SpinKitCircle(color: ColorsV.defaultColor);
  }


 ///================================
  static Future<bool> checkInternetConnection(BuildContext context)async
  {

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile)
    {
      // I am connected to a mobile network.
       print("======================= // I am connected to a mobile network.=================") ;

      return  true;

    } else if (connectivityResult == ConnectivityResult.wifi)
    {
      // I am connected to a wifi network
      print("======================= // I am connected to a wifi network ====================") ;

     return  true;

    }else if (connectivityResult == ConnectivityResult.none)
    {
      Utility.showToast("تأكد من اتصال الانترنت",context: context,duration:Toast.LENGTH_LONG,chooseColor: 1,gravity:Toast.BOTTOM);

      return   false;
    }

  }
  ///============================== Method Show Toast ===================//
  static void showToast(String msg, {int duration, int gravity, int chooseColor,BuildContext context}) {
    Color colorB;

    if (chooseColor == 1) {
      colorB = Color(0xffa10705);
    }
     else if(chooseColor==4)
     {
       colorB = Color(0xff508854);
     }
    else {
      colorB = const Color(0xff1F1B62);
    }

    Toast.show(msg, context,
        duration: duration, gravity: gravity, backgroundColor: colorB);
  }
///================================== AppBar ============================//
 static Widget buildAppBar(String title) {
    return AppBar(
      actions: <Widget>[
        ///------------------------------Icon Right-----------------//
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Image.asset(
              "assets/icon_social/group_6420.png",
              width: 150,
              height: 150,
            ),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAppBuble())); //TODO
            },
          ),
        ),
      ],
      backgroundColor: Color(0xFAFAFAFA),
      elevation: 1,
    );
  }

static final String stringTest="هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام هنا يوجد محتوى نصي، هنا يوجد محتوى نصي  فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء. العديد من برامح النشر المكتبي وبرامح تحرير صفحات الويب تستخدم لوريم إيبسوم بشكل إفتراضي كنموذج عن النص، وإذا قمت بإدخال  lorem ipsum في أي محرك بحث ستظهر العديد من المواقع الحديثة العهد في نتائج البحث. على مدى السنين ظهرت نسخ جديدة ومختلفة من نص لوريم إيبسوم، أحياناً عن طريق الصدفة، وأحياناً عن عمد كإدخال بعض العبارات الفكاهية إليها";

   //----------------------Style AlertDialog ---------------//
   static var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: true,
    isOverlayTapDismiss: true,

    descStyle: TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        color: ColorsV.defaultColor,
        width: 5,
        style: BorderStyle.solid
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );
   //----------------------Show Dialog--------------------------//


 //-----------------logOut-------------------//
  static void logOut()async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Utility.TOKEN, "");
    pref.setInt(Utility.ROLE_ID, 0);

  }
  ///-----------------open PAge Login------------------------//
   static void openLoginAccount(BuildContext context)
  {
    Utility.logOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));

  }

  static void backPage(BuildContext context)
  {
    Navigator.pop(context);
  }


  ///---------------------------------------------Ath
  Widget drawSingleTextFormField({
    TextEditingController controller,
    String labelText,
    String validatorWarning,
    String hintText,
    TextStyle labelStyle,
    TextInputType keyboardType,
    TextStyle hintStyle,
    TextAlign textAlign,
    IconData icon,
    bool secure,
    int maxLines,
  }) {
    return TextFormField(
      textAlign: textAlign,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      obscureText: secure,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) {
        if (value.isEmpty) {
          return validatorWarning;
        }
        return null;
      },
    );
  }

  Widget loading() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget drawSectionTitle(String title,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.40,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.indigo,
              fontFamily: 'DinNextMedium',
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }


  //--------------------permissions--------------------------------//
  static void shawAlertDialogFailed({BuildContext context,String msg,String title})
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

  static void shawAlertDialogFailedLocation({BuildContext context,String msg,String title})
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
            "تفعيل GPS ",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()
          {
            Navigator.pop(context);
            openSettingsMenu("ACTION_LOCATION_SOURCE_SETTINGS");
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
  static void shawAlertDialogFailedLoginPage({BuildContext context,String msg,String title})
  {
    Alert(
      context: context,
      type: AlertType.info,
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
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
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
  static openSettingsMenu(settingsName) async {
    var resultSettingsOpening = false;

    try
    {
      await AppSettings.openAppSettings();

        if(resultSettingsOpening)
        {
          print("---------open location-----${resultSettingsOpening}");
        }

    } catch (e)
    {
      resultSettingsOpening = false;
    }
  }

  static void shawAlertDialogSuccess({BuildContext context,String msg,String title})
  {
    Alert(
      context: context,
      type: AlertType.success,
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

}

