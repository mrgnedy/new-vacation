import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vacatiion/ScopedModels/ScopedModelShowChalet.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart' as prefix0;
import 'package:vacatiion/model/ShowChaletModel.dart';
import 'package:vacatiion/model/ShowChaletModel.dart' as prefix1;
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart';
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart' as prefix2;
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:geocoder/geocoder.dart';


//Reservation Confirmation Page with Visa


///----------------------------New
class ReservationConfirmationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReservationConfirmationPageState();
  }
}

class ReservationConfirmationPageState extends State<ReservationConfirmationPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
       // resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: ()
                  {
                    shawAlertDialog("عذرا لم يتم توفير الدفع اون لاين حاليا", "تنبيه");
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0),
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
                          "تأكيد الحجز",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'DinNextLight'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  void shawAlertDialog(String msg,String title)
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


