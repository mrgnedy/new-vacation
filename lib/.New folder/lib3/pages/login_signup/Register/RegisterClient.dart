import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacatiion/ScopedModels/ScopedModelVerification.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:vacatiion/utility/utility_class.dart';
import '../PinEntryPages.dart';
import '../login_page.dart';
import 'package:quiver/strings.dart';

//-----تسجيل المستخدم
class RegisterClient extends StatefulWidget {
  @override
  _RegisterClientState createState() => _RegisterClientState();
}

class _RegisterClientState extends State<RegisterClient> {

  ScopedModelVerification scopedModelVerification;

    @override
  void initState()
    {
      scopedModelVerification=ScopedModelVerification();
      scopedModelVerification.stopLoading();
    // TODO: implement initState
    super.initState();
  }


  //---------------- Variable Inputs -----------------//
  final _formKeyInputs = GlobalKey<FormState>();

   //---For Test ConfirmPassword------//
  var passKey=GlobalKey<FormFieldState>();

  bool checkValidate=false;

  String name='' ;
  String email ='';
  String phone = '';
  String password = '';
  String confirmPassword = '';


  void validateAndSave()
  {
    final form = _formKeyInputs.currentState;
    if(form.validate())
    {
        //----------Shaw Loading------------//
      scopedModelVerification.showLoading();
       form.save();
       print('=================== Form is valid Sucessful=====================');

       ///------------------- send Data to Verification ---------------------//
      scopedModelVerification.getVerificationUser(name,email,phone,password,context);

    }
    else
    {
      print('====================form is invalid=================');
    }
  }



  @override
  Widget build(BuildContext context) {



    return ScopedModel<ScopedModelVerification>(
       model: scopedModelVerification,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<ScopedModelVerification>(
                  builder: (context,_,model)
                  {

                    return Stack(children: <Widget>
                    [
                      //-------------------- Content--------------------//
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
                                SizedBox(
                                  height: 3,
                                ),

                                //---------------------------TextField User Name------------------------//
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
                                          name = value;
                                        },
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        textAlign: TextAlign.right,
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
                                //phone
                                SizedBox(
                                  height: 3,
                                ),
                                //---------------------------TextField Email--------------------------------//
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
                                          email = value;
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
                                //--------------------------TextField Phone--------------------------------//
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
                                          phone = value;
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
                                      child: TextFormField(
                                        key: passKey,
                                        autovalidate: checkValidate,
                                        validator: (value)
                                        {
                                          return Utility.validatePassword(value);
                                        },
                                        onSaved: (String value)
                                        {
                                          password = value;
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
                                //-------------------------------TextField ConfirmPassword----------------//
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
                                          ///------------------ --------------------//
                                          if (confirmPassword.isEmpty) return 'من فضلك اعد تأكيد كلمة المرور';
                                          var password = passKey.currentState.value;
                                          if (!equalsIgnoreCase(confirmPassword, password))
                                            return 'كلمة المرور غير صحيحة';
                                         },
                                        onSaved: (String value)
                                        {
                                          confirmPassword = value;
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
                                ///=============================================== Button New Register =======================================================//
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
                                          setState(()
                                          {
                                            checkValidate=true;
                                          });
                                          validateAndSave();
                                        }
                                      }
                                      );
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
                                ///-------------------------------  Text  لدي حساب  ----------------------------------//
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                        onTap: ()
                                        {
                                          //LoginPage
                                          Navigator.pushReplacement(context, SizeRoute(page: LoginPage()));

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
                      //-------------------------- Visibility loading -------------------------//
                      Visibility (
                        visible: ScopedModelVerification.isLoading,
                        child: Center(child: Utility.buildLoading()),
                      ),
                    ]

                      ,);
                  },
        ),
      ),
    );
  }






}

