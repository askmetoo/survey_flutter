import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surveystructure/blocs/blocs.dart';
import 'package:surveystructure/models/models.dart';
import 'package:surveystructure/widgets/widgets.dart';

class Contents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        if (state is QuestionsLoadSuccess) {
          // TODO 可以把篩選邏輯放進 Bloc
          final List<Question> filteredQuestions = state.questions;
          return ListView.builder(
              itemCount: filteredQuestions.length,
              itemBuilder: (BuildContext context, int index) {
                final question = filteredQuestions[index].question;
                final page = filteredQuestions[index].page;
                return ListTile(
                  title: Text(question),
                  onTap: () => BlocProvider.of<PageBloc>(context).add(
                    PageTurned(
                      PageTurnedType.specific,
                      targetPage: page,
                    ),
                  ),
                );
              });
        } else {
          return Container();
        }
      },
    );
  }
}
