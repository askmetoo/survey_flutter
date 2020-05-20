import 'package:equatable/equatable.dart';

class ShowUpLogic extends Equatable {
  final String fullExpression;
  final Map<String, SingleExpression> expressions;

  ShowUpLogic({this.fullExpression, this.expressions});

  @override
  List<Object> get props => [fullExpression, expressions];

  @override
  String toString() {
    return 'ShowUpLogic { fullExpression: $fullExpression, '
        'expressions: $expressions } \n';
  }
}

class SingleExpression extends Equatable {
  final String questionId;
  final String operator;
  final dynamic target;
  final bool switchSide;

  SingleExpression(
      {this.questionId, this.operator, this.target, bool switchSide = false})
      : switchSide = switchSide ?? false;

  @override
  List<Object> get props => [questionId, operator, target, switchSide];

  @override
  String toString() {
    return 'SingleExpression { questionId: $questionId, operator: $operator, '
        'target: $target, switchSide: $switchSide } \n';
  }
}
