import 'dart:io';
import 'package:quiver/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';
import 'package:vacatiion/ScopedModels/ScopedModelVerification.dart';
import 'package:vacatiion/utility/PickImage/ImagePickerHandler.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import '../PinEntryPages.dart';
import '../login_page.dart';

//تسجيل مقدم الخدمه
class RegisterAdvertiser extends StatefulWidget {
  @override
  _RegisterAdvertiserState createState() => _RegisterAdvertiserState();
}
class _RegisterAdvertiserState extends State<RegisterAdvertiser>with TickerProviderStateMixin,ImagePickerListener {


  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  //---------------- Variable Inputs -----------------//
  final _formKeyInputs = GlobalKey<FormState>();
//---For Test ConfirmPassword------//
  var passKey=GlobalKey<FormFieldState>();

  bool checkValidate=false;
  ScopedModelVerification scopedModelVerification;


  String nameText='' ;
  String emailText ='';
  String phoneText = '';
  String passwordText = '';
  String confirmPasswordText = '';
//  String IbanNumberText='';
//  String bankNameText='';
//  String accountNameText='';
//  String accountNumberText='';


  void validateAndSave(){
    final form = _formKeyInputs.currentState;

    if(form.validate())
    {
      passKey.currentState;
       if(_image==null)
       {
         shawAlertDialog(context: context,msg: "من فضلك اختر صوره شخصيه");
       }else
         {
           //----------Shaw Loading------------//
           scopedModelVerification.showLoading();
           form.save();
           print ('=================== Form is valid Sucessful=====================');


           if(passKey.currentState.value!=null)
           {
             ///--------------------   send Data to Verification  ---------------------//
             scopedModelVerification.getVerificationAdvertiser(name: nameText,password: passKey.currentState.value,
                 phone: phoneText,email: emailText,

                 context: context,image: _image);

           }

         }


    }
    else
    {
      print('====================form is invalid=================');
    }
  }

  @override
  void initState()
  {
    scopedModelVerification=ScopedModelVerification();
    scopedModelVerification.stopLoading();

    //-------------------------------------------For PickImage-------------------------//
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //-------hide Status Bar------------------//
  //  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return ScopedModel<ScopedModelVerification>(
      model: scopedModelVerification,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<ScopedModelVerification>(
            builder: (context,_,model)
        {
          return Stack(children: <Widget>
          [
            Form(
              key: _formKeyInputs,
              child: ListView(

                children: <Widget>[
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
                      SizedBox(height: 20,),
                      //---------------------------Choose Image User------------------------------//
                      InkWell(
                        onTap: ()
                        {
                          imagePicker.showDialog(context);
                        },
                        child: Card(
                          elevation: 3,
                          child: _image==null?Container(
                            height: 125,
                             width: 125,
                            padding: EdgeInsets.only(
                                left: 38.0, right: 38.0, top: 35.0, bottom: 35.0),
                            child: Image.asset("assets/icons/23.png"),
                            decoration: BoxDecoration(
                                border: new Border.all(
                                    color: Color(0xffD4D4D4),
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5.0,
                                    // has the effect of softening the shadow
                                    spreadRadius: 1.0,
                                    // has the effect of extending the shadow
                                    offset: Offset(
                                      0.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                color: Colors.white),

                          ):Image.file(_image,fit: BoxFit.cover,height: 150,width: 150,),
                        ),
                      ),
                      ///--------------------------- Name----------------------------------//
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Padding(
                          //Add padding around textfield
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              autovalidate: checkValidate,
                              validator: (value)
                              {
                                String message=Utility.validateName(value);

                                return message ;
                              },
                              onSaved: (String value)
                              {
                                nameText = value;
                              },
                              textAlign: TextAlign.right,
                              textInputAction: TextInputAction.next,

                              keyboardType: TextInputType.text,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Color(0xff1F1B62)),
                              //--------------------------------=====decoration=====-----------------------------//
                              decoration: InputDecoration(
                                //Add th Hint text here.
                                contentPadding: EdgeInsets.only(
                                    left: 8, right: 17, bottom: 9, top: 9),
                                hintText: "الاسم",
                                hintStyle: TextStyle(color: Colors.grey),
                                //-----------------Decoration no Active Click---------------//
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
                                  borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                ),
                                //-----------------Decoration Active Click---------------//
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      ///--------------------------- TextField Email --------------------------------//
                      Center(
                        child: Padding(
                          //Add padding around textfield
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              autovalidate: checkValidate,
                              validator: (value)
                              {
                                return Utility.validateEmail(value);
                              },
                              onSaved: (String value)
                              {
                                emailText = value;
                              },
                              textAlign: TextAlign.right,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Color(0xff1F1B62)),
                              //--------------------------------=====decoration=====-----------------------------//
                              decoration: InputDecoration(
                                //Add th Hint text here.
                                contentPadding: EdgeInsets.only(
                                    left: 8, right: 17, bottom: 9, top: 9),
                                hintText: "البريد الإلكتروني",
                                hintStyle: TextStyle(color: Colors.grey),
                                //-----------------Decoration no Active Click---------------//
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
                                  borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                ),
                                //-----------------Decoration Active Click---------------//
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //email
                      SizedBox(
                        height: 3,
                      ),
                      ///--------------------------TextField Phone--------------------------------//
                      Center(
                        child: Padding(
                          //Add padding around textfield
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              autovalidate: checkValidate,
                              validator: (value)
                              {
                                if(value.isEmpty)
                                {
                                  return 'رقم الجوال مطلوب';
                                }

                                return null;
                              },
                              onSaved: (String value) {
                                phoneText = value;
                              },
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Color(0xff1F1B62)),
                              //--------------------------------=====decoration=====-----------------------------//
                              decoration: InputDecoration(
                                //Add th Hint text here.
                                contentPadding: EdgeInsets.only(
                                    left: 8, right: 17, bottom: 9, top: 9),
                                hintText: "رقم الجوال",
                                hintStyle: TextStyle(color: Colors.grey),
                                //-----------------Decoration no Active Click---------------//
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
                                  borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                ),
                                //-----------------Decoration Active Click---------------//
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //phone
//                      SizedBox(
//                        height: 3,
//                      ),
//                      ///----------------------------TextField Bank name --------------------------------/
//                      Center(
//                        child: Padding(
//                          //Add padding around textfield
//                          padding: EdgeInsets.symmetric(horizontal: 40.0),
//                          child: Card(
//                            elevation: 3,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(20.0),
//                            ),
//                            child: TextFormField(
//                              autovalidate: checkValidate,
//                              validator: (value)
//                              {
//                                if(value.isEmpty)
//                                {
//                                  return 'اسم البنك مطلوب';
//                                }
//
//                                return null;
//                              },
//                              onSaved: (String value) {
//                                bankNameText = value;
//                              },
//                              keyboardType: TextInputType.text,
//                              textInputAction: TextInputAction.next,
//                              textAlign: TextAlign.right,
//
//                              textDirection: TextDirection.rtl,
//                              style: TextStyle(color: Color(0xff1F1B62)),
//
//                              //--------------------------------=====decoration=====-----------------------------//
//                              decoration: InputDecoration(
//                                //Add th Hint text here.
//                                contentPadding: EdgeInsets.only(
//                                    left: 8, right: 17, bottom: 9, top: 9),
//                                hintText: "اسم البنك",
//                                hintStyle: TextStyle(color: Colors.grey),
//                                //-----------------Decoration no Active Click---------------//
//                                enabledBorder: const OutlineInputBorder(
//                                  borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
//                                  borderRadius:BorderRadius.all(Radius.circular(20.0)),
//                                ),
//                                //-----------------Decoration Active Click---------------//
//                                focusedBorder: OutlineInputBorder(
//                                  borderSide: BorderSide(color: Colors.white),
//                                  borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
//                              ),
//
//                            ),
//                          ),
//                        ),
//                      ),
//                      //phone
//                      SizedBox(
//                        height: 3,
//                      ),
//                      ///---------------------------TextField Account Name------------------------//
//                      Center(
//                        child: Padding(
//                          //Add padding around textfield
//                          padding: EdgeInsets.symmetric(horizontal: 40.0),
//                          child: Card(
//                            elevation: 3,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(20.0),
//                            ),
//                            child: TextFormField(
//                              autovalidate: checkValidate,
//                              validator: (value)
//                              {
//                                if(value.isEmpty)
//                                {
//                                  return 'اسم صاحب الحساب مطلوب';
//                                }
//
//                                return null;
//                              },
//                              onSaved: (String value) {
//                                accountNameText = value;
//                              },
//                              keyboardType: TextInputType.text,
//                              textInputAction: TextInputAction.next,
//                              textAlign: TextAlign.right,
//                              textDirection: TextDirection.rtl,
//                              style: TextStyle(color: Color(0xff1F1B62)),
//
//                              //--------------------------------=====decoration=====-----------------------------//
//                              decoration: InputDecoration(
//                                //Add th Hint text here.
//                                contentPadding: EdgeInsets.only(
//                                    left: 8, right: 17, bottom: 9, top: 9),
//                                hintText: "اسم صاحب الحساب",
//                                hintStyle: TextStyle(color: Colors.grey),
//                                //-----------------Decoration no Active Click---------------//
//                                enabledBorder: const OutlineInputBorder(
//                                  borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
//                                  borderRadius:BorderRadius.all(Radius.circular(20.0)),
//                                ),
//                                //-----------------Decoration Active Click---------------//
//                                focusedBorder: OutlineInputBorder(
//                                  borderSide: BorderSide(color: Colors.white),
//                                  borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
//                              ),
//
//                            ),
//                          ),
//                        ),
//                      ),
//                      //phone
//                      SizedBox(
//                        height: 3,
//                      ),
//                      ///-------------------------- TextField Account Number -----------------------//
//                      Center(
//                        child: Padding(
//                          //Add padding around textfield
//                          padding: EdgeInsets.symmetric(horizontal: 40.0),
//                          child: Card(
//                            elevation: 3,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(20.0),
//                            ),
//                            child: TextFormField(
//                              autovalidate: checkValidate,
//                              validator: (value)
//                              {
//                                if(value.isEmpty)
//                                {
//                                  return 'رقم الحساب مطلوب';
//                                }
//
//                                return null;
//                              },
//                              onSaved: (String value)
//                              {
//                                accountNumberText  = value;
//                              },
//
//                              keyboardType: TextInputType.text,
//                              textInputAction: TextInputAction.next,
//                              textAlign: TextAlign.right,
//
//                              textDirection: TextDirection.rtl,
//                              style: TextStyle(color: Color(0xff1F1B62)),
//
//                              //--------------------------------=====decoration=====-----------------------------//
//                              decoration: InputDecoration(
//                                //Add th Hint text here.
//                                contentPadding: EdgeInsets.only(
//                                    left: 8, right: 17, bottom: 9, top: 9),
//                                hintText: "رقم الحساب",
//                                hintStyle: TextStyle(color: Colors.grey),
//                                //-----------------Decoration no Active Click---------------//
//                                enabledBorder: const OutlineInputBorder(
//                                  borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
//                                  borderRadius:BorderRadius.all(Radius.circular(20.0)),
//                                ),
//                                //-----------------Decoration Active Click---------------//
//                                focusedBorder: OutlineInputBorder(
//                                  borderSide: BorderSide(color: Colors.white),
//                                  borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
//                              ),
//
//                            ),
//                          ),
//                        ),
//                      ),
//                      //phone
//                      SizedBox(
//                        height: 3,
//                      ),
//                      //-------------------------------TextField Iban Number--------------------//
//                      Center(
//                        child: Padding(
//                          //Add padding around textfield
//                          padding: EdgeInsets.symmetric(horizontal: 40.0),
//                          child: Card(
//                            elevation: 3,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(20.0),
//                            ),
//                            child: TextFormField(
//
//                              autovalidate: checkValidate,
//                              validator: (value)
//                              {
//                                if(value.isEmpty)
//                                {
//                                  return 'رقم الايبان مطلوب';
//                                }
//
//                                return null;
//                              },
//                              onSaved: (String value)
//                              {
//                                accountNumberText  = value;
//                              },
//
//                              textAlign: TextAlign.right,
//                              keyboardType: TextInputType.text,
//                              textInputAction: TextInputAction.next,
//
//                              textDirection: TextDirection.rtl,
//                              style: TextStyle(color: Color(0xff1F1B62)),
//
//                              //--------------------------------=====decoration=====-----------------------------//
//                              decoration: InputDecoration(
//                                //Add th Hint text here.
//                                contentPadding: EdgeInsets.only(
//                                    left: 8, right: 17, bottom: 9, top: 9),
//                                hintText: "رقم الايبان",
//                                hintStyle: TextStyle(color: Colors.grey),
//                                //-----------------Decoration no Active Click---------------//
//                                enabledBorder: const OutlineInputBorder(
//                                  borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
//                                  borderRadius:BorderRadius.all(Radius.circular(20.0)),
//                                ),
//                                //-----------------Decoration Active Click---------------//
//                                focusedBorder: OutlineInputBorder(
//                                  borderSide: BorderSide(color: Colors.white),
//                                  borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
//                              ),
//
//                            ),
//                          ),
//                        ),
//                      ),

                      //Iban
                      SizedBox(
                        height: 3,
                      ),
                      //-------------------------------TextField Password-----------------------//
                      Center(
                        child: Padding(
                          //Add padding around textfield
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child:TextFormField(
                              key: passKey,
                              autovalidate: checkValidate,
                              validator: (value)
                              {
                                return Utility.validatePassword(value);
                              },
                              onSaved: (String value)
                              {
                                passwordText = value;
                              },

                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              textAlign: TextAlign.right,

                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Color(0xff1F1B62)),

                              //--------------------------------=====decoration=====-----------------------------//
                              decoration: InputDecoration(
                                //Add th Hint text here.
                                contentPadding: EdgeInsets.only(
                                    left: 8, right: 17, bottom: 9, top: 9),
                                hintText: "كلمه المرور",
                                hintStyle: TextStyle(color: Colors.grey),
                                //-----------------Decoration no Active Click---------------//
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
                                  borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                ),
                                //-----------------Decoration Active Click---------------//
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                              ),


                            ),
                          ),
                        ),
                      ),
                      //password
                      SizedBox(
                        height: 3,
                      ),
                       ///-------------------------------TextField ConfirmPassword----------------//
                      Center(
                        child: Padding(
                          //Add padding around textfield
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(

                              autovalidate: checkValidate,
                              validator: (confirmPassword)
                              {
                                if (confirmPassword.isEmpty) return 'من فضلك اعد تأكيد كلمة المرور';
                                var password = passKey.currentState.value;
                                if (!equalsIgnoreCase(confirmPassword, password))
                                  return 'كلمة المرور غير صحيحة';
                              },
                              onSaved: (String value)
                              {
                                confirmPasswordText = value;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              textAlign: TextAlign.right,

                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Color(0xff1F1B62)),
                              //--------------------------------=====decoration=====-----------------------------//
                              decoration: InputDecoration(
                                //Add th Hint text here.
                                contentPadding: EdgeInsets.only(
                                    left: 8, right: 17, bottom: 9, top: 9),
                                hintText: "تأكيد كلمة المرور",
                                hintStyle: TextStyle(color: Colors.grey),
                                //-----------------Decoration no Active Click---------------//
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE6E6E6), width: 0.0),
                                  borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                ),
                                //-----------------Decoration Active Click---------------//
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //confirm password
                      ///================================================= Button New Register ===================================================//
                      SizedBox(
                        height: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: InkWell(
                          onTap: ()
                          {


                                Utility.checkInternetConnection(context).then((onValue)
                                {
                                  if(onValue)
                                  {
                                    print("================UUU=====${Utility.checkInternetConnection(context)==false}======================");
                                    setState(()
                                    {
                                      checkValidate=true;
                                    });
                                    validateAndSave();

                                  }
                                });


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
                                "تسجيل جديد",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      //-------------------------Text لدي حساب--------------------------//
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                              onTap: ()
                              {
                                //LoginPage
                                Navigator.push(context, SizeRoute(page: LoginPage()));
                              },
                              child: Text(
                                "تسجيل دخول",
                                style: TextStyle(
                                    color: ColorsV.defaultColor, fontSize: 18),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text("-",
                              style:
                              TextStyle(color: ColorsV.defaultColor, fontSize: 18)),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "لدي حساب",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ],
              ),
            ),
            ///-------------------------------- Visibility loading ------------------------------------//
            Visibility (
              visible: ScopedModelVerification.isLoading,
              child: Center(child: Utility.buildLoading()),
            ),
          ],);
        }

        ),
      ),
    );
  }


  @override
  userImage(File _image)
  {
    setState(()
    {
      this._image = _image;

      print("========path======${_image.path}==================");
    });
  }



  void shawAlertDialog({BuildContext context,String msg,})
  {
    Alert(
      context: context,
      type: AlertType.info,
      title: "اكمل بياناتك",
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
