//class ClassA {
//  final int id;
//  final int group;
//  ClassA(this.id, this.group);
//
//  @override
//  String toString() {
//    return 'ClassA { id: $id, group: $group }';
//  }
//}
//
//void main() {
//  print(123);
//
//  var z = [
//    ClassA(1, 3),
//    ClassA(2, 1),
//    ClassA(3, 1),
//    ClassA(42, 1),
//    ClassA(3, 1),
//    ClassA(12, 1),
//    ClassA(73, 1),
//    ClassA(332, 1),
//    ClassA(3, 1),
//  ];
//
//  print(
//    z.where((element) => element.group == 1)
//      ..map((element) => element.toString()),
//  );
//}

import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/question_type.dart';
import 'package:expression_language/expression_language.dart';

class Question extends Equatable {
  final String id;
  final QuestionType type;
  final String question;
  final String description;
  final String showUpLogic;
  final String validation;
  final int page;

  Question({
    this.id,
    this.type,
    this.question,
    this.description,
    this.showUpLogic,
    this.validation,
    this.page,
  });

  @override
  List<Object> get props =>
      [id, type, question, description, showUpLogic, validation, page];

  @override
  String toString() {
    return 'Question { id: $id, type: $type, question: $question, description: $description, showUpLogic: $showUpLogic, validation: $validation, page: $page } \n';
  }
}

class QuestionData {
  List<Question> questions = [
    Question(
      id: '1',
      type: QuestionType.single,
      question: '題目1',
      description: '說明1',
      showUpLogic: '',
      validation: '',
      page: 1,
    ),
    Question(
      id: '2',
      type: QuestionType.single,
      question: '題目2',
      description: '說明2',
      showUpLogic: '',
      validation: '',
      page: 1,
    ),
    Question(
      id: '3',
      type: QuestionType.single,
      question: '題目3',
      description: '說明3',
      showUpLogic: '',
      validation: '',
      page: 2,
    ),
  ];

//  String pageQuestion(int page) {
//    var filteredQuestion = questions.where((element) => element.page == page)
//      ..map((element) => element.toString());
//    return filteredQuestion;
//  }
}

class TestElement extends ExpressionProviderElement {
  Map<String, dynamic> properties = {
    'value': ConstantExpressionProvider<Integer>(Integer(27)),
    'label': ConstantExpressionProvider<String>('LabelText'),
    'intValue': ConstantExpressionProvider<int>(14),
    'doubleValue': ConstantExpressionProvider<double>(6.5),
  };

  @override
  ExpressionProvider getExpressionProvider([String propertyName]) {
    if (propertyName == null || propertyName == '') {
      propertyName = 'value';
    }
    return properties[propertyName];
  }

  @override
  ExpressionProviderElement clone(
      ExpressionProvider<ExpressionProviderElement> parent) {
    //Nothing to do
    return null;
  }
}

class ConstantExpressionProvider<T> extends ExpressionProvider<T> {
  final T value;

  ConstantExpressionProvider(this.value);

  @override
  Expression<T> getExpression() {
    return ConstantExpression(value);
  }
}

void main() {
  var expressionGrammarDefinition =
      ExpressionGrammarParser({'testElement': TestElement()});

  var parser = expressionGrammarDefinition.build();
  var result = parser.parse('@testElement.value == 27.0');
  var expression = result.value as Expression;
  var value = expression.evaluate();
  print(value);
}
