import 'dart:async';
import 'package:bloc/bloc.dart';
import 'answer_info.dart';
import 'package:surveystructure/models/models.dart';
import 'package:surveystructure/blocs/answers/answers.dart';
import 'package:meta/meta.dart';

class AnswerInfoBloc extends Bloc<AnswerInfoEvent, AnswerInfoState> {
  final AnswersBloc answersBloc;
  StreamSubscription answersSubscription;

  // NOTE 訂閱 answersBloc
  AnswerInfoBloc({@required this.answersBloc}) {
    answersSubscription = answersBloc.listen((state) {
      if (state is AnswersLoadSuccess) {
//        add(AnswerInfoUpdated(state.answers, state.answerEvent));
      }
    });
  }

  @override
  AnswerInfoState get initialState => InitialAnswerInfoState();

  @override
  Stream<AnswerInfoState> mapEventToState(
    AnswerInfoEvent event,
  ) async* {
    if (event is AnswerInfoUpdated) {
      yield* _mapAnswerInfoUpdatedToState(event);
    } else if (event is AnswerInfoLoaded) {
      yield* _mapAnswerInfoLoadedToState(event);
    }
  }

  Stream<AnswerInfoState> _mapAnswerInfoUpdatedToState(
      AnswerInfoEvent event) async* {
    try {
//      yield AnswerInfoLoadSuccess('test');
    } catch (_) {
      yield AnswerInfoLoadFailure();
    }
  }

  Stream<AnswerInfoState> _mapAnswerInfoLoadedToState(
      AnswerInfoEvent event) async* {
    try {
//      yield AnswerInfoLoadSuccess('test');
    } catch (_) {
      yield AnswerInfoLoadFailure();
    }
  }

  @override
  Future<void> close() {
    answersSubscription.cancel();
    return super.close();
  }
}
