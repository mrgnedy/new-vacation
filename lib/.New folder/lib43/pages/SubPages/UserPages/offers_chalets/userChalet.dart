import 'dart:async';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageAdvertiser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelMainPageUser.dart';
import 'package:vacatiion/ScopedModels/ScopedModelUpdateUser.dart';
import 'package:vacatiion/model/AdvertiserChalets/AdvertiserChaletsShow.dart';
import 'package:vacatiion/model/AllChaletsAndOffersModel.dart';
import 'package:vacatiion/pages/SubPages/UserPages/ShowChalet.dart';
import 'package:vacatiion/pages/SubPages/UserPages/offers_chalets/chalet_card.dart';
import 'package:vacatiion/utility/page-route-transition.dart';
import 'package:vacatiion/utility/utility_class.dart';

class UserChalets extends StatefulWidget {
  final String type;
  UserChalets({this.type});
  @override
  _UserChaletsState createState() => _UserChaletsState();
}

class _UserChaletsState extends State<UserChalets> {
  ScopedModelMainPageUser get _scopedModelMainPageUser =>
      GetIt.I<ScopedModelMainPageUser>();

  @override
  void initState() {
    _scopedModelMainPageUser.initialStreamControllerChalet();
    _scopedModelMainPageUser.stopLoadingHomePage();
    _scopedModelMainPageUser.getAllChaletUser(context: context);
    _scopedModelMainPageUser.outAllChaletUser.listen((onData) {
      print(
          "============Numbers Of Chalites=====${onData.data.length}=====================");
    });
    super.initState();
  }

  @override
  void dispose() {
    //_scopedModelMainPageAdvertiser.disposeStreamControllerChalet();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ScopedModelMainPageUser>(
        model: _scopedModelMainPageUser,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: ScopedModelDescendant<ScopedModelMainPageUser>(
              builder: (BuildContext context, Widget child,
                  ScopedModelMainPageUser model) {
                return StreamBuilder<AllChaletsAndOffersModel>(
                    stream: model.outAllChaletUser,
                    builder: (context, snapshot) =>
                        ChaletCard(context, snapshot, callback, type: widget.type,));
              },
            ),
          ),
        ));
  }

      Future callback(snapshot) {
        return snapshot.isFavourite == true
            ? Future.sync(() => Utility.showToast("مضافة من قبل",
                context: context,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM,
                chooseColor: 1))
            : _scopedModelMainPageUser
                .addFavorites(chaletId: snapshot.id.toString(), context: context)
                .then((_) =>
                    _scopedModelMainPageUser.getAllChaletUser(context: context));
      }
}
