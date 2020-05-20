import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surveystructure/blocs/blocs.dart';
import 'package:surveystructure/blocs/processed_questions/processed_questions.dart';
import 'package:surveystructure/models/models.dart';
import 'package:surveystructure/widgets/widgets.dart';

class QuestionsList extends StatelessWidget {
  final int page;

  QuestionsList(
    this.page, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessedQuestionsBloc, ProcessedQuestionsState>(
      builder: (context, processedQuestionsState) {
        if (processedQuestionsState is ProcessedQuestionsLoadSuccess) {
          final List<Question> filteredQuestions =
              processedQuestionsState.processedQuestions;
          return ListView.builder(
              itemCount: filteredQuestions.length,
              itemBuilder: (BuildContext context, int index) {
                final Question question = filteredQuestions[index];
                return BlocBuilder<AnswersBloc, AnswersState>(
                  builder: (context, answersState) {
                    if (answersState is AnswersLoadSuccess) {
                      final answers = answersState.answers
                          .where((answer) => answer.questionId == question.id)
                          .toList();
                      return QuestionCard(
                        question: question,
                        answers: answers,
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              });
        } else {
          return Container();
        }
      },
    );
  }
}
