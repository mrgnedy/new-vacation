import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModelShowChalet.dart';
import 'package:vacatiion/pages/SubPages/UserPages/chaletDetails/payment_details.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/utility_class.dart';

class ReservationPreview extends StatelessWidget {
  final re;
  final String chaletName; //
  final String chaletID; //
  final String startDate; //
  final String endDate; //
  final String startTime; //
  final String endTime; //
  final String totalPrice;
  final String deposit;
  final String discount;
  final String address;
  final String image;
  final String policy;
  Size size;

  ReservationPreview(
      {Key key,
      this.chaletName = 'إسم الشاليه',
      this.chaletID,
      this.startDate = '20-10-2020',
      this.endDate = '30-11-2022',
      this.startTime = '20-10-2020',
      this.endTime = '30-11-2022',
      this.totalPrice = '1234',
      this.deposit = '12',
      this.address = 'السعودية',
      this.discount = '100',
      this.policy = 'سياسة الإلغاء الصارمة',
      this.image =
          'https://via.placeholder.com/728x90.png?text=Visit+WhoIsHostingThis.com+Buyers+Guide', this.re,})
      : super(key: key);

  TextEditingController couponCtrler = TextEditingController();
  ScopedModelShowChalet get _showChaletModel =>
      GetIt.I<ScopedModelShowChalet>();
  bool isCorrect = true;
  String depoValue;
  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    depoValue = '${(num.parse(deposit) / 100 * num.parse(totalPrice)).toStringAsFixed(3)}';
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: buildAppBar(context),
        preferredSize: Size.fromHeight(size.height / 8),
      ),
      body: ScopedModel<ScopedModelShowChalet>(
          model: _showChaletModel,
          child: SingleChildScrollView(
            child: Container(
              height: size.height * 0.9,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Image.network(
                    "http://vacatiion.net/public/images/$image",
                    fit: BoxFit.cover,
                    height: size.height / 4,
                    width: size.width,
                  ),
                  Text(
                    '$chaletName',
                    style: defaultTitleStyle,
                  ),
                  Text('$address'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '$policy',
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                  Divider(thickness: 3, color: ColorsV.defaultColor),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text('تاريخ المغادرة',
                                  style: defaultTitleStyle),
                            ),
                            Text('$endDate'),
                            Text('$endTime')
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text('تاريخ الدخول',
                                  style: defaultTitleStyle),
                            ),
                            Text('$startDate'),
                            Text('$startTime')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 3, color: ColorsV.defaultColor),
                  Text('تفاصيل الدفع', style: defaultTitleStyle),
                  Center(
                    child: Container(
                      width: size.width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '$totalPrice ريال',
                                  style: TextStyle(fontSize: 16),
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  'الاجمالي',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${(num.parse(deposit) / 100 * num.parse(totalPrice)).toStringAsFixed(3)} ريال',
                                style: TextStyle(fontSize: 16),
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                'قيمة العربون',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymentDetails(
                            // rm: re,
                            startDate: startDate,
                            endDate: endDate,
                            chaletID: chaletID,

                            chaletName: chaletName,
                            deposit: deposit,
                            discount: discount,
                            image: image,
                            totalPrice: totalPrice,
                          )));
                    },
                    child: Container(
                      height: size.height / 12,
                      width: 1000,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/bootom_navigation/bootom_nv.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        'متابعة',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  TextStyle defaultTitleStyle = TextStyle(
      // fontWeight: ,
      fontSize: 20,
      color: ColorsV.defaultColor);

  Widget buildAppBar(context) {
    return Container(
      height: 100,
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
                "$chaletName",
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
    );
  }
}
