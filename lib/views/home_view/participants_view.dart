import 'package:examapp/controllers/base_controller.dart';
import 'package:examapp/controllers/classroom_controller.dart';
import 'package:examapp/controllers/exam_controller.dart';
import 'package:examapp/model/exam.dart';
import 'package:examapp/model/student.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/views/exam_view.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParticipantsView extends StatelessWidget {
  final List<Student> students;
  final Exam exam;
  const ParticipantsView({Key key, this.students, this.exam}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
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
              child: Container(
                padding: EdgeInsets.all(20),
                height: 550,
                width: 440,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: students.length == 0
                    ? Center(
                        child: Text(
                        "I can't find any participant",
                        style: context.themeData.textTheme.display3,
                      ))
                    : ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              child: ListTile(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  TransparentRoute(
                                      builder: (context) => LoadingView()));
                              await context
                                  .read<ExamController>()
                                  .getExamData(exam.id);
                              await context
                                  .read<ExamController>()
                                  .getUserAnswers(
                                      exam.id, students[index].userId);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ExamView(exam.id, isPreview: true)));
                            },
                            title: Text(
                              "${students[index].firstName} ${students[index].lastName}",
                              style: context.themeData.textTheme.display3,
                            ),
                            subtitle: Text(
                              "${students[index].email}",
                              style: context.themeData.textTheme.display3,
                            ),
                            trailing: Text(
                              "Show Result",
                              style: context.themeData.textTheme.display3
                                  .copyWith(
                                      color: context.themeData.accentColor),
                            ),
                          ));
                        },
                      ),
              ),
            ),
          ],
        ));
  }
}
