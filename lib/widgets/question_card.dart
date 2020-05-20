import 'package:flutter/material.dart';
import 'package:surveystructure/models/models.dart';
import 'package:surveystructure/widgets/widgets.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final List<Answer> answers;

  QuestionCard({
    Key key,
    @required this.question,
    @required this.answers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        QuestionBox(question: question),
        AnswerBox(
          question: question,
          answers: answers,
        ),
      ],
    );
  }
}
