import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';

// NOTE 因為 LoadInProgress, LoadSuccess 都需要 copyWith，所以就拿掉 abstract
class ProcessedQuestionsState extends Equatable {
  final List<Question> questions;
  final Page page;
  final List<Answer> answers;
  final List<AnswerInfo> allAnswerInfo;

  const ProcessedQuestionsState({
    this.questions,
    this.page,
    this.answers,
    this.allAnswerInfo,
  });

  @override
  List<Object> get props => [questions, page, answers, allAnswerInfo];

  ProcessedQuestionsLoadInProgress copyWith({
    List<Question> questions,
    Page page,
    List<Answer> answers,
    List<AnswerInfo> allAnswerInfo,
  }) {
    return ProcessedQuestionsLoadInProgress(
      questions: questions ?? this.questions,
      page: page ?? this.page,
      answers: answers ?? this.answers,
      allAnswerInfo: allAnswerInfo ?? this.allAnswerInfo,
    );
  }
}

//class InitialProcessedQuestionsState extends ProcessedQuestionsState {
//  @override
//  List<Object> get props => [];
//}

class ProcessedQuestionsLoadInProgress extends ProcessedQuestionsState {
  final List<Question> questions;
  final Page page;
  final List<Answer> answers;
  final List<AnswerInfo> allAnswerInfo;

  const ProcessedQuestionsLoadInProgress({
    this.questions,
    this.page,
    this.answers,
    this.allAnswerInfo,
  });

  @override
  List<Object> get props => [questions, page, answers, allAnswerInfo];

  @override
  String toString() =>
      'ProcessedQuestionsLoadInProgress { questions: $questions, '
      'page: $page, answers: $answers, allAnswerInfo: $allAnswerInfo, }';

  bool allFilled() {
    return questions != null &&
        page != null &&
        answers != null &&
        allAnswerInfo != null;
  }
}

class ProcessedQuestionsLoadSuccess extends ProcessedQuestionsState {
  final List<Question> processedQuestions;
  final List<Question> questions;
  final Page page;
  final List<Answer> answers;
  final List<AnswerInfo> allAnswerInfo;

  const ProcessedQuestionsLoadSuccess({
    this.processedQuestions,
    this.questions,
    this.page,
    this.answers,
    this.allAnswerInfo,
  });

  @override
  List<Object> get props =>
      [processedQuestions, questions, page, answers, allAnswerInfo];

  @override
  String toString() =>
      'ProcessedQuestionsLoadSuccess { processedQuestions: $processedQuestions}';
}

class ProcessedQuestionsLoadFailure extends ProcessedQuestionsState {}
