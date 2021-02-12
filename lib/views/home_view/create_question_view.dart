import 'package:examapp/controllers/create_question_controller.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/views/home_view/create_exam_view.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/responsive_widget.dart';
import 'package:examapp/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateQuestionView extends StatefulWidget {
  @override
  _CreateQuestionViewState createState() => _CreateQuestionViewState();
}

class _CreateQuestionViewState extends State<CreateQuestionView> {
  @override
  Widget build(BuildContext context) {
    int questionIndex = 0;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(0.05), vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.dynamicHeight(0.5),
                  width: 500,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 72,
                          child: Row(
                            children: [
                              Text(
                                "Question Title",
                                style: context.themeData.textTheme.display3
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  /*validator: (value) => Provider.of<LoginController>(
                                                        context,
                                                        listen: false)
                                                    .validateEmail(),*/
                                  controller: context
                                      .read<CreateQuestionController>()
                                      .controllers
                                      .last,
                                  decoration: new InputDecoration(
                                    hintText: "",
                                    errorStyle: context.themeData
                                        .inputDecorationTheme.errorStyle
                                        .copyWith(
                                      color: Colors.red.withOpacity(0.8),
                                    ),
                                  ),
                                  onChanged: (String value) {
                                    context
                                        .read<CreateQuestionController>()
                                        .questionTitle = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        answerWidget(context, 0),
                        answerWidget(context, 1),
                        answerWidget(context, 2),
                        answerWidget(context, 3),
                        answerWidget(context, 4),
                        SizedBox(height: 20),
                        SubmitButton(
                            colors: [
                              context.themeData.accentColor,
                              context.themeData.accentColor
                            ],
                            child: Text("Add Question",
                                style: context.themeData.textTheme.display3
                                    .copyWith(color: Colors.white)),
                            onTap: () {
                              context
                                  .read<CreateQuestionController>()
                                  .saveQuestion();
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: context.dynamicWidth(1),
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                    children: context
                        .watch<CreateQuestionController>()
                        .questionAnswerList
                        .map((question) {
                  questionIndex++;
                  return savedQuestions(questionIndex, question.keys.first,
                      question.values.first);
                }).toList()),
                SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment(0.9, 0.9),
          child: context
                      .watch<CreateQuestionController>()
                      .questionAnswerList
                      .length >
                  0
              ? FloatingActionButton.extended(
                  backgroundColor: context.themeData.primaryColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        TransparentRoute(
                            builder: (context) => CreateExamView()));
                  },
                  label: Text(
                    "Create",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget savedQuestions(
      int index, String title, List<Map<String, bool>> answers) {
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
                        "Q$index)  $title",
                        style: context.themeData.textTheme.display3,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: answers
                            .map((item) => savedAnswerWidget(
                                item.values.first, item.keys.first))
                            .toList(),
                      ),
                      Align(
                          alignment: Alignment(1, 0.8),
                          child: OutlinedButton(
                              onPressed: () {
                                context
                                    .read<CreateQuestionController>()
                                    .deleteQuestion(index - 1);
                              },
                              child: Text(
                                "DELETE",
                                style: TextStyle(color: Colors.red),
                              )))
                    ],
                  ),
                ],
              ))),
    );
  }

  Widget answerWidget(
    BuildContext context,
    int index,
  ) {
    return Row(
      children: [
        Checkbox(
            activeColor: Colors.green,
            value: context.watch<CreateQuestionController>().answerKey[index],
            onChanged: (value) {
              context
                  .read<CreateQuestionController>()
                  .changeCorrectAnswer(index);
            }),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 350,
          child: TextFormField(
            /*validator: (value) => Provider.of<LoginController>(
                                                context,
                                                listen: false)
                                            .validateEmail(),*/
            controller:
                context.read<CreateQuestionController>().controllers[index],
            decoration: new InputDecoration(
              hintText: "",
              errorStyle:
                  context.themeData.inputDecorationTheme.errorStyle.copyWith(
                color: Colors.red.withOpacity(0.8),
              ),
            ),
            onChanged: (String value) {
              context.read<CreateQuestionController>().answer[index] = value;
            },
          ),
        ),
      ],
    );
  }

  Widget savedAnswerWidget(bool isCorrect, String answer) {
    return Row(
      children: [
        Checkbox(
            activeColor: Colors.green, value: isCorrect, onChanged: (value) {}),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 350,
          child: Text(
            answer,
            style: context.themeData.textTheme.display3,
          ),
        ),
      ],
    );
  }
}
