import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModelLogin.dart';
import 'package:vacatiion/pages/mainPages/FirstPage.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'ForgotPasswordPage.dart';
import 'PinEntryPages.dart';

//--------تسجيل مقدم الخدمه-------------------
class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  ScopedModelLogin _scopedModelLogin;


  @override
  void initState() {
    // TODO: implement initState
    _scopedModelLogin=ScopedModelLogin();
    _scopedModelLogin.stopLoading();

    super.initState();
  }





  //---------------- Variable Inputs -----------------//
  final _formKeyInputs = GlobalKey<FormState>();
  bool checkValidate=false;

  String email ='';
  String password ='';

  @override
  Widget build(BuildContext context) {
    //-------hide Status Bar------------------//
   // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return ScopedModel<ScopedModelLogin>(
        model: _scopedModelLogin,
      child: Scaffold(

        backgroundColor: Colors.white,
        body: ScopedModelDescendant<ScopedModelLogin>(
          builder: (context,_,model)
          {
            return Form(
              key: _formKeyInputs,
              child: Stack(children: <Widget>
              [
                ListView(
                  children: <Widget>
                  [
                    Column(
                      children: <Widget>[
                        //---------------------- Logo ----------------------//
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
                        ///--------------------------- TextField Email -------------------------//
                        Center(
                          child: Padding(
                            //Add padding around textfield
                            padding: EdgeInsets.symmetric(horizontal: 35.0),
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
                        SizedBox(
                          height: 5,
                        ),
                        ///-------------------------------TextField Password-----------------------//
                        Center(
                          child: Padding(
                            //Add padding around textfield
                            padding: EdgeInsets.symmetric(horizontal: 35.0),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextFormField(
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
                        ///=============================================Button New Register========================================//
                        SizedBox(height: 30, ),
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
                                  "تسجيل الدخول",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        ////--------------------هل نسيت كلمه المرور----------------------
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                                onTap: ()
                                {
                                  //ForgotPasswordPage
                                  Navigator.push(
                                      context, SizeRoute(
                                                        page: ForgotPasswordPage()));
                                },
                                child: Text(
                                  "هل نسيت كلمه المرور ؟",
                                  style: TextStyle(
                                      color: ColorsV.defaultColor,
                                      fontSize: 20,fontFamily: 'DinNextRegular'),
                                )),


                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //-------------------------Text لدي حساب--------------------------//
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                                onTap: ()
                                {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstPage()));
                                },
                                child: Text(
                                  "تسجيل جديد",
                                  style: TextStyle(
                                      color: ColorsV.defaultColor, fontSize: 20,fontFamily: 'DinNextRegular'),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Text("-",
                                style:
                                TextStyle(color: ColorsV.defaultColor, fontSize: 18,fontFamily: 'DinNextRegular')),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "ليس لدي حساب ",
                              style: TextStyle(color: Colors.grey, fontSize: 18,fontFamily: 'DinNextRegular'),
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
                Visibility (
                  visible: ScopedModelLogin.isLoading,
                  child: Center(child: Utility.buildLoading()),
                ),
              ],),
            );
          }

        ),
      ),
    );
  }

  void validateAndSave(){
    final form = _formKeyInputs.currentState;
    if(form.validate())
    {
      //----------Shaw Loading------------//
      _scopedModelLogin.showLoading();
      form.save();
      print ('=================== Form is valid Sucessful=====================');

      ///--------------------  send Data to Verification  ---------------------//
      _scopedModelLogin.loginAndGetToken(email,password,context);

    }
    else
    {
      print('====================form is invalid=================');
    }
  }

}
