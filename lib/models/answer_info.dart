import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';

// TODO 改成新架構
class AnswerInfo extends Equatable {
  final String questionId;
  final AnswerStatus answerStatus;
  final bool isOtherAnswer;
  final ValidationResult validationResult;
  final bool isNote;
  final int noteId;

  AnswerInfo(
      {this.questionId,
      this.answerStatus,
      this.isOtherAnswer,
      this.validationResult,
      bool isNote = false,
      this.noteId})
      : isNote = isNote ?? false;

  @override
  List<Object> get props => [
        questionId,
        answerStatus,
        validationResult,
        isOtherAnswer,
        isNote,
        noteId
      ];

  @override
  String toString() {
    return 'AnswerInfo { questionId: $questionId, answerStatus: $answerStatus, '
        'isOtherAnswer: $isOtherAnswer, validationResult: $validationResult, '
        'isNote: $isNote, noteId: $noteId} \n';
  }

  AnswerInfo copyWith(
      {String questionId,
      AnswerStatus answerStatus,
      bool isOtherAnswer,
      ValidationResult validationResult,
      bool isNote,
      int noteId}) {
    return AnswerInfo(
      questionId: questionId ?? this.questionId,
      answerStatus: answerStatus ?? this.answerStatus,
      isOtherAnswer: isOtherAnswer ?? this.isOtherAnswer,
      validationResult: validationResult ?? this.validationResult,
      isNote: isNote ?? this.isNote,
      noteId: noteId ?? this.noteId,
    );
  }
}

class AnswerInfoData {
  List<AnswerInfo> allAnswerInfo = [];
}

//class AnswerInfoUnit extends Equatable {
//  final AnswerInfo valueAnswerInfo;
//  final dynamic noteAnswerInfo;
//
//  AnswerInfoUnit({this.valueAnswerInfo, this.noteAnswerInfo});
//
//  @override
//  List<Object> get props => [valueAnswerInfo, noteAnswerInfo];
//
//  @override
//  String toString() {
//    return 'AnswerInfoUnit { valueAnswerInfo: $valueAnswerInfo, note: $noteAnswerInfo} \n';
//  }
//
//  AnswerInfoUnit copyWith({dynamic valueAnswerInfo, dynamic noteAnswerInfo}) {
//    return AnswerInfoUnit(
//      valueAnswerInfo: valueAnswerInfo ?? this.valueAnswerInfo,
//      noteAnswerInfo: noteAnswerInfo ?? this.noteAnswerInfo,
//    );
//  }
//}
