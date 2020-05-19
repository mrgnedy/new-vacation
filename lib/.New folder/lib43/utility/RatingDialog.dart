library rating_dialog;

import 'package:flutter/material.dart';
import 'package:vacatiion/utility/colors.dart';

class RatingDialog extends StatefulWidget {
  final String title;
  final String description;
  final String submitButton;
  final String alternativeButton;
  final String positiveComment;
  final String negativeComment;
  final Widget icon;
  final Color accentColor;


  final ValueSetter<int> onSubmitPressed;
  final VoidCallback onAlternativePressed;
  final ValueSetter<String> feedbackComment;

  RatingDialog(
      {@required this.icon,
        @required this.title,
        @required this.description,
        @required this.onSubmitPressed,
        @required this.submitButton,
        @required this.feedbackComment,
        this.accentColor = Colors.blue,
        this.alternativeButton = "",
        this.positiveComment = "",
        this.negativeComment = "",
        this.onAlternativePressed});

  @override
  _RatingDialogState createState() => new _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  int _rating = 0;

  List<Widget> _buildStarRatingButtons() {

    List<Widget> buttons = [];

    for (int rateValue = 1; rateValue <= 5; rateValue++) {
      final starRatingButton = IconButton(
          icon: Icon(_rating >= rateValue ? Icons.star : Icons.star_border,
              color: widget.accentColor, size: 35),
          onPressed: () {
            setState(() {
              _rating = rateValue;
            });
          });
      buttons.add(starRatingButton);
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    final String commentText =
    _rating >= 4 ? widget.positiveComment : widget.negativeComment;
    // final Color commentColor = _rating >= 4 ? Colors.green[600] : Colors.red;

    return AlertDialog(
      contentPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.icon,
            const SizedBox(height: 15),
            Text(widget.title,style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              widget.description,
              textAlign: TextAlign.center,
            ),
           ///----------------------------------------------------------TextField Inputs-------------------------------------//
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                controller: myController,
                textAlign: TextAlign.right,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Color(0xff1F1B62)),
                //--------------------------------=====decoration=====-----------------------------//
                decoration: InputDecoration(
                  //Add th Hint text here.
                  contentPadding: EdgeInsets.only(
                      left: 8, right: 17, bottom: 9, top: 9),
                  hintText: "بما تفكر ... ",
                  hintStyle: TextStyle(color: ColorsV.defaultColor),
                  //-----------------Decoration no Active Click---------------//
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorsV.defaultColor, width: 2),
                    borderRadius:BorderRadius.all(Radius.circular(20.0)),
                  ),
                  //-----------------Decoration Active Click---------------//
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorsV.defaultColor, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)), ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildStarRatingButtons(),
            ),
            Visibility(
              visible: _rating > 0,
              child: Column(
                children: <Widget>[
                  const Divider(),
                  FlatButton(
                    child: Text(
                      widget.submitButton,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.accentColor,
                          fontSize: 18),
                    ),
                    onPressed: ()
                    {
                      Navigator.pop(context);
                      widget.onSubmitPressed(_rating,);
                      widget.feedbackComment(myController.text);

                    },
                  ),
                  Visibility(
                    visible: commentText.isNotEmpty,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        Text(
                          commentText,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                    _rating <= 3 && widget.alternativeButton.isNotEmpty,
                    child: FlatButton(
                      child: Text(
                        widget.alternativeButton,
                        style: TextStyle(
                            color: widget.accentColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onAlternativePressed();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


