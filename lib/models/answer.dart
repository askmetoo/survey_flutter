//import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:expression_language/expression_language.dart';
import 'package:surveystructure/models/models.dart';

class Answer extends Equatable {
  final String questionId;
  final dynamic value;
  final bool isNote;
  final int noteId;

  Answer({this.questionId, this.value, bool isNote = false, this.noteId})
      : isNote = isNote ?? false;

  @override
  List<Object> get props => [questionId, value, isNote, noteId];

  @override
  String toString() {
    return 'Answer { questionId: $questionId, value: $value, '
        'isNote: $isNote, noteId: $noteId} \n';
  }

  Answer copyWith({String questionId, dynamic value, bool isNote, int noteId}) {
    return Answer(
      questionId: questionId ?? this.questionId,
      value: value ?? this.value,
      isNote: isNote ?? this.isNote,
      noteId: noteId ?? this.noteId,
    );
  }
}

class Answers extends Equatable {
  final Map<String, Map<String, dynamic>> answers;

  Answers(this.answers);

  @override
  List<Object> get props => [answers];

  @override
  String toString() {
    return 'Answers { answers: $answers} \n';
  }

  final Function equals = const DeepCollectionEquality.unordered().equals;

  bool compareAnswer(SingleExpression expression, List<Answer> answers) {
    // (Q1 != 3) -> true/false
    Answer thisAnswer = answers.firstWhere((answer) =>
        answer.questionId == expression.questionId && !answer.isNote);
    var head = expression.switchSide ? expression.target : thisAnswer.value;
    var tail = expression.switchSide ? thisAnswer.value : expression.target;
    print('$head ${expression.operator} $tail');

    switch (expression.operator) {
      case '==':
        return head == tail;
      case '!=':
        return head != tail;
      case 'in':
        return tail.contains(head);
      case 'notin':
        return !tail.contains(head);
      case '>':
        return head > tail;
      case '<':
        return head < tail;
      case '>=':
        return head >= tail;
      case '<=':
        return head <= tail;
      default:
        return false;
    }
  }

//  bool evaluateBooleanExpressions(Map<String, dynamic> logic) {
//    // (true || false || false) -> true
//    if (logic['operator'] == '||') {
//      return logic['expression'].reduce((e1, e2) => e1 || e2);
//    } else if (logic['operator'] == '&&') {
//      return logic['expression'].reduce((e1, e2) => e1 && e2);
//    } else {
//      return false;
//    }
//  }

  bool evaluateShowUpLogic(ShowUpLogic showUpLogic, List<Answer> answers) {
    // (((A || B) && C) || D) -> true/false
    // A -> (Q1 != 3)
    Map newLogic = {};
    showUpLogic.expressions.forEach((index, expression) {
      newLogic[index] = compareAnswer(expression, answers);
    });

    print(newLogic);

    String fullExpression = showUpLogic.fullExpression;
    newLogic.forEach((index, value) {
      fullExpression = fullExpression.replaceAll(index, value.toString());
    });

    print(fullExpression);

    var expressionGrammarDefinition = ExpressionGrammarParser({});
    var parser = expressionGrammarDefinition.build();
    var result = parser.parse(fullExpression);
    var expression = result.value as Expression;
    var value = expression.evaluate();

    return value;
  }
}

class AnswersData {
//  List<Answer> answers = List<Answer>();

  List<Answer> answers = [
//    Answer(questionId: 'Q1', value: 1),
//    Answer(questionId: 'Q1', value: 'xxxx', isNote: true, noteId: 1),
//    Answer(questionId: 'Q2', value: 2),
//    Answer(questionId: 'Q3', value: 3),
//    Answer(questionId: 'Q4', value: 4),
  ];
}

void main() {
  List<Answer> answerData = AnswersData().answers;

  String questionId = 'Q5';
  dynamic value = 1;
  bool isNote = true;
  int noteId = 1;

  Answer filteredAnswer = answerData.firstWhere((answer) {
    bool filteredResult = isNote ? answer.noteId == noteId : !answer.isNote;

    return (answer.questionId == questionId) && filteredResult;
  }, orElse: () => null);

  print(filteredAnswer);
}

//void main() {
////  Answers answerData = Answers();
//  Answers answerData = AnswersData().answers;
//  answerData.updateNote('Q1', 4, 'xxxxx');
//  answerData.updateNote('Q2', 3, 'zzzzz');
//  answerData.updateNote('Q1', 4, 'ccccc');
////  answerData.updateSingleAnswer('Q2', '22');
////
//  print(answerData.answers);
////
////  String expressionText = '((A || B) && C) || D';
////
////  Map<String, List> logic = {
////    'A': ['Q1', '==', 1],
////    'B': ['Q2', '!=', 2],
////    'C': [
////      'Q3',
////      'in',
////      [1, 4]
////    ],
////    'D': ['Q4', '<=', 4],
////  };
////
////  print(answerData.evaluateAllExpressions(logic, expressionText));
//}
