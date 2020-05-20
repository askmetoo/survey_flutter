import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surveystructure/models/models.dart';
import 'package:surveystructure/blocs/blocs.dart';
import 'package:surveystructure/widgets/widgets.dart';

class QuestionsScreen extends StatelessWidget {
//  static String id = 'question_screen';
  // TODO 這邊暫時當首頁，之後改回來
  static String id = '/';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnswerInfoBloc, AnswerInfoState>(
      listener: (context, answerInfoState) {
        print('***********1*********');
        if (answerInfoState is AnswerInfoLoadSuccess) {
          print('**********2**********');
          print(answerInfoState.answerInfo);
        }
      },
      child: BlocBuilder<PageBloc, PageState>(
        builder: (context, state) {
          if (state is PageLoadSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Questions Screen'),
              ),
              body: QuestionsList(state.page.currentPage),
              bottomNavigationBar: Container(
                color: Colors.grey[900],
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TurnPageButton(
                      '上一頁',
                      onPressed: () => BlocProvider.of<PageBloc>(context).add(
                        PageTurned(PageTurnedType.previous),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      state.page.currentPage.toString(),
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    TurnPageButton(
                      '下一頁',
                      onPressed: () => BlocProvider.of<PageBloc>(context).add(
                        PageTurned(PageTurnedType.next),
                      ),
                    ),
//                  BlocBuilder<AnswerInfoBloc, AnswerInfoState>(
//                      builder: (context, answerInfoState) {
//                    print('***********1*********');
//                    if (answerInfoState is AnswerInfoLoadSuccess) {
//                      print('**********2**********');
//                      print(answerInfoState.answerInfo);
//                    }
//                    return Container();
//                  })
                  ],
                ),
              ),
              drawer: Drawer(
                child: Contents(),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        if (state is PageLoadSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Questions Screen'),
            ),
            body: QuestionsList(state.page.currentPage),
            bottomNavigationBar: Container(
              color: Colors.grey[900],
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TurnPageButton(
                    '上一頁',
                    onPressed: () => BlocProvider.of<PageBloc>(context).add(
                      PageTurned(PageTurnedType.previous),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Text(
                    state.page.currentPage.toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  TurnPageButton(
                    '下一頁',
                    onPressed: () => BlocProvider.of<PageBloc>(context).add(
                      PageTurned(PageTurnedType.next),
                    ),
                  ),
//                  BlocBuilder<AnswerInfoBloc, AnswerInfoState>(
//                      builder: (context, answerInfoState) {
//                    print('***********1*********');
//                    if (answerInfoState is AnswerInfoLoadSuccess) {
//                      print('**********2**********');
//                      print(answerInfoState.answerInfo);
//                    }
//                    return Container();
//                  })
                ],
              ),
            ),
            drawer: Drawer(
              child: Contents(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
