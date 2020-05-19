import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModelDrawerPages.dart';
import 'package:vacatiion/ScopedModels/ScopedModelReservations.dart';
import 'package:vacatiion/model/ModelDrawer.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';

class RportingChaitPage extends StatefulWidget
{

  String chaletId;
  String chaletName;


  RportingChaitPage({this.chaletId,this.chaletName});

  @override
  _RportingChaitPageState createState() => _RportingChaitPageState();
}

class _RportingChaitPageState extends State<RportingChaitPage> {

  ScopedModelReservations  _modelReservations;
  TextEditingController _textFieldControllerMSG;

  @override
  void initState() {
    _modelReservations = ScopedModelReservations();
    _textFieldControllerMSG = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModelReservations>(
      model: _modelReservations,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ScopedModelDescendant(builder: (BuildContext context, Widget child,ScopedModelReservations model) {

              return Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),

                      //---------------Edit Text------------//
                      Center(
                        child: Padding(
                          //Add padding around textfield
                          padding:
                          EdgeInsets.only(right: 20.0, left: 20, top: 100),
                          child: Card(
                            elevation: 2,
                            color: Color(0xffE4E4E4),
                            //Background for EditText
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextField(
                              maxLines: 10,
                              textAlign: TextAlign.right,
                              textInputAction: TextInputAction.next,
                              controller: _textFieldControllerMSG,
                              keyboardType: TextInputType.emailAddress,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Color(0xff1F1B62)),

                              //--------------------------------=====decoration=====-----------------------------//
                              decoration: InputDecoration(
                                //Add th Hint text here.
                                contentPadding: EdgeInsets.only(
                                    left: 8, right: 17, bottom: 5, top: 5),
                                hintText: "اكتب الشكوى",
                                hintStyle: TextStyle(
                                    color: ColorsV.defaultColor,
                                    fontFamily: 'DinNextMedium',
                                    fontSize: 19),
                                //-----------------Decoration no Active Click---------------//
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE6E6E6), width: 0.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                ),
                                //-----------------Decoration Active Click---------------//
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffE4E4E4)),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //--------------btn send----------//
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Container(
                          width: 50,
                          child: RaisedButton(
                            onPressed: () {
                              if (_textFieldControllerMSG.text.toString() ==
                                  null ||
                                  _textFieldControllerMSG.text
                                      .toString()
                                      .isEmpty) {
                                Utility.shawAlertDialogFailed(
                                    context: context,
                                    title: "الاداره",
                                    msg: "من فضلك اكتب الشكوي");
                              } else {
                                _modelReservations.addReportingForChalet(chaletId: widget.chaletId,context: context,comment: _textFieldControllerMSG.text.toString());

                              }
                            },
                            padding: EdgeInsets.only(
                                right: 4, bottom: 15, top: 9, left: 4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35)),
                            color: Color(0xee201D5F),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text("إرسال",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontFamily: 'DinNextMedium')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility (
                    visible: ScopedModelReservations.loadingHomePage,
                    child: Align(
                        alignment: Alignment.center,
                        child: SpinKitCircle(color: ColorsV.defaultColor)),
                  ),
                ],
              );
            }),

            ///=========================================================== AppBar =====================================================//
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/appbar/background_app_bar.png"),
                      fit: BoxFit.fill,
                    )),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 35,
                    ),
                    //------------------- Title AppBar ---------------//
                    ListTile(
                      leading: Container(
                        height: 25,
                        width: 25,
                      ),
                      title: Center(
                          child: Text(
                            "${widget.chaletName}",
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          )),
                      trailing: InkWell(
                          onTap: () {
                            Utility.backPage(context);
                          },
                          child: Image.asset(
                            "assets/icons/13.png",
                            width: 27,
                            height: 27,
                          )),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
