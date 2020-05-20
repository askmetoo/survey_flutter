import 'package:equatable/equatable.dart';
import 'package:surveystructure/blocs/answers/answers.dart';
import 'package:surveystructure/models/models.dart';

class AnswersState extends Equatable {
  final List<Answer> answers;
  final List<AnswerInfo> allAnswerInfo;
  final List<Question> questions;

  const AnswersState({this.answers, this.allAnswerInfo, this.questions});

  @override
  List<Object> get props => [answers, allAnswerInfo, questions];

  AnswersState copyWith({
    List<Answer> answers,
    List<AnswerInfo> allAnswerInfo,
    List<Question> questions,
  }) {
    return AnswersState(
      answers: answers ?? this.answers,
      allAnswerInfo: allAnswerInfo ?? this.allAnswerInfo,
      questions: questions ?? this.questions,
    );
  }
}

class InitialAnswersState extends AnswersState {
  final List<Answer> answers = List<Answer>();

  InitialAnswersState();

  @override
  List<Object> get props => [answers];

  @override
  String toString() => 'InitialAnswersState { answers: $answers }';
}

class AnswersLoadInProgress extends AnswersState {}

class AnswersLoadSuccess extends AnswersState {
  final List<Answer> answers;
  final List<AnswerInfo> allAnswerInfo;
  final List<Question> questions;

  const AnswersLoadSuccess(this.answers, this.allAnswerInfo, {this.questions});

  @override
  List<Object> get props => [answers, allAnswerInfo, questions];

  @override
  String toString() => 'AnswersLoadSuccess { answers: $answers, '
      'allAnswerInfo: $allAnswerInfo }';

  @override
  AnswersLoadSuccess copyWith({
    List<Answer> answers,
    List<AnswerInfo> allAnswerInfo,
    List<Question> questions,
  }) {
    return AnswersLoadSuccess(
      answers ?? this.answers,
      allAnswerInfo ?? this.allAnswerInfo,
      questions: questions ?? this.questions,
    );
  }
}

class AnswersLoadFailure extends AnswersState {}
