import 'package:examapp/controllers/exam_controller.dart';
import 'package:examapp/model/answer.dart';
import 'package:examapp/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnswerWidget extends StatefulWidget {
  final Answer answer;
  final int index;

  const AnswerWidget({Key key, this.answer, this.index}) : super(key: key);
  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            activeColor: Colors.green,
            value: context.watch<ExamController>().answerList[widget.index] ==
                widget.answer.id,
            onChanged: (value) {
              if (!value) {
                context.read<ExamController>().setAnswer(widget.index, null);
              } else {
                context
                    .read<ExamController>()
                    .setAnswer(widget.index, widget.answer.id);
              }
            }),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 350,
          child: Text(
            widget.answer.content,
            style: context.themeData.textTheme.display3,
          ),
        ),
      ],
    );
  }
}
