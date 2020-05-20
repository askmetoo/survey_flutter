import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';

abstract class AnswersEvent extends Equatable {
  const AnswersEvent();

  @override
  List<Object> get props => [];
}

class AnswersLoaded extends AnswersEvent {}

class AnswerUpdated extends AnswersEvent {
  final String questionId;
  final QuestionType questionType;
  final dynamic value;
  final bool isNote;
  final int noteId;

  const AnswerUpdated(this.questionId, this.questionType, this.value,
      {this.isNote = false, this.noteId});

  @override
  List<Object> get props => [questionId, questionType, value, isNote, noteId];

  @override
  String toString() =>
      'AnswerUpdated { questionId: $questionId, questionType: $questionType, '
      'value: $value, isNote: $isNote, noteId: $noteId }';
}

class AnswerCleared extends AnswersEvent {}

class QuestionsUpdated extends AnswersEvent {
  final List<Question> questions;

  const QuestionsUpdated(this.questions);

  @override
  List<Object> get props => [questions];

  @override
  String toString() => 'QuestionsUpdated { questions: $questions}';
}
