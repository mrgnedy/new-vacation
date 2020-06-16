import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vacatiion/ScopedModels/ScopedModelUpdateUser.dart';
import 'package:vacatiion/utility/colors.dart';
import 'package:vacatiion/utility/tet_field_with_title.dart';

class AddOfficerPage extends StatelessWidget {
  ScopedModelUpdateUser get _model => GetIt.I<ScopedModelUpdateUser>();
  Size size;
  TextEditingController nameCtrler = TextEditingController();
  TextEditingController phoneCtrler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
          child: Scaffold(
        appBar: PreferredSize(
          child: buildAppBar(),
          preferredSize: Size.fromHeight(size.height / 12),
        ),
        body:
            ScopedModel<ScopedModelUpdateUser>(model: _model, child: buildBody()),
      ),
    );
  }

  Widget buildBody() {
    return Center(
      heightFactor: 02,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TetFieldWithTitle(
            title: 'إسم المسؤول',
            textEditingController: nameCtrler,
          ),
          TetFieldWithTitle(
            title: 'رقم الجوال',
            textEditingController: phoneCtrler,
          ),
          SizedBox(height: 20),
          addOfficerBtn(),
        ],
      ),
    );
  }

  Widget addOfficerBtn() {
    return ScopedModelDescendant<ScopedModelUpdateUser>(
        builder: (context, child, model) {
      return Container(
        width: MediaQuery.of(context).size.width *0.7,
        height: MediaQuery.of(context).size.height / 16,
        child: ScopedModelUpdateUser.isLoading
            ? Center(
                child: SpinKitCircle(
                color: ColorsV.defaultColor,
              ))
            : RaisedButton(
                onPressed: () => model.addOfficer(
                    name: nameCtrler.text, phone: phoneCtrler.text),
                child: Text(
                  'أضف مسؤول حجوزات',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'DinNextLight'),
                ),
                color: ColorsV.defaultColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
      );
    });
  }

  Widget buildAppBar() {
    return Container(
      
      width: double.infinity,
      height: size.height/12,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/appbar/background_app_bar.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        heightFactor: 0.1,
        child: Text(
          'إضافة مسؤول حجوزات',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontFamily: 'DinNextMedium', fontSize: 18),
        ),
      ),
    );
  }
}
