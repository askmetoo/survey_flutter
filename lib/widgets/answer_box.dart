import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveystructure/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surveystructure/blocs/blocs.dart';
import 'package:surveystructure/keys.dart';

class AnswerBox extends StatelessWidget {
  const AnswerBox({
    Key key,
    @required this.question,
    @required this.answers,
  }) : super(key: key);

  final Question question;
  final List<Answer> answers;

  @override
  Widget build(BuildContext context) {
    final List<Choice> choices = question.choices;
    final Answer valueAnswer =
        answers.firstWhere((answer) => !answer.isNote, orElse: () => null);

    return Container(
      child: GridView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: choices.length,
//          scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 10,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          final choice = choices[index];
          final Answer noteAnswer = answers.firstWhere(
              (answer) => answer.isNote && answer.noteId == choice.value,
              orElse: () => null);
          return GestureDetector(
            key: SurveyStructureKeys.choice(question.id, choice.value),
            onTapUp: (_) => BlocProvider.of<AnswersBloc>(context).add(
              AnswerUpdated(question.id, question.type, choice.value),
            ),
            child: Row(
              children: <Widget>[
                if (question.type == QuestionType.single)
                  Radio(
                    value: choice.value,
                    groupValue: valueAnswer == null ? null : valueAnswer.value,
                    onChanged: (_) {},
                  )
                else if (question.type == QuestionType.multiple)
                  Checkbox(
                    value: valueAnswer == null
                        ? false
                        : valueAnswer.value == null
                            ? false
                            : valueAnswer.value.contains(choice.value),
                    onChanged: (_) {},
                  ),
                Text(
                  choice.label,
                  style: TextStyle(fontSize: 18),
                ),
                if (choice.type == ChoiceType.note)
                  Note(
                      question: question,
                      choice: choice,
                      noteAnswer: noteAnswer)
              ],
            ),
          );
        },
      ),
    );
  }
}

class Note extends StatefulWidget {
  const Note({
    Key key,
    @required this.question,
    @required this.choice,
    @required this.noteAnswer,
  }) : super(key: key);

  final Question question;
  final Choice choice;
  final Answer noteAnswer;

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(
      text: widget.noteAnswer == null ? '' : widget.noteAnswer.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: SurveyStructureKeys.note(widget.question.id, widget.choice.value),
      child: TextField(
        controller: _noteController,
        onChanged: (_) => BlocProvider.of<AnswersBloc>(context).add(
          AnswerUpdated(
              widget.question.id, widget.question.type, _noteController.text,
              isNote: true, noteId: widget.choice.value),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
}
