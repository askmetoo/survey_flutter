import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';

abstract class ProcessedQuestionsEvent extends Equatable {
  const ProcessedQuestionsEvent();

  @override
  List<Object> get props => [];
}

class ProcessedQuestionsLoaded extends ProcessedQuestionsEvent {}

class PageChanged extends ProcessedQuestionsEvent {
  final Page page;

  const PageChanged(this.page);

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'PageChanged { page: $page }';
}

class AnswersChanged extends ProcessedQuestionsEvent {
  final List<Answer> answers;
  final List<AnswerInfo> allAnswerInfo;

  const AnswersChanged(this.answers, this.allAnswerInfo);

  @override
  List<Object> get props => [answers, allAnswerInfo];

  @override
  String toString() =>
      'AnswersChanged { answers: $answers, allAnswerInfo: $allAnswerInfo }';
}

class QuestionsChanged extends ProcessedQuestionsEvent {
  final List<Question> questions;

  const QuestionsChanged(this.questions);

  @override
  List<Object> get props => [questions];

  @override
  String toString() => 'QuestionsChanged { questions: $questions }';
}
