import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModelUpdateUser.dart';
import 'package:vacatiion/model/Advertiser/UpdateAdvertiser.dart';
import 'package:vacatiion/model/user/UpdateUser.dart';
import 'package:vacatiion/utility/PickImage/ImagePickerHandler.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'dart:core' as prefix0;
import 'dart:core';
import 'package:path/path.dart';

class EditPersonalAccountUser extends StatefulWidget {


  @override
  _EditPersonalAccountUserState createState() => _EditPersonalAccountUserState();
}

class _EditPersonalAccountUserState extends State<EditPersonalAccountUser> {

  var nameText ;
  var emailText;
  var phoneText;

  ScopedModelUpdateUser get _scopedModelUpdateUser => GetIt.I<ScopedModelUpdateUser>();

  BuildContext _context;

  @override
  void initState()
  {
    _scopedModelUpdateUser.stopLoading();
    _scopedModelUpdateUser.getUpdateUser(context: _context);

    super.initState();
  }


  @override
  void dispose()
  {
    //---------Strime Biulder--------//
    // _scopedModelUpdateUser.dispose();
    super.dispose();
  }

  //---------------- Variable Inputs -----------------//
  final _formKeyInputs = GlobalKey<FormState>();

  bool checkValidate=false;

  void validateAndSave(BuildContext context){

    final form = _formKeyInputs.currentState;

    if(form.validate())
    {
        //----------Shaw Loading------------//
        _scopedModelUpdateUser.showLoading();
        form.save();
        _scopedModelUpdateUser.updateAccountUser(name: nameText,
                                                 phone: phoneText,
                                                 email: emailText,
                                                 context: context
                                           );
    }
    else
    {
      print('====================form is invalid=================');
    }
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      _context=context;
    });
    return ScopedModel<ScopedModelUpdateUser>(
      model: _scopedModelUpdateUser,
      child: Scaffold(
        body:
        ScopedModelDescendant<ScopedModelUpdateUser>(
            builder: (context,_,model)
            {
              return StreamBuilder<UpdateUser>(
                  stream: model.outUpdateUser,
                  builder: ( context,  snapshot)
                  {
                    switch (snapshot.connectionState)
                    {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return SpinKitCircle(color: ColorsV.defaultColor);
                      default:
                        if (snapshot.hasError)
                          return Center(child: new Text('Error: ${snapshot.error}'));
                        else
                          return  Form(
                            key: _formKeyInputs,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Stack(
                                children: <Widget>[
                                  ///============================ Content Page ==========================//
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: ListView(

                                        children: <Widget>[

                                          Column(
                                            children: <Widget>[
                                              ///============================================= Content ===============================================//
                                              SizedBox(
                                                height: 85,
                                              ),

                                              //---------------------------  Name ----------------------------------//
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: Padding(
                                                  //Add padding around textfield
                                                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                                                  child: Card(
                                                    elevation: 3,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20.0),
                                                    ),
                                                    child: TextFormField(
                                                      textAlign: TextAlign.center,
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
                                                      textInputAction: TextInputAction.next,
                                                      // controller: _textFieldControllerName,
                                                      initialValue:snapshot.data.data.profile.name??"" ,
                                                      keyboardType: TextInputType.text,
                                                      textDirection: TextDirection.rtl,
                                                      style: TextStyle(color: Color(0xff1F1B62)),
                                                      //--------------------------------=====decoration=====-----------------------------//
                                                      decoration: InputDecoration(
                                                        //Add th Hint text here.
                                                        contentPadding: EdgeInsets.only(
                                                            left: 8, right: 17, bottom: 12, top: 12),
                                                        hintText: "الاسم",
                                                        hintStyle: TextStyle(color: Colors.grey),
                                                        //-----------------Decoration no Active Click---------------//
                                                        enabledBorder: const OutlineInputBorder(
                                                          borderSide: const BorderSide(color: Color(0xff1F1B62), width: 0.0),
                                                          borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                                        ),
                                                        //-----------------Decoration Active Click---------------//
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Color(0xff1F1B62)),
                                                          borderRadius: BorderRadius.all(Radius.circular(20.0)), ),

                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              //---------------------------TextField Email--------------------------------//
                                              Center(
                                                child: Padding(
                                                  //Add padding around textfield
                                                  padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                                                      textAlign: TextAlign.center,
                                                      textInputAction: TextInputAction.next,
                                                      initialValue: snapshot.data.data.profile.email??"",
                                                      keyboardType: TextInputType.emailAddress,
                                                      textDirection: TextDirection.rtl,
                                                      style: TextStyle(color: Color(0xff1F1B62)),
                                                      //--------------------------------=====decoration=====-----------------------------//
                                                      decoration: InputDecoration(
                                                        //Add th Hint text here.
                                                        contentPadding: EdgeInsets.only(
                                                            left: 8, right: 17, bottom: 12, top: 12),
                                                        hintText: "البريد الإلكتروني",
                                                        hintStyle: TextStyle(color: Colors.grey),
                                                        //-----------------Decoration no Active Click---------------//
                                                        //-----------------Decoration no Active Click---------------//
                                                        enabledBorder: const OutlineInputBorder(
                                                          borderSide: const BorderSide(color: Color(0xff1F1B62), width: 0.0),
                                                          borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                                        ),
                                                        //-----------------Decoration Active Click---------------//
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Color(0xff1F1B62)),
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
                                                  padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                                                      textAlign: TextAlign.center,
                                                      initialValue: '${snapshot.data.data.profile.phone??""}',
                                                      textDirection: TextDirection.rtl,
                                                      style: TextStyle(color: Color(0xff1F1B62)),
                                                      //--------------------------------=====decoration=====-----------------------------//
                                                      decoration: InputDecoration(
                                                        //Add th Hint text here.
                                                        contentPadding: EdgeInsets.only(
                                                            left: 8, right: 17, bottom: 12, top: 12),
                                                        hintText: "رقم الجوال",
                                                        hintStyle: TextStyle(color: Colors.grey),
                                                        //-----------------Decoration no Active Click---------------//
                                                        enabledBorder: const OutlineInputBorder(
                                                          borderSide: const BorderSide(color: Color(0xff1F1B62), width: 0.0),
                                                          borderRadius:BorderRadius.all(Radius.circular(20.0)),
                                                        ),
                                                        //-----------------Decoration Active Click---------------//
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Color(0xff1F1B62)),
                                                          borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //phone
                                              SizedBox(
                                                height: 30,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Container(
                                                  width: 295,
                                                  child: RaisedButton(
                                                    onPressed: ()
                                                    {
                                                      setState(()
                                                      {
                                                        checkValidate=true;
                                                      });
                                                      validateAndSave(context);
                                                    },
                                                    padding: EdgeInsets.all(8),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20)),
                                                    color: Color(0xee201D5F),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 10),
                                                      child: Text(" تعديل ",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 25,
                                                              fontFamily: 'DinNextLight')),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(height: 20,),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  ///---------------- AppBar------------------------------//
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        image: new AssetImage("assets/appbar/background_app_bar.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Column(
                                        children: <Widget>[
                                          //-------------Title----------//
                                          ListTile(
                                            //-------------------------- not icon --------------------//
                                            leading: Container(width: 25,height: 25,),
                                            title: Center(
                                                child: Text(
                                                  "تعديل الملف الشخصى",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontFamily: 'DinNextLight'),
                                                )),
                                            //----btn Back
                                            trailing: ClipOval(
                                              child: Material(
                                                color: Colors.transparent, // button color
                                                child: InkWell(
                                                  splashColor: Colors.amberAccent,
                                                  // inkwell color
                                                  child: SizedBox(
                                                      width: 45,
                                                      height: 45,
                                                      child: Image.asset(
                                                        "assets/icons/13.png",
                                                        width: 25,
                                                        height: 25,
                                                      )),
                                                  onTap: ()
                                                  {
                                                    openAccount(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ///-------------------------------- Visibility loading ------------------------------------//
                                  Visibility (
                                    visible: ScopedModelUpdateUser.isLoading,
                                    child: Center(child: Utility.buildLoading()),
                                  ),


                                ],
                              ),
                            ),
                          );
                    }
                  }
              );


            }
        ),),
    );
  }


  void openAccount(BuildContext context)
  {
    Navigator.pop(context);
  }


}