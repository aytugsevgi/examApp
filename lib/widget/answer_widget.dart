import 'package:examapp/controllers/exam_controller.dart';
import 'package:examapp/model/answer.dart';
import 'package:examapp/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnswerWidget extends StatefulWidget {
  final bool isPreview;
  final Answer answer;
  final int index;
  final String submittedAnswer;
  const AnswerWidget({
    Key key,
    this.answer,
    this.index,
    this.isPreview = false,
    this.submittedAnswer,
  }) : super(key: key);
  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  @override
  Widget build(BuildContext context) {
    print("DEBUG: isPreview: ${widget.isPreview}");
    return Row(
      children: [
        Checkbox(
            activeColor: widget.isPreview ? Colors.grey : Colors.green,
            value: widget.isPreview
                ? widget.submittedAnswer == widget.answer.id
                : context.watch<ExamController>().answerList[widget.index] ==
                    widget.answer.id,
            onChanged: (value) {
              if (!widget.isPreview) {
                if (!value) {
                  context.read<ExamController>().setAnswer(widget.index, null);
                } else {
                  context
                      .read<ExamController>()
                      .setAnswer(widget.index, widget.answer.id);
                }
              }
            }),
        SizedBox(
          width: 10,
        ),
        Text(
          widget.answer.content,
          style: context.themeData.textTheme.display3.copyWith(
            color: !widget.isPreview
                ? Colors.black
                : widget.answer.isCorrect
                    ? Colors.green
                    : Colors.black,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        answerStatus(),
      ],
    );
  }

  Widget answerStatus() {
    // kullanıcının cevabı ile doğru cevap aynı ise
    if (widget.submittedAnswer == widget.answer.id && widget.answer.isCorrect) {
      return Text(
        "X",
        style:
            context.themeData.textTheme.display3.copyWith(color: Colors.green),
      );
    }
    // kullanıcının cevabı fakat doğru cevap değil
    else if (widget.submittedAnswer == widget.answer.id) {
      return Text(
        "Y",
        style: context.themeData.textTheme.display3.copyWith(color: Colors.red),
      );
    }
    return SizedBox.shrink();
  }
}
