import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModelUpdateUser.dart';
import 'package:vacatiion/model/Advertiser/UpdateAdvertiser.dart';
import 'package:vacatiion/utility/PickImage/ImagePickerHandler.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'dart:core' as prefix0;
import 'dart:core';
import 'package:path/path.dart';







class EditPersonalAccountAdvertiser extends StatefulWidget {


  @override
  _EditPersonalAccountAdvertiserState createState() => _EditPersonalAccountAdvertiserState();
}

class _EditPersonalAccountAdvertiserState extends State<EditPersonalAccountAdvertiser>with TickerProviderStateMixin,ImagePickerListener {




  var nameText ;
  var emailText;
  var phoneText;
  var passwordText;
  var confirmPasswordText;
  var ibanNumberText;
  var bankNameText;
  var accountNameText;
  var accountNumberText;
  var imageInternet;


  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;


  ScopedModelUpdateUser get _scopedModelUpdateUser => GetIt.I<ScopedModelUpdateUser>();

  BuildContext _context;

  @override
  void initState()
  {
    _scopedModelUpdateUser.stopLoading();
    _scopedModelUpdateUser.getUpdateAdvertiser(context: _context);

    //------------------------------------------- For PickImage -------------------------------//
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();
    super.initState();
  }


  @override
  void dispose()
  {
    //------image picker--------//
    _controller.dispose();
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
      if(_image==null)
      {
        print ('=================== Form is valid Sucessful 1=====================');
        //----------Shaw Loading------------//
        _scopedModelUpdateUser.showLoading();
        form.save();
        _scopedModelUpdateUser.updateAccountAdvertiser(name: nameText,
            phone: phoneText,email: emailText,
            accountName: accountNameText,accountNumber: accountNumberText,
            ibanNumber: ibanNumberText,bankName: bankNameText,
            context: context,);
      }else
      {
        //----------Shaw Loading------------//
       _scopedModelUpdateUser.showLoading();
        form.save();
        print ('=================== Form is valid Sucessful 2${ibanNumberText}=====================');
          _scopedModelUpdateUser.updateAccountAdvertiserWithImage(name: nameText,
                                                                  phone: phoneText,email: emailText,
                                                                  accountName: accountNameText,accountNumber: accountNumberText,
                                                                  ibanNumber: ibanNumberText,bankName: bankNameText,
                                                                  context: context,imageFile: _image);
        }

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
            return StreamBuilder<UpdateAdvertiser>(
                stream: model.outUpdateAdvertiser,
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
                                            //--------------------------- Choose Image Profile ------------------------------//
                                            Container(
                                              child: InkWell(
                                                onTap: ()
                                                {
                                                  imagePicker.showDialog(context);
                                                },
                                                child: _image==null? CircularProfileAvatar(
                                                  "http://vacatiion.net/public/images/"+snapshot.data.data.profile.image, //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                                                  radius: 90, // sets radius, default 50.0
                                                  backgroundColor: Colors.transparent, // sets background color, default Colors.white
                                                  borderWidth: 7,  // sets border, default 0.0
//                                     initialsText: Text(
//                                       snapshot.data.data.name,
//                                       style: TextStyle(fontSize: 40, color: Colors.white),
//                                     ),  // sets initials text, set your own style, default Text('')
                                                  borderColor: ColorsV.defaultColor, // sets border color, default Colors.white
                                                  elevation: 5.0, // sets elevation (shadow of the profile picture), default value is 0.0
                                                  //    foregroundColor: Colors.brown.withOpacity(0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                                                  cacheImage: true, // allow widget to cache image against provided url
                                                  onTap: ()
                                                  {
                                                    imagePicker.showDialog(context);
                                                  }, // sets on tap
                                                  showInitialTextAbovePicture: true, // setting it true will show initials text above profile picture, default false
                                                ):Image.file(_image,fit: BoxFit.cover,height: 150,width: 150,),
                                              ),
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
                                                    initialValue: snapshot.data.data.profile.phone.toString()??"",
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
                                              height: 3,
                                            ),
                                            //----------------------------TextField Bank name--------------------------------//
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
                                                        return 'اسم البنك مطلوب';
                                                      }

                                                      return null;
                                                    },
                                                    onSaved: (String value) {
                                                      bankNameText = value;
                                                    },
                                                    keyboardType: TextInputType.text,
                                                    textInputAction: TextInputAction.next,
                                                    textAlign: TextAlign.center,
                                                    initialValue: snapshot.data.data.profile.bank??"",
                                                    textDirection: TextDirection.rtl,
                                                    style: TextStyle(color: Color(0xff1F1B62)),

                                                    //--------------------------------=====decoration=====-----------------------------//
                                                    decoration: InputDecoration(
                                                      //Add th Hint text here.
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8, right: 17, bottom: 12, top: 12),
                                                      hintText: "اسم البنك",
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
                                              height: 3,
                                            ),
                                            //--------------------------- TextField Account Name ------------------------//
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
                                                        return 'اسم الحساب مطلوب';
                                                      }

                                                      return null;
                                                    },
                                                    onSaved: (String value) {
                                                      accountNameText = value;
                                                    },
                                                    keyboardType: TextInputType.text,
                                                    textInputAction: TextInputAction.next,
                                                    textAlign: TextAlign.center,
                                                    initialValue: snapshot.data.data.profile.accountName??"",
                                                    textDirection: TextDirection.rtl,
                                                    style: TextStyle(color: Color(0xff1F1B62)),

                                                    //--------------------------------=====decoration=====-----------------------------//
                                                    decoration: InputDecoration(
                                                      //Add th Hint text here.
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8, right: 17, bottom: 12, top: 12),
                                                      hintText: "اسم صاحب الحساب",
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
                                              height: 3,
                                            ),
                                            //-------------------------- TextField Account Number  -----------------------//
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
                                                        return 'رقم الحساب مطلوب';
                                                      }

                                                      return null;
                                                    },
                                                    onSaved: (String value)
                                                    {
                                                      accountNumberText  = value;
                                                    },
                                                    keyboardType: TextInputType.text,
                                                    textInputAction: TextInputAction.next,
                                                    textAlign: TextAlign.center,
                                                    initialValue: snapshot.data.data.profile.accountNumber??"",
                                                    textDirection: TextDirection.rtl,
                                                    style: TextStyle(color: Color(0xff1F1B62)),

                                                    //--------------------------------=====decoration=====-----------------------------//
                                                    decoration: InputDecoration(
                                                      //Add th Hint text here.
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8, right: 17, bottom: 12, top: 12),
                                                      hintText: "رقم الحساب",
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
                                              height: 3,
                                            ),
                                            //-------------------------------TextField Iban Number--------------------//
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
                                                        return 'رقم الايبان مطلوب';
                                                      }

                                                      return null;
                                                    },
                                                    onSaved: (String value)
                                                    {
                                                      ibanNumberText  = value;
                                                    },

                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.text,
                                                    textInputAction: TextInputAction.next,
                                                    initialValue: snapshot.data.data.profile.eban??"",
                                                    textDirection: TextDirection.rtl,
                                                    style: TextStyle(color: Color(0xff1F1B62)),

                                                    //--------------------------------=====decoration=====-----------------------------//
                                                    decoration: InputDecoration(
                                                      //Add th Hint text here.
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8, right: 17, bottom: 12, top: 12),
                                                      hintText: "رقم الايبان",
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
                                            //Iban
                                            //confirm password
                                            SizedBox(height: 10,),
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

  @override
  userImage(File _image)
  {
    setState(()
    {
      this._image = _image;
      print("========path======${_image.path}==================");
    });
  }
  void openAccount(BuildContext context)
  {
    Navigator.pop(context);
  }


}