import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModelShowChalet.dart';
import 'package:vacatiion/model/SuccessReservationModel.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Payments/ReservationPaymentPageBank.dart';
import 'package:vacatiion/pages/SubPages/UserPages/Payments/ReservationPaymentPageVisa.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';
import 'reservation_details.dart';

class PaymentDetails extends StatefulWidget {
  final String startDate;
  final String endDate;
  final String chaletName;
  final String image;
  final String totalPrice;
  final String deposit;
  final chaletID;
  final String discount;
  // final SuccessReservationModel rm;

  PaymentDetails({
    Key key,
    this.chaletName = 'بحيرة البجع للمناسبات',
    this.image =
        'https://via.placeholder.com/728x90.png?text=Visit+WhoIsHostingThis.com+Buyers+Guide',
    this.totalPrice = '4123',
    this.deposit = '20',
    this.discount = '100',
    this.chaletID,
    // this.rm,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  Size size;
  TextEditingController couponCtrler = TextEditingController();
  ScopedModelShowChalet get _showChaletModel =>
      GetIt.I<ScopedModelShowChalet>();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool isCorrect = true;
  num coupon;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(appBar: buildAppBar(context), body: buildBody(context));
  }

  Widget buildBody(context) {
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.87,
        child: ScopedModel<ScopedModelShowChalet>(
          model: _showChaletModel,
          child: Column(
            children: <Widget>[
              buildImageAndName(),
              buildPaymentDetails(),
              buildCoupon(),
              Divider(thickness: 3, color: ColorsV.defaultColor),
              buildPaymentMethod(),
              Spacer(),
              buildSubmit()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageAndName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('${widget.chaletName}'),
          Container(
            width: size.height / 12,
            height: size.height / 12,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorsV.defaultColor),
                image: DecorationImage(
                    image: NetworkImage(
                      "http://vacatiion.net/public/images/${widget.image}",
                    ),
                    fit: BoxFit.cover)),
          )
        ],
      ),
    );
  }

  Widget buildPaymentDetails() {
    return ScopedModelDescendant<ScopedModelShowChalet>(
        builder: (context, child, model) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(thickness: 3, color: ColorsV.defaultColor),
          Text('تفاصيل الدفع', style: defaultTitleStyle),
          Center(
            child: Container(
              width: size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${widget.totalPrice} ريال',
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        'الاجمالي',
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${(num.parse(widget.deposit))}%',
                        textDirection: TextDirection.rtl,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'نسبة العربون',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Visibility(
                    visible: coupon != null && coupon != 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '$coupon- ريال',
                          style: TextStyle(color: Colors.green[400]),
                          textDirection: TextDirection.rtl,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'خصم الكوبون',
                            style: TextStyle(color: Colors.green[400]),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: coupon != null && coupon != 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${num.parse(widget.totalPrice) - (coupon ?? 0)} ريال',
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          'الاجمالي بعد الخصم',
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${(num.parse(widget.deposit) / 100 * (num.parse(widget.totalPrice) - (coupon ?? 0))).toStringAsFixed(3)} ريال',
                        textDirection: TextDirection.rtl,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'قيمة العربون',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  int selectedMethod = 3;
  List<String> paymentMethods = ['تحويل بنكي', 'فيزا'];

  Widget buildPaymentMethod() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 2.5,
      children: List.generate(
        2,
        (index) => Container(
          width: size.width / 2,
          child: RadioListTile(
            subtitle: Visibility(
                visible: index == 1,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.ccVisa,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Image.asset('assets/icons/mada.png',
                            height: 15, fit: BoxFit.cover),
                      ],
                    ),
                    Text('سريع وأمن 100%', textDirection: TextDirection.rtl),
                  ],
                )),
            value: index,
            isThreeLine: true,
            groupValue: selectedMethod,
            onChanged: (s) => setState(() => selectedMethod = s),
            title: Text(
              paymentMethods[index],
              textAlign: TextAlign.right,
            ),
            activeColor: ColorsV.defaultColor,
          ),
        ),
      ),
    );
  }

  Widget buildCoupon() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ScopedModelDescendant<ScopedModelShowChalet>(
                builder: (context, child, model) {
              return Container(
                height: size.height / 16,
                child: ScopedModelShowChalet.loadingPage
                    ? SpinKitCircle(
                        color: ColorsV.defaultColor,
                      )
                    : RaisedButton(
                        onPressed: () {
                          isCorrect = true;
                          if (!_formKey.currentState.validate()) return;
                          _formKey.currentState.validate();
                          _showChaletModel.checkCoupon(couponCtrler.text).then(
                              (s) {
                            print('COUPON IS: $s');
                            coupon = num.parse(s);
                          }, onError: (e) {
                            print(e);
                            isCorrect = false;
                            coupon = null;
                            _formKey.currentState.validate();
                          });
                        },
                        color: ColorsV.defaultColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Text(
                          'إضافة كوبون',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              );
            }),
            Form(
              key: _formKey,
              child: Container(
                width: size.width * 0.3,
                // height: size.height / 16,
                child: TextFormField(
                  validator: (s) {
                    if (s.isEmpty || !isCorrect) return 'تعذر اضافة الكوبون';
                  },
                  style: TextStyle(height: 0.8),
                  controller: couponCtrler,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubmit() {
    return InkWell(
      onTap: () {
        {
          _showChaletModel
              .addReservationChalet(
                  Start: widget.startDate,
                  chaletId: widget.chaletID,
                  context: context,
                  type: selectedMethod,
                  end: widget.endDate,
                  deposit: widget.deposit,
                  totalPrice: (num.parse(widget.deposit) / 100 * (num.parse(widget.totalPrice) - (coupon ?? 0))).toStringAsFixed(3),
                  coupon: coupon.toString()
                  
                  )
              .then(
            (s) {
                print(s);
              // if (selectedMethod == 0)
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ReservationPaymentPageBank(
              //           deposit: (num.parse(widget.deposit) /
              //                   num.parse(widget.totalPrice))
              //               .toString(),
              //           m: s),
              //     ),
              //   );
              // else
              //   ReservationConfirmationPage(
              //     price: widget.deposit,
              //     chaletId: widget.chaletID,
              //   );
            },
          );
        }
      },
      child: Container(
        height: size.height / 12,
        width: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bootom_navigation/bootom_nv.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Text(
            'متابعة',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  TextStyle defaultTitleStyle = TextStyle(
      // fontWeight: ,
      fontSize: 20,
      color: ColorsV.defaultColor);

  Widget buildAppBar(context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(size.height / 10),
      child: Container(
        width: 1000,
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
              //-------------no----------//
              ListTile(
                leading: Container(
                  width: 28,
                  height: 28,
                ),
                //---------------------------------- Title --------------------------//
                title: Center(
                    child: Text(
                  "${widget.chaletName}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'DinNextLight'),
                )),
                //------------------------------------  Back ----------------------------------//
                trailing: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    // button color
                    child: InkWell(
                      splashColor: ColorsV.defaultColor,
                      // inkwell color
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Image.asset(
                            "assets/icons/13.png",
                            width: 25,
                            height: 25,
                            fit: BoxFit.fill,
                          )),
                      onTap: () {
                        Utility.backPage(context);
                      },
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

  Future confirmReservPolicy(title, msg) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: msg,
      style: Utility.alertStyle,
      buttons: [
        DialogButton(
          child: Text(
            "إلغاء",
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
            "تأكيد",
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
