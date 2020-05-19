import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacatiion/ScopedModels/ScopedModelVerification.dart';
import 'package:vacatiion/pages/mainPages/MainPageUser.dart';
import 'package:vacatiion/pages/mainPages/MainPageAdvertiser.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';


class PinEntryPage extends StatefulWidget
{
   final String codeVerify;
   final String flag;
   final File image;
   PinEntryPage({this.codeVerify,this.flag,this.image});
  @override
  _PinEntryPageState createState() => _PinEntryPageState();

}

class _PinEntryPageState extends State<PinEntryPage> {

  ScopedModelVerification scopedModelVerification;

    bool isShawDialog=false;
    String text;


  var name;
  var email;
  var password;
  var phone;
  var accountName;
  var accountNumber;
  var ibanNumber;
  var bankName;


  @override
  void initState()
  {
    scopedModelVerification=ScopedModelVerification();
    scopedModelVerification.stopLoading();
    checkData();
    super.initState();
  }

 //---------Fetch the local Data---------------//
  void checkData()
  {
    if(widget.flag == "2")
    {
      getDataForUser();
      print("========================================================222===============================");


    } else if(widget.flag=="3")
      {
          getDataForAdvertiser();
          print("========================================================3333===============================");
      }else
        {
          //Todo
          print("=====================================Flage = ${widget.flag}===========================");
        }
  }

  @override
  Widget build(BuildContext context) {
     //-----------------hide Status Bar------------------//
    //   SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

     print("===================Page Pin Code ${widget.codeVerify}============");
    return ScopedModel<ScopedModelVerification>(
      model: scopedModelVerification,
      child: Scaffold(
        backgroundColor: Colors.white,

        body: ScopedModelDescendant<ScopedModelVerification>(
          builder: (context,_,model)
        {
          return Stack(children: <Widget>
          [
            //-------------------Content----------------//
            ListView(
              children: <Widget>
            [
              Column(
                children: <Widget>[
                  //--------------------------Logo-----------------------------//
                  Container(
                    height: 240,
                    child: Stack(children: <Widget>
                    [
                      Image.asset("assets/background/background.png",width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset("assets/logo/logo.png",width: MediaQuery.of(context).size.width,fit: BoxFit.fill,)),
                    ],),
                  ),
                  SizedBox(height: 15,),
                  //-------------------Text h-------------------------------//
                  Center(child: Text(
                    "تم ارسال رمز التحقُّق إلى عنوان البريد الإلكتروني",
                    style: TextStyle(
                        color: ColorsV.defaultColor,
                        fontSize: 20,
                        fontFamily: 'DinNextRegular'),
                  ),),
                  SizedBox(height: 25,),
                  ///---------------------------pin numbers--------------------------------//
                  new VerificationCodeInput(
                    keyboardType: TextInputType.text,
                    length: 4,
                    onCompleted: (String value)
                    {
                       setState(() {
                         text=value;
                       });

                      for (int i = 0; i < value.length; i++)
                      {
                        if (widget.codeVerify[i] != value[i]) //is Not Correct
                            {
                          setState(()
                          {
                            isShawDialog=true;
                            return;
                          });
                        }else
                        {
                          setState(() {
                            isShawDialog=false;
                            return;
                          });
                        }
                      }

                      //--------------is Not Correct Shaw Dialog------------//
                      if(isShawDialog)
                      {
                        //TODO
                        shawDialog("من فضلك تأكد من كود التحقق");

                      }
                      return true;

                    },
                  ),
                  ///=============================================== Button Send============================//
                  SizedBox(height: 40, ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: InkWell(
                      onTap: ()
                      {
                        if(text==null)
                        {
                          shawDialog("ادخل كود التحقق اولا");
                         // scopedModelVerification.stopLoading();
                        }else
                          {
                            if(isShawDialog)///------------is Verification Code Failed---------//
                            {
                              shawDialog("ادخل كود التحقق اولا");

                            }else
                            {///--------------is Verification Code Successful---------------//
                              switch(widget.flag)
                              {
                                case "2":///==================================== User ==================================//
                                  {
                                    ///---TODO
                                    ///--SEND User Data into ApiUser
                                   scopedModelVerification.showLoading();
                                   scopedModelVerification.createNewAccountUser(name: name,email: email,phone: phone,password: password,context: context);
                                   scopedModelVerification.stopLoading();

                                  }
                                  break;
                              //--SEND User Data into Api Advertiser
                                case "3":///================================ Advertiser =================================//
                                  {

                                    print("=================================image${widget.image}=================================");
                                    if(widget.image!=null)
                                    {
                                      scopedModelVerification.showLoading();
                                      scopedModelVerification.createNewAccountAdvertiser(name: name,phone: phone,password: password,
                                      bankName: bankName,ibanNumber: ibanNumber,
                                      accountNumber: accountNumber,accountName: accountName,
                                      email: email,imageFile: widget.image,context: context);
                                     scopedModelVerification.stopLoading();

                                    }else
                                      {
                                        print("=========Error for File image Advertiser=======${widget.image}=====================");
                                      }


                                  }
                                  break;
                                default :
                                  {
                                    shawDialog("من فضلك اعد تسجيل الدخول");
                                  }
                              }

                              print("============Test========${name},${email}================");
                            }
                          }


                      },
                      child: Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/button_click/background_btn.png'),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: Text(
                            "إرسال",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),

                ],
              ),
            ],),
            //-------------------- progress loading------------------//
            Visibility (
              visible: ScopedModelVerification.isLoading,
              child: Center(child: Utility.buildLoading()),
            ),
          ],);
        },),
      ),
    );
  }


  //---------------send User Data for Server ------------------//
  void getDataForUser() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      name= pref.getString((Utility.ShARED_USER_NAME));
      email=pref.getString(Utility.ShARED_USER_EMAIL);
      phone=pref.getString(Utility.ShARED_USER_PHONE);
      password =pref.getString(Utility.ShARED_USER_PASSWORD);
    });

  }
  //-----method  Dialog for inCorrect Data----------//
  void shawDialog(String message)
  {
    Alert(
      context: context,
      type: AlertType.error,
      title: "خطأ في المصادقة",
      desc: message,
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

  void getDataForAdvertiser() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("===============================================ssssss=====================================");
    setState(() {
      name= pref.getString((Utility.ShARED_Advertiser_NAME));
      email=pref.getString(Utility.ShARED_Advertiser_EMAIL);
      phone=pref.getString(Utility.ShARED_Advertiser_PHONE);
      password =pref.getString(Utility.ShARED_Advertiser_PASSWORD);

      accountNumber=pref.getString(Utility.ShARED_Advertiser_ACCOUNT_NUMBER);
      accountName=pref.getString(Utility.ShARED_Advertiser_Account_NAME);
      ibanNumber=pref.getString(Utility.ShARED_Advertiser_IBAN_NUMBER);
      bankName=pref.getString(Utility.ShARED_Advertiser_BANK_NAME);
    });

  }

}

