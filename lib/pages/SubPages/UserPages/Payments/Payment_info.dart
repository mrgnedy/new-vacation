import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vacatiion/model/SuccessReservationModel.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Payments/ReservationPaymentPageBank.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Payments/ReservationPaymentPageVisa.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';

class PaymentInfo extends StatelessWidget {
  final String price;
  final String arboon;
  final String total;
  final String discount;
  final String chaletID;
  final SuccessReservationModel s;
  PaymentInfo(
      {this.arboon = '2',
      this.price = '300',
      this.total = '423',
      this.discount = '111',
      this.chaletID,
      this.s});
  @override
  Widget build(BuildContext context) {
    num afterDiscount = num.parse(total) - num.parse(discount);
    num deposit = num.parse(arboon ?? 0) / 100 * afterDiscount;
    num remaining = afterDiscount - deposit;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          // fit: StackFit.loose,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                // height: 100,
                // width: 200,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildRow(title: 'السعر الكلى', value: total ?? '11'),
                    _buildRow(title: 'قيمة الخصم', value: discount ?? '11'),
                    _buildRow(
                        title: 'السعر بعد الخصم',
                        value: afterDiscount.toString() ?? 11),
                    _buildRow(
                        title: 'قيمة العربون',
                        value: deposit.toString() ?? '11'),
                    _buildRow(
                        title: 'قيمة المتبقى',
                        value: remaining.toString() ?? '11'),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: GestureDetector(
                  onTap: ()async {
                    
                        if ((await confirmReservPolicy(
                            'طريقة الدفع',
                            "اختر طريقة الدفع التى تود ان تستكمل بها عملية الحجز",
                            context) == true))
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReservationConfirmationPage(
                                        price: deposit.toString(),
                                        chaletId: chaletID,
                                      )));
                        else
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReservationPaymentPageBank(
                                        deposit: deposit.toString(),
                                        m: s,
                                      )));
                      
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ReservationPaymentPageBank(
                    //               m: s,
                    //             )));
                  },
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
                    child: Container(
                      // onTap: () async {
                      //   if (await confirmReservPolicy(
                      //       'طريقة الدفع',
                      //       "اختر طريقة الدفع التى تود ان تستكمل بها عملية الشراء",
                      //       context))
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 ReservationConfirmationPage(
                      //                   price: deposit.toString(),
                      //                   chaletId: chaletID,
                      //                 )));
                      //   else
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 ReservationPaymentPageBank(
                      //                   m: s,
                      //                 )));
                      // },
                      child: Center(
                        child: Text(
                          "استكمال الدفع",
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
            ),

            ///======================= APP BAR ==========================//
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Center(
                    child: Text(
                  'تفاصيل الدفع',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'DinNextLight'),
                )),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/appbar/background_app_bar.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildRow({String title, String value}) {
    return Align(
      // width: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 16, 32, 0),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '$value  ر.س',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: ColorsV.defaultColor,
                  fontFamily: 'DinNextLight',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '$title: ',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: ColorsV.defaultColor,
                    fontFamily: 'DinNextLight',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future confirmReservPolicy(title, msg, context) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: msg,
      style: Utility.alertStyle,
      buttons: [
        DialogButton(
          child: Text(
            "حساب بنكى",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context, false);
            // return false;
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        ),
        DialogButton(
          child: Text(
            "فيزا",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context, true);
            // return true;
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}
