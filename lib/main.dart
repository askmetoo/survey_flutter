import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surveystructure/blocs/blocs.dart';
import 'package:surveystructure/blocs/processed_questions/processed_questions.dart';
import 'package:surveystructure/models/models.dart';
import 'package:surveystructure/screens/screens.dart';
import 'routes.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey Structure',
      theme: ThemeData.dark(),
      routes: {
        Routes.questionsScreen: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<QuestionsBloc>(
                create: (context) {
                  return QuestionsBloc()..add(QuestionsLoaded());
                },
              ),
              BlocProvider<AnswersBloc>(
                create: (context) {
                  return AnswersBloc(
                    questionsState: BlocProvider.of<QuestionsBloc>(context),
                  );
                },
              ),
              BlocProvider<AnswerInfoBloc>(
                create: (context) {
                  return AnswerInfoBloc(
                    answersBloc: BlocProvider.of<AnswersBloc>(context),
                  );
                },
              ),
              BlocProvider<PageBloc>(
                create: (context) {
                  return PageBloc()..add(PageLoaded());
                },
              ),
              BlocProvider<ProcessedQuestionsBloc>(
                create: (context) {
                  return ProcessedQuestionsBloc(
                    questionsState: BlocProvider.of<QuestionsBloc>(context),
                    answersState: BlocProvider.of<AnswersBloc>(context),
                    pageState: BlocProvider.of<PageBloc>(context),
                  )..add(ProcessedQuestionsLoaded());
                },
              ),
            ],
            child: QuestionsScreen(),
          );
        }
      },
    );
  }
}
