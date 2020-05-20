import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:surveystructure/blocs/blocs.dart';
import 'package:surveystructure/models/models.dart';
import 'package:meta/meta.dart';
import 'processed_questions.dart';

class ProcessedQuestionsBloc
    extends Bloc<ProcessedQuestionsEvent, ProcessedQuestionsState> {
  StreamSubscription questionsSubscription;
  StreamSubscription pageSubscription;
  StreamSubscription answersSubscription;

  // NOTE 訂閱 QuestionsState, PageState, AnswersState
  ProcessedQuestionsBloc({
    @required Stream<QuestionsState> questionsState,
    @required Stream<PageState> pageState,
    @required Stream<AnswersState> answersState,
  })  : assert(questionsState != null),
        assert(pageState != null),
        assert(answersState != null) {
    questionsSubscription = questionsState.listen((state) {
      if (state is QuestionsLoadSuccess) {
        add(QuestionsChanged(state.questions));
      }
    });
    pageSubscription = pageState.listen((state) {
      if (state is PageLoadSuccess) {
        add(PageChanged(state.page));
      }
    });
    answersSubscription = answersState.listen((state) {
//      print('****************************4****************************');
//      print(state);
//      print('****************************4****************************');
      if (state is AnswersState) {
        add(AnswersChanged(state.answers, state.allAnswerInfo));
      }
    });
  }

  @override
  Future<void> close() {
    questionsSubscription.cancel();
    pageSubscription.cancel();
    answersSubscription.cancel();
    return super.close();
  }

  @override
  ProcessedQuestionsState get initialState =>
      ProcessedQuestionsLoadInProgress();

  @override
  Stream<ProcessedQuestionsState> mapEventToState(
    ProcessedQuestionsEvent event,
  ) async* {
    if (event is ProcessedQuestionsLoaded) {
      yield ProcessedQuestionsLoadInProgress();
    } else if (event is PageChanged) {
      yield state.copyWith(page: event.page);
    } else if (event is AnswersChanged) {
      yield state.copyWith(
          answers: event.answers, allAnswerInfo: event.allAnswerInfo);
    } else if (event is QuestionsChanged) {
      yield state.copyWith(questions: event.questions);
    }

    if ((state as ProcessedQuestionsLoadInProgress).allFilled()) {
      yield* _mapProcessedQuestionsLoadedToState(state);
    }
  }

  Stream<ProcessedQuestionsState> _mapProcessedQuestionsLoadedToState(
      ProcessedQuestionsState state) async* {
//  try {

    List<Question> processedQuestions = state.questions.where((question) {
      if (question.page == state.page.currentPage) {
        AnswerInfo thisAnswerInfo = state.allAnswerInfo.singleWhere(
          (answerInfo) =>
              answerInfo.questionId == question.id &&
              answerInfo.isNote == false,
          orElse: () => null,
        );

        if (thisAnswerInfo != null) {
          if (thisAnswerInfo.answerStatus != AnswerStatus.skipped) {
            return true;
          }
        } else {
          return true;
        }
      }
      return false;
    }).toList();

    yield ProcessedQuestionsLoadSuccess(
      processedQuestions: processedQuestions,
      questions: state.questions,
      page: state.page,
      answers: state.answers,
      allAnswerInfo: state.allAnswerInfo,
    );

    //
//  } catch (_) {
//    yield ProcessedQuestionsLoadFailure();
//  }
  }
}
