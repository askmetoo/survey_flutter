import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';
import 'package:surveystructure/models/question_type.dart';
import 'dart:math';

final _random = new Random();

class Question extends Equatable {
  final String id;
  final QuestionType type;
  final String question;
  final String description;
  final ShowUpLogic showUpLogic;
  final String validation;
  final int page;
  final List<Choice> choices;
  final List<Choice> specialChoices;
  final dynamic defaultAnswer;

  Question({
    this.id,
    this.type,
    this.question,
    this.description,
    this.showUpLogic,
    this.validation,
    this.page,
    this.choices,
    this.specialChoices,
    this.defaultAnswer,
  });

  @override
  List<Object> get props => [
        id,
        type,
        question,
        description,
        showUpLogic,
        validation,
        page,
        choices,
        specialChoices,
        defaultAnswer,
      ];

  @override
  String toString() {
    return 'Question { id: $id, type: $type, question: $question, '
        'description: $description, showUpLogic: $showUpLogic, '
        'validation: $validation, page: $page, choices: $choices, '
        'specialChoices: $specialChoices, defaultAnswer: $defaultAnswer} \n';
  }
}

class QuestionBank {
  static final List<int> list = List<int>.generate(30, (i) => i + 1);

  List<Question> questions = (list)
      .map(
        (i) => Question(
          id: 'Q$i',
//          type: QuestionType.single,
          type: [
            QuestionType.single,
            QuestionType.single,
//            QuestionType.multiple
          ][_random.nextInt(2)],
          question: '題目$i',
          description: '說明$i',
//          showUpLogic: '',
          showUpLogic: i == 3
              ? ShowUpLogic(
                  fullExpression: 'A',
                  expressions: {
                    'A': SingleExpression(
                        questionId: 'Q1', operator: '==', target: 1)
                  },
                )
              : null,
          validation: '',
          page: i ~/ 5,
          choices: ChoiceData.choices,
          specialChoices: ChoiceData.specialChoices,
        ),
      )
      .toList();
}
