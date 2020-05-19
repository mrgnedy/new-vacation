import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vacatiion/utility/colors.dart';

//تعديل الشاليه--------
class EditPostPage extends StatefulWidget {
  @override
  _EditPostPageState createState() => _EditPostPageState();
}
class _EditPostPageState extends State<EditPostPage> {

  //----------------Data Source for DropdownButtonItem----------------//
  final List<String> _itemsTypeBuilding =
  ['شاليه', 'منتجع', 'مخيم', 'منزل', "شقه", "استراحه"].toList();
  final List<String> _itemsType =
  ['شاليه', 'منتجع', 'مخيم', 'منزل', "شقه", "استراحه"].toList();

  String _selectionTypeBuilding;

  @override
  void initState() {
    _selectionTypeBuilding = _itemsTypeBuilding.first;
    super.initState();
  }

  TextEditingController _textFieldControllerPriceNight =
  TextEditingController();

  double spinnerPrice = 0;


  @override
  Widget build(BuildContext context) {

    final dropdownMenuOptions = _itemsTypeBuilding.map((String item) {
      return DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 15, bottom: 5.0, left: 5.0, top: 5.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: new Text(
                  item,
                  style: TextStyle(
                    color: Color(0xff2E0063),
                  ),
                )),
          ));
    }).toList();


    return Scaffold(body: Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: <Widget>[
          ///============================ Content Page ==========================//
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: <Widget>[
                SizedBox(height: 80,),
                //-----------------------Choose multiple Image Chalet--------------------//
                Card(
                  elevation: 4,
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 150,
                    child: Stack(
                      children: <Widget>[
                        //-------------------------Image Chalet------------------------//
                        Container(
                          // padding: EdgeInsets.symmetric(horizontal: 5),
                            width: double.infinity,
                            height: 150,
                            child: Image.asset(
                              "assets/imagetest/test2.jpg",
                              fit: BoxFit.fill,
                            )),

                        //-------------------Icon "Choose multiple Image"--------------------------------//
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 45,
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/icons/24.png"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                //---------------------------Price for the night---------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 5,
                    child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(0xffE1E1E1)),
                          borderRadius:
                          BorderRadius.all(Radius.circular(5.0)),
                        ),
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            //---------------Price------------//
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: <Widget>[
                                  //---------------Price Type---------------//
                                  Padding(
                                    padding:
                                    EdgeInsets.only(bottom: 5, right: 13),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "ريال سعودى",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'DinNextRegular',
                                            color: Color(0xff2E0063),
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                  //SizedBox(width: 5,),
                                  //--------------Price Value--------//
                                  //-----default spinner----//
//                                    SpinnerInput(
//                                      middleNumberWidth: 40,
//                                      minusButton: SpinnerButtonStyle(color: ColorsV.defaultColor,),
//                                      plusButton: SpinnerButtonStyle(color: ColorsV.defaultColor),
//                                      middleNumberStyle: TextStyle(fontSize: 20,),
//                                     // fractionDigits: 3,
//                                      direction: TextDirection.ltr,
//                                      popupButton: SpinnerButtonStyle(height: 30,
//                                                                      width: 30,
//                                                                      textColor: ColorsV.defaultColor,),
//                                      middleNumberBackground: Colors.yellowAccent.withOpacity(0.5),
//
//
//                                      spinnerValue: spinnerPrice,
//                                      //minValue: 0,
//                                      //maxValue: 200,
//                                      onChange: (newValue) {
//                                        setState(() {
//                                          spinnerPrice = newValue;
//                                        });
//                                      },
//                                    ),
                                  //-----------------TextField price-----------------//
                                  Container(
                                    width: 90,
                                    height: 60,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller:
                                      _textFieldControllerPriceNight,
                                      keyboardType: TextInputType.number,
                                      //  textDirection: TextDirection.rtl,
                                      style: TextStyle(color: Colors.black),
                                      //--------------------------------=====decoration=====-----------------------------//
                                      decoration: InputDecoration(
                                        //Add th Hint text here.
                                        contentPadding: EdgeInsets.only(
                                            left: 8,
                                            right: 17,
                                            bottom: 9,
                                            top: 9),
                                        hintText: "500",
                                        hintStyle:
                                        TextStyle(color: Colors.grey),
                                        //-----------------Decoration no Active Click---------------//
                                        enabledBorder:
                                        const OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: ColorsV.defaultColor,
                                              width: 0.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                        //-----------------Decoration Active Click---------------//
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorsV.defaultColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            SizedBox(
                              width: 7,
                            ),
                            //--------------Text Price of Night------------//
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, right: 15),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "سعر الليله",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
                //-----------------------------Location------------------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 3,
                    child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //    <--- border radius here
                          ),
                        ),
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            //---------------icon Location------------//
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Image(
                                  image: AssetImage("assets/icons/20.png"),
                                  height: 30,
                                  width: 25,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 10,
                            ),
                            //--------------Name of Location------------//
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, right: 15),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "جده-المملكه العربيه",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
                //-------------------------Type of building--------------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      height: 55,  //gives the height of the dropdown button
                      width: MediaQuery.of(context).size.width, //gives the width of the dropdown button
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white
                      ),

                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Theme(
                            data: Theme.of(context).copyWith(canvasColor: Colors.grey.shade300,
                                // background color for the dropdown items
                                buttonTheme: ButtonTheme.of(context).copyWith(
                                  alignedDropdown:
                                  true, //If false (the default), then the dropdown's menu will be wider than its button.

                                )),
                            child: DropdownButtonHideUnderline(  // to hide the default underline of the dropdown button
                              child: new DropdownButton<String>(
                                  iconEnabledColor: Color(0xff2E0063),
                                  isExpanded: true,
                                  elevation: 0,
                                  underline: Container(),
                                  style: TextStyle(
                                    color: ColorsV.defaultColor,
                                    fontSize: 20,
                                  ),
                                  hint: Text(
                                    "نوع العقار",
                                    style: TextStyle(
                                        color: Color(0xFF8B8B8B), fontSize: 15),
                                  ),
                                  // setting hint
                                  value: _selectionTypeBuilding, // displaying the selected value
                                  items: dropdownMenuOptions,
                                  onChanged: (s) {
                                    setState(() {
                                      _selectionTypeBuilding = s; // saving the selected value
                                    });
                                  }),
                            )),
                      ),
                    ),
                  ),
                ),
                //----------------------------------Name of building---------------------------//
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _selectionTypeBuilding,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'DinNextRegular',
                          color: Color(0xff2E0063),
                          fontSize: 20,
                        ),
                      )),
                ),
                //---------------------------Type of Department---------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 3,
                    child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                        ),
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            //--------------Name of Location------------//
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, right: 15),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "القسم",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
                //--------Name of Department-------------//
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "عائلى",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'DinNextRegular',
                          color: Color(0xff2E0063),
                          fontSize: 20,
                        ),
                      )),
                ),
                //---------------------------Area of building---------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 5,
                    child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                        ),
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            //---------------Price------------//
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: <Widget>[
                                  //---------------Price Type---------------//
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "متر مربع",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'DinNextRegular',
                                            color: Color(0xff2E0063),
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  //--------------Price Value--------//
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "200",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'DinNextRegular',
                                            color: Color(0xff2E0063),
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: 7,
                            ),
                            //--------------Text Price of Night------------//
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, right: 15),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "مساحه العقار",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
                //---------------------------Minimum number of nights---------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 5,
                    child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                        ),
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            //---------------Price------------//
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: <Widget>[
                                  //---------------Price Type---------------//
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "ليلة",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'DinNextRegular',
                                            color: Color(0xff2E0063),
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  //--------------Price Value--------//
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "2",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'DinNextRegular',
                                            color: Color(0xff2E0063),
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            //--------------Text Price of Night------------//
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, right: 15),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "الحد الادني الليالى",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
                //---------------------------Description of building---------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 3,
                    child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                        ),
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            //--------------Name of Location------------//
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, right: 15),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "وصف العقار",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
                //-------------------Name of building-------------//
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("2"),
                          SizedBox(
                            width: 4,
                          ),
                          Text("سرير مزدوج"),
                          SizedBox(
                            width: 5,
                          ),
                          Image(
                            image: AssetImage("assets/icons/16.png"),
                            height: 30,
                            width: 30,
                            fit: BoxFit.fill,
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("2"),
                          SizedBox(
                            width: 4,
                          ),
                          Text("سرير مزدوج"),
                          SizedBox(
                            width: 5,
                          ),
                          Image(
                            image: AssetImage("assets/icons/16.png"),
                            height: 30,
                            width: 30,
                            fit: BoxFit.fill,
                          )
                        ],
                      )),
                ),
                //------------------------About the property----------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 3,
                    child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                        ),
                        height: 420,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 5, right: 15, top: 5),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "عن الملكيه",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 1, right: 1, left: 1, bottom: 1),
                              child: Text(
                                "هنالك العديد من الأنواع المتوفرة لنصوص لوريم إيبسوم، ولكن الغالبية تم تعديلها بشكل ما عبر إدخال بعض النوادر أو الكلمات العشوائية إلى النص. إن كنت تريد أن تستخدم نص لوريم إيبسوم ما، عليك أن تتحقق أولاً أن ليس هناك أي كلمات أو عبارات محرجة أو غير لائقة مخبأة في هذا النص. بينما تعمل جميع مولّدات نصوص لوريم إيبسوم على الإنترنت على إعادة تكرار مقاطع من نص لوريم إيبسوم نفسه عدة مرات بما تتطلبه الحاجة، يقوم مولّدنا هذا باستخدام كلمات من قاموس يحوي على أكثر من 200 كلمة لا تينية، مضاف إليها مجموعة من الجمل النموذجية، لتكوين نص لوريم إيبسوم ذو شكل منطقي قريب إلى النص الحقيقي. وبالتالي يكون النص الناتح خالي من التكرار، أو أي كلمات أو عبارات غير لائقة أو ما شابه. وهذا ما يجعله أول مولّد نص لوريم إيبسوم حقيقي على الإنترنت.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'DinNextRegular',
                                  color: Color(0xff2E0063),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                //-------------------------------meansComfort-----------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 3,
                    child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0) // <--- border radius here
                          ),
                        ),
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            //--------------Name of Location------------//
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, right: 15),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "وسائل الراحه",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
                //-------------meansComfort-------------//
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("تكييف"),
                          SizedBox(
                            width: 5,
                          ),
                          Image(
                            image: AssetImage("assets/icons/10.png"),
                            height: 30,
                            width: 30,
                            fit: BoxFit.fill,
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("واي فاي"),
                          SizedBox(
                            width: 5,
                          ),
                          Image(
                            image: AssetImage("assets/icons/9.png"),
                            height: 30,
                            width: 30,
                            fit: BoxFit.fill,
                          )
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("حارس"),
                          SizedBox(
                            width: 7,
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Image(
                                image: AssetImage("assets/icons/8.png"),
                                height: 30,
                                width: 30,
                                fit: BoxFit.fill,
                              ))
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("تلفاز"),
                          SizedBox(
                            width: 5,
                          ),
                          Image(
                            image: AssetImage("assets/icons/7.png"),
                            height: 30,
                            width: 30,
                            fit: BoxFit.fill,
                          )
                        ],
                      )),
                ),
                //---------------------------N of WC---------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 5,
                    child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                        ),
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            //---------------Price------------//
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: <Widget>[
                                  //--------------Price Value--------//
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "4",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'DinNextRegular',
                                            color: Color(0xff2E0063),
                                            fontSize: 20,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: 7,
                            ),
                            //--------------Text Price of Night------------//
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, right: 15),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "عدد دورات المياه",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
                //-------------------------------Rules Home-----------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Card(
                    elevation: 3,
                    child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                              width: 1.0, color: Color(0xffE1E1E1)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                        ),
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            //--------------Name of Location------------//
                            Padding(
                              padding: EdgeInsets.only(bottom: 5, right: 15),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "شروط الحجز",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'DinNextRegular',
                                      color: Color(0xff2E0063),
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
                //-------------meansComfort-------------//
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "مسموح للحفلات و المناسبات",
                    style: TextStyle(
                        color: Color(0xff393939),
                        fontSize: 20,
                        height: 0.8,
                        fontFamily: 'DinNextLight',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "مسموح بدخول الحيوانات الاليفه",
                    style: TextStyle(
                        color: Color(0xff393939),
                        fontSize: 20,
                        height: 0.8,
                        fontFamily: 'DinNextLight',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "مسموح التدخين",
                    style: TextStyle(
                        color: Color(0xff393939),
                        fontSize: 20,
                        height: 0.8,
                        fontFamily: 'DinNextLight',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),





                //------------------Btn Add to Offers---------------//
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RaisedButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    color: Color(0xee201D5F),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(" إضافة للعروض ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'DinNextLight')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //---------------3 Btn--------------------//
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: RaisedButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Color(0xee201D5F),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text("محجوز",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'DinNextLight')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: RaisedButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Color(0xee201D5F),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text("غير متاح",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'DinNextLight')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: RaisedButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Color(0xee201D5F),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(" متاح",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'DinNextLight')),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                //------------------Btn  Done---------------//
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage(
                              "assets/bootom_navigation/bootom_nv.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "تم",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'DinNextLight'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          ///------------------- AppBar ------------------------------//
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
                    leading: Container(
                      width: 28,
                      height: 28,
                    ),
                    title: Center(
                        child: Text(
                          "بيانات العقار",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'DinNextLight'),
                        )),

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
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),);
  }
}