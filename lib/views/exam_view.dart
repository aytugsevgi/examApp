import 'package:examapp/controllers/exam_controller.dart';
import 'package:examapp/model/answer.dart';
import 'package:examapp/model/question.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/widget/answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamView extends StatelessWidget {
  final String examId;

  ExamView(this.examId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 160,
          leading: Center(
            child: RichText(
              maxLines: 1,
              text: TextSpan(
                  style: context.themeData.textTheme.display1,
                  children: [
                    TextSpan(text: "E"),
                    TextSpan(text: "G"),
                    TextSpan(text: "E"),
                    TextSpan(
                      text: "xam",
                      style: context.themeData.textTheme.display1.copyWith(
                        color: Color(0xFFFD7272),
                      ),
                    ),
                  ]),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "${context.read<ExamController>().exam.title}",
            style: context.themeData.textTheme.display1
                .copyWith(color: context.themeData.primaryColor),
          ),
          actions: [
            Center(
              child: Text(
                "Remain Time",
                style: context.themeData.textTheme.display3
                    .copyWith(color: context.themeData.primaryColor),
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Center(
              child: Container(
                width: 80,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: FittedBox(
                  child: Text(
                    "${context.watch<ExamController>().remainTimeMin.force2digitToString} : ${context.watch<ExamController>().remainTimeSec.force2digitToString}",
                    style: context.themeData.textTheme.display3.copyWith(
                        color: context.themeData.primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: context.themeData.accentColor,
          label: Text("Submit", style: context.themeData.textTheme.display3),
          onPressed: () {},
        ),
        body: ListView.builder(
          itemCount: context.read<ExamController>().questions.length,
          itemBuilder: (context, index) {
            return savedQuestions(
                context,
                index,
                context.read<ExamController>().questions[index].keys.first,
                context.read<ExamController>().questions[index].values.first);
          },
        ));
  }

  Widget savedQuestions(BuildContext context, int index, Question question,
      List<Answer> answers) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero)),
          onPressed: () {},
          child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: context.dynamicHeight(0.01),
                  horizontal: context.dynamicWidth(0.01)),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Q$index)  ${question.title}",
                        style: context.themeData.textTheme.display3,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: answers
                            .map((item) => AnswerWidget(
                                  answer: item,
                                  index: index,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
