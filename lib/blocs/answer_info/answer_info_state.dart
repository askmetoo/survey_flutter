import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';

abstract class AnswerInfoState extends Equatable {
  const AnswerInfoState();

  @override
  List<Object> get props => [];
}

class InitialAnswerInfoState extends AnswerInfoState {
  final Map<String, AnswerInfo> answerInfo = Map<String, AnswerInfo>();

  InitialAnswerInfoState();

  @override
  List<Object> get props => [answerInfo];

  @override
  String toString() => 'InitialAnswerInfoState { answerInfo: $answerInfo }';
}

class AnswerInfoLoadInProgress extends AnswerInfoState {}

class AnswerInfoLoadSuccess extends AnswerInfoState {
  final String answerInfo;

  const AnswerInfoLoadSuccess(this.answerInfo);

  @override
  List<Object> get props => [answerInfo];

  @override
  String toString() => 'AnswerInfoLoadSuccess { answerInfo: $answerInfo }';
}

class AnswerInfoLoadFailure extends AnswerInfoState {}
