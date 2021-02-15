import 'package:clipboard/clipboard.dart';
import 'package:examapp/controllers/classroom_controller.dart';
import 'package:examapp/controllers/exam_controller.dart';
import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/model/classroom.dart';
import 'package:examapp/model/current_user.dart';
import 'package:examapp/model/exam.dart';
import 'package:examapp/model/student.dart';
import 'package:examapp/routes/application.dart';
import 'package:examapp/service/auth_service.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/views/home_view/create_classroom_view.dart';
import 'package:examapp/views/home_view/create_exam_view.dart';
import 'package:examapp/views/home_view/create_question_view.dart';
import 'package:examapp/views/home_view/participants_view.dart';
import 'package:examapp/widget/custom_fade_transition.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/loading_view.dart';
import 'package:examapp/widget/responsive_widget.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstructorHomeView extends StatelessWidget {
  const InstructorHomeView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<ClassroomController>().getUserClassrooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CustomFadeTransition(
              child: Container(
                height: context.dynamicWidth(1),
                width: ResponsiveWidget.isLargeScreen(context)
                    ? context.dynamicWidth(0.4)
                    : ResponsiveWidget.isMediumScreen(context)
                        ? context.dynamicWidth(0.5)
                        : context.dynamicWidth(0.7),
                child: PageView(
                  scrollDirection: Axis.vertical,
                  physics:
                      ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                  controller:
                      context.read<ClassroomController>().pageController,
                  pageSnapping: false,
                  children: [
                    body(context, snapshot.data),
                    PageView(
                      scrollDirection: Axis.horizontal,
                      controller:
                          context.read<ClassroomController>().pageController2,
                      physics:
                          ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                      children: [
                        classroom(context),
                        CreateQuestionView(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget classroom(BuildContext context) {
    Classroom classroom =
        context.watch<ClassroomController>().selectedClassroom;
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidth(0.05), vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context
                        .read<ClassroomController>()
                        .pageController
                        .animateToPage(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOutSine);
                  },
                  child: RichText(
                    maxLines: 1,
                    text: TextSpan(
                        style: context.themeData.textTheme.display3.copyWith(
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                        children: [
                          TextSpan(text: "Back to Classrooms"),
                        ]),
                  ),
                ),
                OutlineButton(
                  borderSide: BorderSide(width: 2),
                  onPressed: () {
                    context
                        .read<ClassroomController>()
                        .pageController2
                        .animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOutSine);
                    /*Navigator.push(context,
                        TransparentRoute(builder: (context) => CreateExamView()));*/
                  },
                  child: classCard(context, "+ Create A Exam"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${classroom.name}  ",
                  style: context.themeData.textTheme.display1,
                ),
                InkWell(
                  onTap: () {
                    FlutterClipboard.copy("${classroom.id}");
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Access code copied to clipboard")));
                  },
                  child: Text(
                    "Copy to clip board the access code",
                    style: context.themeData.textTheme.display1.copyWith(
                        color: Colors.blue[400],
                        decoration: TextDecoration.underline,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Exams",
              style: context.themeData.textTheme.display3
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            FutureBuilder<List<Exam>>(
                future: context
                    .read<ClassroomController>()
                    .getClassroomExams(classroom.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Exam> exams = snapshot.data ?? [];
                    return GridView.count(
                      crossAxisCount: (context.dynamicWidth(1) / 400.0).floor(),
                      childAspectRatio: 1.50,
                      crossAxisSpacing: 20,
                      controller: new ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: exams.map((exam) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                left: 2, top: 20.0, bottom: 20, right: 2),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(EdgeInsets.zero)),
                              onPressed: () {},
                              child: examCard(context, exam),
                            ));
                      }).toList(),
                    );
                  }
                  return SizedBox(
                      height: 500,
                      child: Center(child: CircularProgressIndicator()));
                }),
          ])),
    );
  }

  Container examCard(BuildContext context, Exam exam) {
    return new Container(
      padding: EdgeInsets.symmetric(
          vertical: context.dynamicHeight(0.01),
          horizontal: context.dynamicWidth(0.01)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 20),
          Expanded(
            flex: 20,
            child: Center(
              child: Text(
                exam.title ?? " ",
                style: context.themeData.textTheme.display3,
              ),
            ),
          ),
          Spacer(flex: 20),
          Expanded(
            flex: 15,
            child: Text(
              "Start Date: ${exam.startDate.toMyString}",
              style: context.themeData.textTheme.display3
                  .copyWith(color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 15,
            child: Text(
              "Due Date: ${exam.dueDate.toMyString}",
              style: context.themeData.textTheme.display3
                  .copyWith(color: Colors.grey),
            ),
          ),
          Expanded(
              flex: 10,
              child: Align(
                alignment: Alignment.centerRight,
                child: examStatus(context, exam),
              )),
        ],
      ),
    );
  }

  Widget examStatus(BuildContext context, Exam exam) {
    bool isEnded = exam.dueDate.isBefore(DateTime.now());

    if (isEnded) {
      return RaisedButton(
        color: Colors.green,
        onPressed: () async {
          Navigator.push(
              context, TransparentRoute(builder: (context) => LoadingView()));
          List<Student> students =
              await context.read<ExamController>().getExamParticipants(exam);

          Navigator.pop(context);
          Navigator.push(
              context,
              TransparentRoute(
                  builder: (context) => ParticipantsView(
                        students: students,
                        exam: exam,
                      )));
        },
        child: Text(
          "View Result",
          style: context.themeData.textTheme.display3
              .copyWith(color: Colors.white),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget body(BuildContext context, List<Classroom> classrooms) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidth(0.05), vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                        style: context.themeData.textTheme.display1
                            .copyWith(color: Colors.black),
                        children: [
                          TextSpan(text: "Welcome, "),
                          TextSpan(
                            text:
                                "${CurrentUser.currentUser.firstName ?? "Guest"}",
                            style: context.themeData.textTheme.display1
                                .copyWith(color: Colors.black),
                          ),
                        ]),
                  ),
                  OutlineButton(
                    borderSide: BorderSide(width: 2),
                    onPressed: () {
                      Navigator.push(
                          context,
                          TransparentRoute(
                              builder: (context) => CreateClassroomView()));
                    },
                    child: classCard(context, "+ Create A Classroom"),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Here, I Found Your Classrooms",
                style: context.themeData.textTheme.display3
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 20,
              ),
              GridView.count(
                crossAxisCount: (context.dynamicWidth(1) / 400.0).floor(),
                childAspectRatio: 1.50,
                crossAxisSpacing: 20,
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: classrooms.map((classroom) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 2, top: 20.0, bottom: 20, right: 2),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.zero)),
                        onPressed: () {
                          context
                              .read<ClassroomController>()
                              .selectedClassroom = classroom;
                          context
                              .read<ClassroomController>()
                              .pageController
                              .animateToPage(1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeOutSine);
                        },
                        child: classCard(context, classroom.name),
                      ));
                }).toList(),
              ),
            ],
          )),
    );
  }

  Container classCard(BuildContext context, String title) {
    return new Container(
      padding: EdgeInsets.symmetric(
          vertical: context.dynamicHeight(0.01),
          horizontal: context.dynamicWidth(0.01)),
      child: new Text(
        title ?? "Unknown",
        style: context.themeData.textTheme.display3,
      ),
    );
  }
}
