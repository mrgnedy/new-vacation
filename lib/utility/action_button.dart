import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//IconButton on APPBar
class ActionButton extends StatelessWidget {
  final Icon icon;
  final Color color;
  final Function onPressed;

  ActionButton({this.icon, this.color, this.onPressed});

  @override
  Widget build(BuildContext context)
  {
    return IconButton(
      icon: icon,
      color: color,
      onPressed: onPressed,
    );
  }
}
