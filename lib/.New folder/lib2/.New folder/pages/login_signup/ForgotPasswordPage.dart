import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModelForgotPassword.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'PinEntryPages.dart';


class ForgotPasswordPage extends StatefulWidget
{
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {




  ScopedModelForgetPassword _scopedModelForgetPassword;

  //---------------- Variable Inputs -----------------//
  final _formKeyInputs = GlobalKey<FormState>();
  bool checkValidate=false;

  String email ='';

  @override
  void initState()
  {
    _scopedModelForgetPassword=ScopedModelForgetPassword();
    _scopedModelForgetPassword.stopLoading();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //-------   hide Status Bar  ------------------//
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return ScopedModel<ScopedModelForgetPassword>(
          model: _scopedModelForgetPassword,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<ScopedModelForgetPassword>(
            builder: (context,_,model)
        {
          return Form(
            key: _formKeyInputs,
            child: Stack(children: <Widget>
            [
              ListView(

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
                      SizedBox(height: 25, ),
                      ///------------------------------  Button Send ----------------------------------//
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
                ],
              ),
              Visibility (
                visible: ScopedModelForgetPassword.isLoading,
                child: Center(child: Utility.buildLoading()),
              ),
            ],),
          );
        }),
      ),
    );
  }


  void validateAndSave(){
    final form = _formKeyInputs.currentState;
    if(form.validate())
    {
      //----------Shaw Loading------------//
      _scopedModelForgetPassword.showLoading();
      form.save();
      print ('=================== Form is valid Sucessful=====================');
      ///--------------------  send Data to Verification  ---------------------//
      _scopedModelForgetPassword.forgotPasswordByEmail(email,context);
    }
    else
    {
      print('====================form is invalid=================');
    }
  }

}
