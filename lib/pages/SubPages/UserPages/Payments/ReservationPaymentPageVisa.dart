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
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart'
    as prefix0;
import 'package:vacatiion/model/ShowChaletModel.dart';
import 'package:vacatiion/model/ShowChaletModel.dart' as prefix1;
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart';
import 'package:vacatiion/pages/mainPages/AdvertiserPages/post_row/OpenPostDescription.dart'
    as prefix2;
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'package:geocoder/geocoder.dart';

//Reservation Confirmation Page with Visa

///----------------------------New
class ReservationConfirmationPage extends StatefulWidget {
  final String price;
  final String chaletId;

  const ReservationConfirmationPage({Key key, this.price, this.chaletId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ReservationConfirmationPageState();
  }
}

class ReservationConfirmationPageState
    extends State<ReservationConfirmationPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  ScopedModelShowChalet get showChaletModel => GetIt.I<ScopedModelShowChalet>();
  // ScopedModelShowChalet showChaletModel;
  @override
  void initState() {
    // TODO: implement initState
    showChaletModel.initialStreamControllerShowChalet();

    // showChaletModel = ScopedModel.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModelShowChalet>(
        model: showChaletModel,
        child: ScopedModelDescendant<ScopedModelShowChalet>(
            builder: (context, child, model) {
          return Container(
            // title: 'Flutter Credit Card View Demo',
            // debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   primarySwatch: Colors.blue,
            // ),
            child: Scaffold(
              // resizeToAvoidBottomInset: true,

              body: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Visibility(
                      visible: ScopedModelShowChalet.loadingPage,
                      child: Align(
                        alignment: Alignment.center,
                        child: SpinKitCircle(
                          color: ColorsV.defaultColor,
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        CreditCardWidget(
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          showBackView: isCvvFocused,
                        ),
                        Text(
                          'قيمة العربون: ${widget.price} ر.س',
                          style: TextStyle(
                              color: ColorsV.defaultColor,
                              fontSize: 24,
                              fontFamily: 'DinNextMedium'),
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
                            onTap: () {
                              model.confirmPayment(
                                context,
                                brand: 'VISA',
                                amount: widget.price.toString(),
                                currency: 'SAR',
                                cvv: cvvCode,
                                reservationId: widget.chaletId,
                                holder: cardHolderName,
                                expiryMonth: expiryDate.split('/')[0],
                                expiryYear: '20${expiryDate.split('/')[1]}',
                                number: cardNumber,
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
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
                  ],
                ),
              ),
            ),
          );
        }));
  }

  String brand = 'VISA';
  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    if (cardNumber.startsWith('34') || cardNumber.startsWith('37'))
      brand = 'American Express';
    else if (cardNumber.startsWith('64') || cardNumber.startsWith('65'))
      brand = 'Discover';
    else if (cardNumber.startsWith('5'))
      brand = 'MasterCard';
    else
      brand = 'VISA';
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
    print(expiryDate);
    print(cvvCode);
    print(widget.chaletId);
    print(expiryDate.split('/')[0]);
    print('20${expiryDate.split('/')[1]}');
    print(brand);
  }

  void shawAlertDialog(String msg, String title) {
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
