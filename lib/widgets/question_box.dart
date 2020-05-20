import 'package:flutter/material.dart';
import 'package:surveystructure/models/models.dart';

class QuestionBox extends StatelessWidget {
  const QuestionBox({
    Key key,
    @required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          question.question,
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          question.description,
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
