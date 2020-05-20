import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:surveystructure/blocs/blocs.dart';
import 'package:surveystructure/models/models.dart';
import 'answers.dart';
import 'package:meta/meta.dart';
import 'package:expression_language/expression_language.dart';

class AnswersBloc extends Bloc<AnswersEvent, AnswersState> {
  StreamSubscription questionsSubscription;

  // NOTE 訂閱 questionsBloc
  AnswersBloc({@required Stream<QuestionsState> questionsState})
      // NOTE 好習慣，加 assert
      : assert(questionsState != null) {
    questionsSubscription = questionsState.listen((state) {
      if (state is QuestionsLoadSuccess) {
        add(QuestionsUpdated(state.questions));
      }
    });
  }

  @override
  Future<void> close() {
    questionsSubscription.cancel();
    return super.close();
  }

  @override
  AnswersState get initialState => InitialAnswersState();

  @override
  Stream<AnswersState> mapEventToState(
    AnswersEvent event,
  ) async* {
    if (event is QuestionsUpdated) {
      // TODO 如果題目真的有改變，應該是需要刷新作答的資料，不過這邊先只是重新 load 資料
      yield state.copyWith(questions: event.questions);
      yield* _mapAnswersLoadedToState();
    }

//    if (event is AnswersLoaded) {
//      print('****************************5****************************');
//      print(state);
//      print('****************************5****************************');
//      yield* _mapAnswersLoadedToState();
//    } else
    if (event is AnswerUpdated) {
      yield* _mapAnswerUpdatedToState(event);
    } else if (event is AnswerCleared) {
      yield* _mapAnswerClearedToState(event);
    }
  }

  Stream<AnswersState> _mapAnswersLoadedToState() async* {
//    try {
    final AnswersData answersData = AnswersData();
    final List<Answer> answers = answersData.answers;
    final AnswerInfoData answerInfoData = AnswerInfoData();

//      final allAnswerInfo = answerInfoData.allAnswerInfo;
    final List<AnswerInfo> allAnswerInfo =
        _checkAllLogic(answers, answerInfoData.allAnswerInfo);

    yield AnswersLoadSuccess(answers, allAnswerInfo,
        questions: state.questions);
//    } catch (_) {
//      yield AnswersLoadFailure();
//    }
  }

  Stream<AnswersState> _mapAnswerUpdatedToState(AnswersEvent event) async* {
//    try {
    if (state is AnswersLoadSuccess) {
      final questionId = (event as AnswerUpdated).questionId;
      final questionType = (event as AnswerUpdated).questionType;
      final answerValue = (event as AnswerUpdated).value;
      final isNote = (event as AnswerUpdated).isNote;
      final noteId = (event as AnswerUpdated).noteId;
      List<Answer> answers = (state as AnswersLoadSuccess).answers;

      // HIGHLIGHT 多選必須加上 AnswersLoadInProgress 才有辦法即時更新！
      // NOTE 好習慣是只要進到 mapEventToState 都要加
      yield AnswersLoadInProgress();

      // TAG 1. 篩出該題（該說明）的作答，若還未作答過時新增初始化答案
      List<Answer> thisAnswer = answers.where((answer) {
        bool filteredResult = isNote ? answer.noteId == noteId : !answer.isNote;

        return (answer.questionId == questionId) && filteredResult;
      }).toList();

      if (thisAnswer.isEmpty) {
        answers.add(
          Answer(questionId: questionId, isNote: isNote, noteId: noteId),
        );
      }

      // TAG 2. 更新作答
      List<Answer> updateAnswers;
      List<AnswerInfo> newAnswerInfo;
      updateAnswers = answers.map((answer) {
        Answer newAnswer;
        bool filteredResult = isNote ? answer.noteId == noteId : !answer.isNote;

        if (answer.questionId == questionId && filteredResult) {
          // TAG 2.1 更新單一作答
          if (questionType == QuestionType.single || isNote) {
            newAnswer = answer.copyWith(value: answerValue);
            // TAG 2.2 更新多重作答
          } else if (questionType == QuestionType.multiple) {
            // 取得之前作答，若還未作答過時初始化答案
            List<int> newValue =
                answer.value == null ? List<int>() : answer.value;
            if (newValue.contains(answerValue)) {
              newValue.remove(answerValue);
            } else {
              newValue.add(answerValue);
            }
            newAnswer = answer.copyWith(value: newValue);
          }
          newAnswerInfo = _updateAnswerInfo(newAnswer);
        }

        return newAnswer == null ? answer : newAnswer;
      }).toList();

      newAnswerInfo = _checkAllLogic(updateAnswers, newAnswerInfo);

      yield AnswersLoadSuccess(updateAnswers, newAnswerInfo,
          questions: state.questions);
    }

//    } catch (_) {
//      yield AnswersLoadFailure();
//    }
  }

  Stream<AnswersState> _mapAnswerClearedToState(AnswersEvent event) async* {}

  // TAG 3 更新(單元)作答資訊
  List<AnswerInfo> _updateAnswerInfo(Answer answer) {
    ValidationResult validationResult = _validateAnswer(answer);
    AnswerStatus answerStatus = _updateAnswerStatus(answer, validationResult);

    // 目前所有作答資訊
    List<AnswerInfo> updateAllAnswerInfo =
        (state as AnswersLoadSuccess).allAnswerInfo;

    // 篩出該題（該說明）的作答資訊，若還未作答過時新增初始化作答資訊
    AnswerInfo thisAnswerInfo = updateAllAnswerInfo.singleWhere(
      (answerInfo) {
        bool filteredResult = answer.isNote
            ? answerInfo.noteId == answer.noteId
            : !answerInfo.isNote;
        return (answerInfo.questionId == answer.questionId && filteredResult);
      },
      orElse: () => null,
    );

    AnswerInfo newAnswerInfo;
    if (thisAnswerInfo == null) {
      thisAnswerInfo = AnswerInfo(
        questionId: answer.questionId,
        isNote: answer.isNote,
        noteId: answer.noteId,
      );
      newAnswerInfo = thisAnswerInfo;
    }

    newAnswerInfo = thisAnswerInfo.copyWith(
      answerStatus: answerStatus,
      isOtherAnswer: false,
      validationResult: validationResult,
    );

    // 在該題作答資訊有更新時才會更新進所有作答資訊
    if (newAnswerInfo != null && newAnswerInfo != thisAnswerInfo) {
      updateAllAnswerInfo.removeWhere((answerInfo) {
        bool filteredResult = answer.isNote
            ? answerInfo.noteId == answer.noteId
            : !answerInfo.isNote;
        return (answerInfo.questionId == answer.questionId && filteredResult);
      });
      updateAllAnswerInfo.add(newAnswerInfo);
    }

    return updateAllAnswerInfo;
  }

  // TAG 3.1 驗證作答是否符合設定
  ValidationResult _validateAnswer(Answer answer) {
    ValidationResult result = ValidationResult(pass: true);

    return result;
  }

// TAG 3.2 更新作答狀態
  AnswerStatus _updateAnswerStatus(
      Answer answer, ValidationResult validationResult) {
    AnswerStatus status;

    status = AnswerStatus.answered;

    // TODO
    if (false) {
      status = AnswerStatus.skipped;
    }

    if (answer.value == null) {
      status = AnswerStatus.unanswered;
    }

    // 如果是多選或說明，且作答長度為零
    Question thisQuestion = state.questions
        .singleWhere((question) => question.id == answer.questionId);
    if (thisQuestion.type == QuestionType.multiple || answer.isNote) {
      if (answer.value.length == 0) {
        status = AnswerStatus.unanswered;
      }
    }

    if (!validationResult.pass) {
      status = AnswerStatus.wrong_answered;
    }

    return status;
  }

  // TAG 4. 重跑此問卷的所有題目出現邏輯，並進而改變受影響題目的答題狀況
  List<AnswerInfo> _checkAllLogic(
      List<Answer> answers, List<AnswerInfo> allAnswerInfo) {
    List<AnswerInfo> updateAllAnswerInfo = allAnswerInfo;

    // NOTE 要按照題目順序跑邏輯，所以不能用 .map()
    for (var i = 0; i < state.questions.length; i++) {
      AnswerInfo newAnswerInfo;
      AnswerInfo thisAnswerInfo;
      AnswerStatus newAnswerStatus;
      Question question = state.questions[i];

      // 篩出該題的作答資訊
      thisAnswerInfo = updateAllAnswerInfo.singleWhere(
        (answerInfo) =>
            answerInfo.questionId == question.id && answerInfo.isNote == false,
        orElse: () => null,
      );

      // 會在第一次答題時初始化所有題目的作答資訊
      if (thisAnswerInfo == null) {
        thisAnswerInfo = AnswerInfo(
          questionId: question.id,
          answerStatus: AnswerStatus.unanswered,
        );
        newAnswerInfo = thisAnswerInfo;
      }

      // 如果該題有設定題目出現邏輯
      if (question.showUpLogic != null) {
        bool evaluateResult =
            _evaluateShowUpLogic(question.showUpLogic, answers);
        if (evaluateResult == true) {
          if (thisAnswerInfo.answerStatus == AnswerStatus.skipped) {
            newAnswerStatus = AnswerStatus.unanswered;
          } else {
            newAnswerStatus = thisAnswerInfo.answerStatus;
          }
        } else {
          newAnswerStatus = AnswerStatus.skipped;
        }
        newAnswerInfo = thisAnswerInfo.copyWith(
          answerStatus: newAnswerStatus,
        );
      }

      // 在該題作答資訊有更新時才會更新進所有作答資訊
      if (newAnswerInfo != null && newAnswerInfo != thisAnswerInfo) {
        updateAllAnswerInfo.removeWhere((answerInfo) =>
            answerInfo.questionId == question.id && answerInfo.isNote == false);
        updateAllAnswerInfo.add(newAnswerInfo);
      }
    }

    return updateAllAnswerInfo;
  }

  bool _compareAnswer(SingleExpression expression, List<Answer> answers) {
    // 每個子邏輯進行比較，給出 true/false
    // (Q1 != 3) -> true/false

    Answer thisAnswer = answers.singleWhere(
      (answer) => answer.questionId == expression.questionId && !answer.isNote,
      orElse: () => null,
    );
    if (thisAnswer == null) {
      return false;
    } else {
      var head = expression.switchSide ? expression.target : thisAnswer.value;
      var tail = expression.switchSide ? thisAnswer.value : expression.target;
      print('$head ${expression.operator} $tail');

      switch (expression.operator) {
        case '==':
          return head == tail;
        case '!=':
          return head != tail;
        case 'in':
          return tail.contains(head);
        case 'notin':
          return !tail.contains(head);
        case '>':
          return head > tail;
        case '<':
          return head < tail;
        case '>=':
          return head >= tail;
        case '<=':
          return head <= tail;
        default:
          return false;
      }
    }
  }

  bool _evaluateShowUpLogic(ShowUpLogic showUpLogic, List<Answer> answers) {
    // 結合所有子邏輯，判斷該題最終是否要出現，給出 true/false
    // (((A || B) && C) || D) -> true/false
    // A -> (Q1 != 3)
    Map newLogic = {};
    showUpLogic.expressions.forEach((index, expression) {
      newLogic[index] = _compareAnswer(expression, answers);
    });

    print(newLogic);

    String fullExpression = showUpLogic.fullExpression;
    newLogic.forEach((index, value) {
      fullExpression = fullExpression.replaceAll(index, value.toString());
    });

    print(fullExpression);

    var expressionGrammarDefinition = ExpressionGrammarParser({});
    var parser = expressionGrammarDefinition.build();
    var result = parser.parse(fullExpression);
    var expression = result.value as Expression;
    var value = expression.evaluate();

    return value;
  }

// TODO 6. 更新(所有)受影響題目的作答
}
