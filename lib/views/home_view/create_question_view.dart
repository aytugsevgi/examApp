import 'package:examapp/controllers/create_question_controller.dart';
import 'package:examapp/utils/extension.dart';
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
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.dynamicWidth(0.05), vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 380,
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
                            decoration: new InputDecoration(
                              hintText: "",
                              errorStyle: context
                                  .themeData.inputDecorationTheme.errorStyle
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
                      onTap: () {}),
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
        ],
      ),
    );
  }

  Widget answerWidget(BuildContext context, int index) {
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
            decoration: new InputDecoration(
              hintText: "",
              errorStyle:
                  context.themeData.inputDecorationTheme.errorStyle.copyWith(
                color: Colors.red.withOpacity(0.8),
              ),
            ),
            /*onChanged: (String value) {
                                          Provider.of<LoginController>(context,
                                                  listen: false)
                                              .email = value;
                                        },*/
          ),
        ),
      ],
    );
  }
}
