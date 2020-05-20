import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surveystructure/blocs/answers/answers.dart';
import 'package:surveystructure/models/models.dart';
import 'questions.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
//  final AnswersBloc answersBloc;
//  StreamSubscription answersSubscription;
//
//  // NOTE 訂閱 answersBloc
//  QuestionsBloc({@required this.answersBloc}) {
//    answersSubscription = answersBloc.listen((state) {});
//  }

  @override
  QuestionsState get initialState => QuestionsLoadInProgress();

  @override
  Stream<QuestionsState> mapEventToState(
    QuestionsEvent event,
  ) async* {
    if (event is QuestionsLoaded) {
      yield* _mapQuestionsLoadedToState();
    }
  }

  Stream<QuestionsState> _mapQuestionsLoadedToState() async* {
    try {
      final QuestionBank questionBank = QuestionBank();
      final questions = questionBank.questions;

//      if (answersBloc.state is AnswersLoadSuccess) {
//        final answers = (answersBloc.state as AnswersLoadSuccess).answers;
//        yield QuestionsLoadSuccess(questions, answers);
//      }
      yield QuestionsLoadSuccess(questions);
    } catch (_) {
      yield QuestionsLoadFailure();
    }
  }

//  @override
//  Future<void> close() {
//    answersSubscription.cancel();
//    return super.close();
//  }
}
