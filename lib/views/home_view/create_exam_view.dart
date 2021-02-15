import 'package:examapp/controllers/classroom_controller.dart';
import 'package:examapp/controllers/create_exam_controller.dart';
import 'package:examapp/controllers/create_question_controller.dart';
import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class CreateExamView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              context.read<CreateExamController>().resetData();
              Navigator.pop(context);
            },
            child: Container(
              height: context.dynamicHeight(1),
              width: context.dynamicWidth(1),
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                width: 500,
                padding:
                    EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 50),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.01,
                    blurRadius: 4,
                    offset: Offset(1, 0),
                  ),
                ], color: Colors.white),
                child: Form(
                  key: context.read<CreateExamController>().formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1) Enter exam name",
                        style: context.themeData.textTheme.display3,
                      ),
                      TextFormField(
                        validator: (value) =>
                            context.read<CreateExamController>().validateName(),
                        decoration: new InputDecoration(
                          hintText: "",
                          errorStyle: context
                              .themeData.inputDecorationTheme.errorStyle
                              .copyWith(
                            color: Colors.red.withOpacity(0.8),
                          ),
                        ),
                        onChanged: (String value) {
                          context.read<CreateExamController>().name = value;
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "2) Select start date",
                        style: context.themeData.textTheme.display3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime:
                                      DateTime(DateTime.now().year + 5, 12, 12),
                                  onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                context.read<CreateExamController>().startDate =
                                    date;
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.tr);
                            },
                            child: Text(
                              "Select",
                              style: context.themeData.textTheme.display3,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          context.watch<CreateExamController>().dateToString(
                                      context
                                          .read<CreateExamController>()
                                          .startDate) !=
                                  ""
                              ? Text(
                                  "Start Date: " +
                                      context
                                          .watch<CreateExamController>()
                                          .dateToString(context
                                              .read<CreateExamController>()
                                              .startDate),
                                  style: context.themeData.textTheme.display3
                                      .copyWith(
                                          color: context.themeData.accentColor))
                              : SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "3) Select due date",
                        style: context.themeData.textTheme.display3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime:
                                      DateTime(DateTime.now().year + 5, 12, 12),
                                  onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                context.read<CreateExamController>().dueDate =
                                    date;
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.tr);
                            },
                            child: Text(
                              "Select",
                              style: context.themeData.textTheme.display3,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          context.watch<CreateExamController>().dateToString(
                                      context
                                          .read<CreateExamController>()
                                          .dueDate) !=
                                  ""
                              ? Text(
                                  "Due Date: " +
                                      context
                                          .watch<CreateExamController>()
                                          .dateToString(context
                                              .read<CreateExamController>()
                                              .dueDate),
                                  style: context.themeData.textTheme.display3
                                      .copyWith(
                                          color: context.themeData.accentColor))
                              : SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                color: context.themeData.accentColor,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            bool isValid = context
                                .read<CreateExamController>()
                                .isCreateExamValidate();
                            if (isValid) {
                              var questions = context
                                  .read<CreateQuestionController>()
                                  .questionAnswerList;
                              var classroom = context
                                  .read<ClassroomController>()
                                  .selectedClassroom;
                              Navigator.push(
                                  context,
                                  TransparentRoute(
                                      builder: (context) => LoadingView()));
                              await context
                                  .read<CreateExamController>()
                                  .createExam(context, questions, classroom);
                              Navigator.pop(context);

                              Navigator.pop(context);
                              context.read<HomeController>().homeSelectedView =
                                  HomeSelectedView.Instructor;
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Fields are not valid")));
                            }
                          },
                          child: Text(
                            "Create",
                            style:
                                context.themeData.textTheme.display3.copyWith(
                              color: context.themeData.accentColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
