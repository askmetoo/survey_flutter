import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';
import 'package:surveystructure/blocs/answers/answers.dart';

abstract class AnswerInfoEvent extends Equatable {
  const AnswerInfoEvent();

  @override
  List<Object> get props => [];
}

class AnswerInfoLoaded extends AnswerInfoEvent {}

class AnswerInfoUpdated extends AnswerInfoEvent {
  final Map<String, Answer> answers;
  final AnswerUpdated answerEvent;

  const AnswerInfoUpdated(this.answers, this.answerEvent);

  @override
  List<Object> get props => [answers, answerEvent];

  @override
  String toString() => 'AnswerInfoUpdated { answers: $answers, '
      'answerEvent: $answerEvent }';
}
