import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object> get props => [];
}

class QuestionsLoadInProgress extends QuestionsState {}

class QuestionsLoadSuccess extends QuestionsState {
  final List<Question> questions;

  const QuestionsLoadSuccess(this.questions);

  @override
  List<Object> get props => [questions];

  @override
  String toString() => 'QuestionsLoadSuccess { questions: $questions}';
}

class QuestionsLoadFailure extends QuestionsState {}
