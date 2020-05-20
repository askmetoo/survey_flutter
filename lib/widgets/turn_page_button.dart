import 'package:flutter/material.dart';

class TurnPageButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const TurnPageButton(
    this.text, {
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 140,
      child: FlatButton(
        color: Colors.blueGrey[700],
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
